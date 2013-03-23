From: linux@prisktech.co.nz (Tony Prisk)
Date: Sun, 24 Mar 2013 07:04:51 +1300
Subject: [PATCHv2 2/7] arm: vt8500: Increase available GPIOs on arch-vt8500
In-Reply-To: <20130323104402.GM4977@n2100.arm.linux.org.uk>
References: <1364015633-18580-1-git-send-email-linux@prisktech.co.nz>
 <1364015633-18580-3-git-send-email-linux@prisktech.co.nz>
 <20130323104402.GM4977@n2100.arm.linux.org.uk>
Message-ID: <1364061891.27511.2.camel@gitbox>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, 2013-03-23 at 10:44 +0000, Russell King - ARM Linux wrote:
> On Sat, Mar 23, 2013 at 06:13:48PM +1300, Tony Prisk wrote:
> > With the inclusion of the pin control driver, more GPIO pins have been
> > identified on the arch-vt8500 SoCs requiring an increase in the available
> > GPIOs.
> > 
> > Signed-off-by: Tony Prisk <linux@prisktech.co.nz>
> > ---
> >  arch/arm/Kconfig |    3 ++-
> >  1 file changed, 2 insertions(+), 1 deletion(-)
> > 
> > diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
> > index 5b71469..c5dd0c2 100644
> > --- a/arch/arm/Kconfig
> > +++ b/arch/arm/Kconfig
> > @@ -1661,9 +1661,10 @@ config ARCH_NR_GPIO
> >  	int
> >  	default 1024 if ARCH_SHMOBILE || ARCH_TEGRA
> >  	default 355 if ARCH_U8500
> > +	default 352 if ARCH_VT8500
> >  	default 264 if MACH_H4700
> >  	default 512 if SOC_OMAP5
> > -	default 288 if ARCH_VT8500 || ARCH_SUNXI
> > +	default 288 if ARCH_SUNXI
> 
> Note that the ordering of this has been fixed in -rc, so the above will
> cause a merge conflict.  You may wish to consider basing your patch set
> on a later kernel version.

Thanks Russell,

I didn't think to check for -rc3 just yet. My bad. Will rebase to -rc3+
before I post the next version.

Regards
Tony P
