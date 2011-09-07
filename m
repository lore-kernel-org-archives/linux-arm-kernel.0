From: jean.pihet@newoldbits.com (Jean Pihet)
Date: Wed, 7 Sep 2011 21:10:04 +0200
Subject: [PATCH 00/10] OMAP: voltage cleanup part B: VC cleanup
In-Reply-To: <1314640192-2518-1-git-send-email-khilman@ti.com>
References: <1314640192-2518-1-git-send-email-khilman@ti.com>
Message-ID: <CAORVsuVX+AWQJHeHu2aTWNHwmp1eeQKVo2xeNjiGQWMbvKX2ng@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Kevin,

On Mon, Aug 29, 2011 at 7:49 PM, Kevin Hilman <khilman@ti.com> wrote:
> This series focuses on cleanup and better abstraction in the voltage
> controller (VC) layer.
>
> Available in the pm-wip/voltdm_b branch of my linux-omap-pm tree
> git://git.kernel.org/pub/scm/linux/kernel/git/khilman/linux-omap-pm.git
>
> Applies on v3.1-rc3 + the part A series (pm-wip/voltdm_a branch)
>
> Kevin
>

Ok after review.

FWIW:
Acked-by: Jean Pihet <j-pihet@ti.com>

Regards,
Jean

>
>
> Kevin Hilman (10):
> ?OMAP3+: VC: cleanup i2c slave address configuration
> ?OMAP3+: VC: cleanup PMIC register address configuration
> ?OMAP3+: VC bypass: use fields from VC struct instead of PMIC info
> ?OMAP3+: VC: cleanup voltage setup time configuration
> ?OMAP3+: VC: move on/onlp/ret/off command configuration into common
> ? ?init
> ?OMAP3+: VC: abstract out channel configuration
> ?OMAP3+: voltage domain: move PMIC struct from vdd_info into struct
> ? ?voltagedomain
> ?OMAP3+: VC: make I2C config programmable with PMIC-specific settings
> ?OMAP3+: PM: VC: handle mutant channel config for OMAP4 MPU channel
> ?OMAP3+: VC: use last nominal voltage setting to get current_vsel
>
> ?arch/arm/mach-omap2/omap_twl.c ? ? ? ? ? ? ? ?| ? 32 ++--
> ?arch/arm/mach-omap2/vc.c ? ? ? ? ? ? ? ? ? ? ?| ?248 ++++++++++++++++++-------
> ?arch/arm/mach-omap2/vc.h ? ? ? ? ? ? ? ? ? ? ?| ? 35 +++-
> ?arch/arm/mach-omap2/vc3xxx_data.c ? ? ? ? ? ? | ? 13 +-
> ?arch/arm/mach-omap2/vc44xx_data.c ? ? ? ? ? ? | ? 18 ++-
> ?arch/arm/mach-omap2/voltage.c ? ? ? ? ? ? ? ? | ? 29 ++--
> ?arch/arm/mach-omap2/voltage.h ? ? ? ? ? ? ? ? | ? 29 ++--
> ?arch/arm/mach-omap2/voltagedomains3xxx_data.c | ? ?8 +-
> ?arch/arm/mach-omap2/voltagedomains44xx_data.c | ? 12 +-
> ?arch/arm/mach-omap2/vp.c ? ? ? ? ? ? ? ? ? ? ?| ? 13 +-
> ?10 files changed, 293 insertions(+), 144 deletions(-)
>
> --
> 1.7.6
>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-omap" in
> the body of a message to majordomo at vger.kernel.org
> More majordomo info at ?http://vger.kernel.org/majordomo-info.html
>
