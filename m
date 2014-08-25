From: jonas.jensen@gmail.com (Jonas Jensen)
Date: Mon, 25 Aug 2014 16:23:09 +0200
Subject: [PATCH v4 2/2] net: moxa: replace build_skb() with
 netdev_alloc_skb_ip_align() / memcpy()
In-Reply-To: <CAHXqBFJ3bWW8NVYcjxLnkk=6qxcRv75iCuBLrHuF91wxcL=61g@mail.gmail.com>
References: <1408459784-9385-1-git-send-email-jonas.jensen@gmail.com>
 <1408459784-9385-2-git-send-email-jonas.jensen@gmail.com>
 <CAHXqBFJ3bWW8NVYcjxLnkk=6qxcRv75iCuBLrHuF91wxcL=61g@mail.gmail.com>
Message-ID: <CACmBeS010Vbgx8wz9YkiQGi4gF6JNQqVRcgYtkCKGqvNs4sopA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Thanks for giving feedback.

On 21 August 2014 23:43, Micha? Miros?aw <mirqus@gmail.com> wrote:
> This has implicit: if (!skb) BUG(); There should probably be a return
> or continue inside the if (!skb).

Fixed, see v6 update (broken out to separate patch) which now includes
increment to RX head counter

> dma_sync_single_for_device() is not needed here as CPU does not and
> should not write to the DMA_FROM_DEVICE mapping.

Fixed, this was also broken out, dma_sync_single_for_device() moved to TX path.
Maybe someone can verify this is the correct thing to do.


Regards,

   Jonas
