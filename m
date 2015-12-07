From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Mon, 7 Dec 2015 21:16:56 +0000
Subject: [PATCH v2 2/3] soc: dove: add legacy support to PMU driver
In-Reply-To: <87d1ui9da0.fsf@free-electrons.com>
References: <E1a5j6Q-000879-GO@rmk-PC.arm.linux.org.uk>
 <87r3iy9er5.fsf@free-electrons.com>
 <87mvtm9ejc.fsf@free-electrons.com>
 <87d1ui9da0.fsf@free-electrons.com>
Message-ID: <20151207211656.GZ8644@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Dec 07, 2015 at 10:09:27PM +0100, Gregory CLEMENT wrote:
> Hi Russell,
>  
>  On lun., d?c. 07 2015, Gregory CLEMENT <gregory.clement@free-electrons.com> wrote:
> 
> >  On lun., d?c. 07 2015, Gregory CLEMENT <gregory.clement@free-electrons.com> wrote:
> >
> >> Hi Russell,
> >>  
> >>  On lun., d?c. 07 2015, Russell King <rmk+kernel@arm.linux.org.uk> wrote:
> >>
> >>> Add support for legacy non-DT Dove to the PMU driver, so that we can
> >>> transition the legacy support over.
> >>>
> >>> Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>
> >>
> >> Applied on mvebu/soc (and fixed a conflict in drivers/soc/Makefile)
> >
> > Eventually I applied it on mvebu/drivers rather than mvebu/soc
> 
> Actually I was too optimitic. It doesn't build on mvebu/soc (based on
> 4.4-rc1).
> 
> First pm_genpd_poweroff_unused() had been removed since bb4b72fc63d4 "PM
> / Domains: Remove pm_genpd_poweroff_unused() API ".
> 
> Then, even by removing the call this function to go furthetr I got other
> errors such as: drivers/soc/dove/pmu.c:344:46: error:
> ?IRQ_DOVE_PMU_START? undeclared (first use in this function)

I guess that's with Arnd's patches?  Sigh, okay, it'll have to wait yet
_another_ kernel cycle then.

-- 
RMK's Patch system: http://www.arm.linux.org.uk/developer/patches/
FTTC broadband for 0.8mile line: currently at 9.6Mbps down 400kbps up
according to speedtest.net.
