From: thierry.reding@avionic-design.de (Thierry Reding)
Date: Thu, 4 Oct 2012 20:29:31 +0200
Subject: [PATCH] pwm: Get rid of HAVE_PWM
In-Reply-To: <506DA487.9070400@metafoo.de>
References: <1349330819-11924-1-git-send-email-thierry.reding@avionic-design.de>
 <506DA487.9070400@metafoo.de>
Message-ID: <20121004182931.GA7228@avionic-0098.mockup.avionic-design.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Oct 04, 2012 at 05:00:23PM +0200, Lars-Peter Clausen wrote:
> On 10/04/2012 08:06 AM, Thierry Reding wrote:
> > [...]
> > diff --git a/arch/mips/Kconfig b/arch/mips/Kconfig
> > index 331d574..b38f23d 100644
> > --- a/arch/mips/Kconfig
> > +++ b/arch/mips/Kconfig
> > @@ -219,7 +219,8 @@ config MACH_JZ4740
> >  	select GENERIC_GPIO
> >  	select ARCH_REQUIRE_GPIOLIB
> >  	select SYS_HAS_EARLY_PRINTK
> > -	select HAVE_PWM
> > +	select PWM
> > +	select PWM_JZ4740
> >  	select HAVE_CLK
> >  	select GENERIC_IRQ_CHIP
> 
> I'm not sure if this is such a good idea, not all jz4740 based board
> necessarily require PWM.

This really only restores previous behaviour. But I agree that this is
potentially not what we want. Maybe we should just not select this for
any boards but rather leave it up to some default configuration. If so
the patch can be made simpler by just removing the HAVE_PWM entries.

Thierry
-------------- next part --------------
A non-text attachment was scrubbed...
Name: not available
Type: application/pgp-signature
Size: 836 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20121004/008832bf/attachment.sig>
