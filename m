From: thierry.reding@avionic-design.de (Thierry Reding)
Date: Mon, 21 Jan 2013 08:03:01 +0100
Subject: [PATCH v2 1/2] ARM: shmobile: sh73a0: Use generic irqchip_init()
In-Reply-To: <20130121005439.GF19062@verge.net.au>
References: <1358493373-28722-1-git-send-email-thierry.reding@avionic-design.de>
 <20130121005439.GF19062@verge.net.au>
Message-ID: <20130121070301.GB15508@avionic-0098.adnet.avionic-design.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Jan 21, 2013 at 09:54:39AM +0900, Simon Horman wrote:
> On Fri, Jan 18, 2013 at 08:16:12AM +0100, Thierry Reding wrote:
> > The asm/hardware/gic.h header does no longer exist and the corresponding
> > functionality was moved to linux/irqchip.h and linux/irqchip/arm-gic.h
> > respectively. gic_handle_irq() and of_irq_init() are no longer available
> > either and have been replaced by irqchip_init().
> 
> asm/hardware/gic.h Seems to still exist in Linus's tree.
> Could you let me know which tree of which branch I should depend on
> in order to apply this change?

I found this when doing an automated build over all ARM defconfigs on
linux-next.

Commit 520f7bd73354f003a9a59937b28e4903d985c420 "irqchip: Move ARM gic.h
to include/linux/irqchip/arm-gic.h" moved the file and was merged
through Olof Johansson's next/cleanup and for-next branches.

Adding Olof on Cc since I'm not quite sure myself about how this is
handled.

Thierry
-------------- next part --------------
A non-text attachment was scrubbed...
Name: not available
Type: application/pgp-signature
Size: 836 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20130121/440d8211/attachment.sig>
