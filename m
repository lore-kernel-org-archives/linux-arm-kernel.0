From: dedekind1@gmail.com (Artem Bityutskiy)
Date: Fri, 09 Nov 2012 17:29:11 +0200
Subject: [PATCH] dma: add new DMA control commands
In-Reply-To: <507FBDF1.5050602@freescale.com>
References: <1350538335-29026-1-git-send-email-b32955@freescale.com>
 <201210180914.58527.marex@denx.de> <507FB495.7050104@freescale.com>
 <201210181016.06782.marex@denx.de> <507FBDF1.5050602@freescale.com>
Message-ID: <1352474951.1814.40.camel@sauron.fi.intel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, 2012-10-18 at 16:29 +0800, Huang Shijie wrote:
> ? 2012?10?18? 16:16, Marek Vasut ??:
> > So we can't stream data from the chip? About time to adjust the MTD framework to
> > allow that. Maybe implement a command queue?
> >
> 
> to Artem & David:
>     is this possible to stream the data out with a command queue?

Well, I think there was no HW which supported reading multiple pages
with DMA before, are your sure yours support this? Usually reading a
NAND page consists of 2 phases - loading the NAND array contents to a
controller buffer, and then copying that to RAM. And the second part is
something people sometimes do with DMA, AFAIU.

If your HW supports this, sure the MTD framework can be re-worked. Or
you may write your own 'mtd->_read()' / 'mtd->_write()' implementation.

-- 
Best Regards,
Artem Bityutskiy
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: This is a digitally signed message part
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20121109/12358221/attachment.sig>
