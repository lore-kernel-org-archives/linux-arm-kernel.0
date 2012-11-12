From: heiko@sntech.de (Heiko =?iso-8859-1?q?St=FCbner?=)
Date: Mon, 12 Nov 2012 19:15:39 +0100
Subject: [RFC PATCH 1/4] ARM: S3C24XX: move s3c24xx-irq to drivers/irqchip
In-Reply-To: <50A12C63.2000609@wwwdotorg.org>
References: <201211121446.30167.heiko@sntech.de>
 <201211121447.49977.heiko@sntech.de> <50A12C63.2000609@wwwdotorg.org>
Message-ID: <201211121915.41722.heiko@sntech.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Am Montag, 12. November 2012, 18:05:39 schrieb Stephen Warren:
> On 11/12/2012 06:47 AM, Heiko St?bner wrote:
> > Removes another part from plat-s3c24xx and also enables further
> > improvements happening in the correct location.
> > 
> > Signed-off-by: Heiko Stuebner <heiko@sntech.de>
> > ---
> > 
> >  arch/arm/Kconfig                                   |    1 +
> >  arch/arm/plat-s3c24xx/Makefile                     |    1 -
> >  drivers/irqchip/Kconfig                            |    3 +++
> >  drivers/irqchip/Makefile                           |    1 +
> >  .../irq.c => drivers/irqchip/irq-s3c24xx.c         |    0
> >  5 files changed, 5 insertions(+), 1 deletions(-)
> >  rename arch/arm/plat-s3c24xx/irq.c => drivers/irqchip/irq-s3c24xx.c
> >  (100%)
> 
> Presumably there's a header file somewhere that defines the interface to
> irq-s3c24xx.c that other code in arch/arm/plat-s3c24xx is using to
> initialize it. That header should be moved somewhere public (i.e.
> outside {mach,plat}-*/include/{mach,plat}). However, you then end up
> with a header file per IRQ driver in that public location. So, Thomas
> 
> Petazzoni started working on a solution for that:
> > http://lists.arm.linux.org.uk/lurker/message/20121027.164514.11eb86db.en.
> > html

cool, thanks for the pointer :-) .

For the headers, yes they are present and still in mach/plat. My intention was 
to first clean it up and then move the remaing necessary header.

I'm not sure what is the policy for adding stuff to drivers/irqchip (dt-
only?), because _all_ s3c24xx subtypes using devicetree seems very very far in 
the future, if at all.

So when thinking a bit more about it, it might be better to keep the irq code 
in arch/arm for the time being?

Because non-dt init code will probably be necessary for a lot more time.


Heiko
