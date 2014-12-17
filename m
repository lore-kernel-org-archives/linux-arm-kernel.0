From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Wed, 17 Dec 2014 09:52:52 +0000
Subject: OMAP 4430 SDP: rather sick with recent kernels
Message-ID: <20141217095252.GH11502@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Tony,

As the IOMMU stuff was merged last night, which removed a really quite
horrid conflict resolution, I updated my nightly build tree from its
previous state last Thursday.

Now, SDP4430 seems to be really quite broken.

ti_dt_clocks_register: failed to lookup clock node dss_fck
ti_dt_clocks_register: failed to lookup clock node dss_fck
ti_dt_clocks_register: failed to lookup clock node div_ts_ck
ti_dt_clocks_register: failed to lookup clock node bandgap_ts_fclk
...
omap_hwmod: l3_main_3 using broken dt data from ocp
omap_hwmod: l3_main_2 using broken dt data from ocp
...
irq: no irq domain found for /ocp/pinmux at 4a100040 !
irq: no irq domain found for /ocp/pinmux at 4a100040 !
irq: no irq domain found for /ocp/pinmux at 4a100040 !
platform 4b501000.aes: Cannot lookup hwmod 'aes'
platform 480a5000.des: Cannot lookup hwmod 'des'
...
twl: not initialized
twl6030_uv_to_vsel:OUT OF RANGE! non mapped vsel for 1375000 Vs max 1316660
twl6030_uv_to_vsel:OUT OF RANGE! non mapped vsel for 1375000 Vs max 1316660
twl6030_uv_to_vsel:OUT OF RANGE! non mapped vsel for 1375000 Vs max 1316660
twl6030_uv_to_vsel:OUT OF RANGE! non mapped vsel for 1375000 Vs max 1316660
twl6030_uv_to_vsel:OUT OF RANGE! non mapped vsel for 1375000 Vs max 1316660
twl6030_uv_to_vsel:OUT OF RANGE! non mapped vsel for 1375000 Vs max 1316660
twl6030_uv_to_vsel:OUT OF RANGE! non mapped vsel for 1410000 Vs max 1316660
omap2_set_init_voltage: unable to find boot up OPP for vdd_mpu
omap2_set_init_voltage: unable to set vdd_mpu
omap2_set_init_voltage: unable to find boot up OPP for vdd_core
omap2_set_init_voltage: unable to set vdd_core
omap2_set_init_voltage: unable to find boot up OPP for vdd_iva
omap2_set_init_voltage: unable to set vdd_iva
...

>From there, the system crash'n'burns badly due to an ASoC DAPM oops.

The "combined" kernel boot follows a similar pattern, but yets a bit
further before oopsing, with ASoC DAPM code printing random bits of
kernel memory.

-- 
FTTC broadband for 0.8mile line: currently at 9.5Mbps down 400kbps up
according to speedtest.net.
