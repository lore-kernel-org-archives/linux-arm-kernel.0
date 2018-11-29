From: hayashi.kunihiko@socionext.com (Kunihiko Hayashi)
Date: Thu, 29 Nov 2018 10:51:39 +0900
Subject: [PATCH] arm64: mm: define NET_IP_ALIGN to 0
In-Reply-To: <20181128120455.GB24868@arm.com>
References: <20181128150225.8D30.4A936039@socionext.com>
 <20181128120455.GB24868@arm.com>
Message-ID: <20181129105139.F7FE.4A936039@socionext.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Will,

On Wed, 28 Nov 2018 12:04:56 +0000 <will.deacon@arm.com> wrote:

> Hi Kunihiko,
> 
> On Wed, Nov 28, 2018 at 03:02:25PM +0900, Kunihiko Hayashi wrote:
> > I found that arm64 board that had AVE controller couldn't receive
> > any packets after this change.
> > 
> > AVE controller (hardware) forces to ignore lower 2bits of buffer start address,
> > that is, the address is always aligned with 4bytes.
> > And more, the controller puts received datas with "2byte headroom" [1].
> > 
> > [1] https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/drivers/net/ethernet/socionext/sni_ave.c#n591
> 
> Is this "2-byte headroom" a fixed property of the hardware? If so, it seems
> like you should just be using 2 instead of NET_IP_ALIGN when calculating the
> DMA address of the skb buffer.

Yes, 2-byte headroom is a hardware specific property.
I've already calculated the DMA address with NET_IP_ALIGN, so I'll replace it
with my own macro as a hardware specific value.

Thank you,

---
Best Regards,
Kunihiko Hayashi
