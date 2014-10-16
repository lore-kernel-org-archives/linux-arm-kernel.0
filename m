From: eballetbo@gmail.com (Enric Balletbo Serra)
Date: Thu, 16 Oct 2014 16:21:29 +0200
Subject: [REPOST PATCH 0/2] ARM: OMAP3+: VCVP mapping fixes to get DVFS
 working
In-Reply-To: <1412949989-20186-1-git-send-email-t-kristo@ti.com>
References: <1412949989-20186-1-git-send-email-t-kristo@ti.com>
Message-ID: <CAFqH_512uU6ztmN6wh2WSb==pBZiQE8e+tmeyXFiQWYqj50V_g@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

2014-10-10 16:06 GMT+02:00 Tero Kristo <t-kristo@ti.com>:
> Hi,
>
> Seems like MPU DVFS does not scale the voltages currently with DT boot,
> due to missing mapping between regulator -> VCVP. Fixed this by adding
> support for platform data in the TWL regulator DT case + adding platform
> data quirk for the same. This same already works in the legacy boot, the
> platform data is passed fine.
>
> Tested on omap3-beagle by measuring the MPU voltage rail.
>
> OMAP4+ platforms do not currently register DVFS regulator, so this set by
> itself does not fix OMAP4 (needs the TPS MPU regulator added to DT etc.
> for OMAP4460.)
>
> -Tero
>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-omap" in
> the body of a message to majordomo at vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html

Tony proposed in the IRC apply this patch series in order to solve the
following error messages with kernel 3.17

[    2.522949] omap2_set_init_voltage: unable to find boot up OPP for
vdd_mpu_iva
[    2.533721] omap2_set_init_voltage: unable to set vdd_mpu_iva
[    2.541564] omap2_set_init_voltage: unable to find boot up OPP for vdd_core
[    2.551208] omap2_set_init_voltage: unable to set vdd_core

I'm using omap3-igep0020, I didn't mesure the MPU voltage rail but
should these patches solve these errors ? Did you resolve these errors
on your Beagleboard ?

Cheers,
   Enric
