From: msalter@redhat.com (Mark Salter)
Date: Thu, 01 Sep 2011 08:36:34 -0400
Subject: [PATCH 1/3] add dma_coherent_write_sync to DMA API
In-Reply-To: <CAHXqBFJ6tEkn+iW3ZBAiWu5Sx9y9MQdnJt5Gfnv5Xc3UB78uLw@mail.gmail.com>
References: <1314826214-22428-1-git-send-email-msalter@redhat.com>
	<1314826214-22428-2-git-send-email-msalter@redhat.com>
	<CAHXqBFJ6tEkn+iW3ZBAiWu5Sx9y9MQdnJt5Gfnv5Xc3UB78uLw@mail.gmail.com>
Message-ID: <1314880595.1439.13.camel@deneb.redhat.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, 2011-09-01 at 11:57 +0200, Micha? Miros?aw wrote:
> BTW, if there's no time limit on write buffers flushing, or if write
> buffers can cause reordering of the writes, then the memory accesses
> need to be managed just like non-DMA-coherent memory. So what differs
> then in DMA-coherent vs non-DMA-coherent mappings then?

My understanding is that ordering is preserved, but an ARM guy should
probably verify that.

IIUC, the write buffers could hold data indefinitely. As a practical
matter other writes needing to go out to memory will force buffered
data out eventually. Again, this is my understanding which may be
faulty. My feeling is that this extended write buffering makes it
hard to call the dma memory fully coherent, but other limitations on
ARMv7 make the buffering hard to avoid.

--Mark
