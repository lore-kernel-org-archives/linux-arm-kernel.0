From: catalin.marinas@arm.com (Catalin Marinas)
Date: Tue, 6 Sep 2011 15:30:42 +0100
Subject: [PATCH 1/3] add dma_coherent_write_sync to DMA API
In-Reply-To: <1314880595.1439.13.camel@deneb.redhat.com>
References: <1314826214-22428-1-git-send-email-msalter@redhat.com>
	<1314826214-22428-2-git-send-email-msalter@redhat.com>
	<CAHXqBFJ6tEkn+iW3ZBAiWu5Sx9y9MQdnJt5Gfnv5Xc3UB78uLw@mail.gmail.com>
	<1314880595.1439.13.camel@deneb.redhat.com>
Message-ID: <CAHkRjk7QWCkKKT8BErRsS_ZASChOyGuh04PM2qP3pQnp+KhJVw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

(coming late to this thread due to holidays)

2011/9/1 Mark Salter <msalter@redhat.com>:
> On Thu, 2011-09-01 at 11:57 +0200, Micha? Miros?aw wrote:
>> BTW, if there's no time limit on write buffers flushing, or if write
>> buffers can cause reordering of the writes, then the memory accesses
>> need to be managed just like non-DMA-coherent memory. So what differs
>> then in DMA-coherent vs non-DMA-coherent mappings then?
>
> My understanding is that ordering is preserved, but an ARM guy should
> probably verify that.

On ARMv6 onwards the coherent DMA is Normal Non-cacheable memory and
this is buffered and can be reordered.

-- 
Catalin
