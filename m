From: horms@verge.net.au (Simon Horman)
Date: Tue, 22 Jan 2013 09:18:54 +0900
Subject: [PATCH v2 1/2] ARM: shmobile: sh73a0: Use generic irqchip_init()
In-Reply-To: <20130121070301.GB15508@avionic-0098.adnet.avionic-design.de>
References: <1358493373-28722-1-git-send-email-thierry.reding@avionic-design.de>
 <20130121005439.GF19062@verge.net.au>
 <20130121070301.GB15508@avionic-0098.adnet.avionic-design.de>
Message-ID: <20130122001854.GB16757@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Jan 21, 2013 at 08:03:01AM +0100, Thierry Reding wrote:
> On Mon, Jan 21, 2013 at 09:54:39AM +0900, Simon Horman wrote:
> > On Fri, Jan 18, 2013 at 08:16:12AM +0100, Thierry Reding wrote:
> > > The asm/hardware/gic.h header does no longer exist and the corresponding
> > > functionality was moved to linux/irqchip.h and linux/irqchip/arm-gic.h
> > > respectively. gic_handle_irq() and of_irq_init() are no longer available
> > > either and have been replaced by irqchip_init().
> > 
> > asm/hardware/gic.h Seems to still exist in Linus's tree.
> > Could you let me know which tree of which branch I should depend on
> > in order to apply this change?
> 
> I found this when doing an automated build over all ARM defconfigs on
> linux-next.
> 
> Commit 520f7bd73354f003a9a59937b28e4903d985c420 "irqchip: Move ARM gic.h
> to include/linux/irqchip/arm-gic.h" moved the file and was merged
> through Olof Johansson's next/cleanup and for-next branches.
> 
> Adding Olof on Cc since I'm not quite sure myself about how this is
> handled.

Thanks, I'm not quite sure either.
