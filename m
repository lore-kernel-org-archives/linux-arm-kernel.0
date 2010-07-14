From: jeremy.kerr@canonical.com (Jeremy Kerr)
Date: Wed, 14 Jul 2010 10:09:37 +0800
Subject: [RFC,PATCH 3/3] arm: remove machine_desc.io_pg_offst and .phys_io
In-Reply-To: <1279073377.400469.233833413341.0.gpush@pororo>
Message-ID: <1279073377.404006.432977736300.3.gpush@pororo>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Since we're now using addruart to establish the debug mapping, we can
remove the io_pg_offst and phys_io members of struct machine_desc.

Signed-off-by: Jeremy Kerr <jeremy.kerr@canonical.com>

---
 arch/arm/include/asm/mach/arch.h               |    6 +-----
 arch/arm/kernel/asm-offsets.c                  |    2 --
 arch/arm/mach-aaec2000/aaed2000.c              |    2 --
 arch/arm/mach-at91/board-1arm.c                |    2 --
 arch/arm/mach-at91/board-afeb-9260v1.c         |    2 --
 arch/arm/mach-at91/board-at572d940hf_ek.c      |    2 --
 arch/arm/mach-at91/board-cam60.c               |    2 --
 arch/arm/mach-at91/board-cap9adk.c             |    2 --
 arch/arm/mach-at91/board-carmeva.c             |    2 --
 arch/arm/mach-at91/board-cpu9krea.c            |    2 --
 arch/arm/mach-at91/board-cpuat91.c             |    2 --
 arch/arm/mach-at91/board-csb337.c              |    2 --
 arch/arm/mach-at91/board-csb637.c              |    2 --
 arch/arm/mach-at91/board-dk.c                  |    2 --
 arch/arm/mach-at91/board-eb9200.c              |    2 --
 arch/arm/mach-at91/board-ecbat91.c             |    2 --
 arch/arm/mach-at91/board-eco920.c              |    2 --
 arch/arm/mach-at91/board-ek.c                  |    2 --
 arch/arm/mach-at91/board-kafa.c                |    2 --
 arch/arm/mach-at91/board-kb9202.c              |    2 --
 arch/arm/mach-at91/board-neocore926.c          |    2 --
 arch/arm/mach-at91/board-picotux200.c          |    2 --
 arch/arm/mach-at91/board-qil-a9260.c           |    2 --
 arch/arm/mach-at91/board-sam9-l9260.c          |    2 --
 arch/arm/mach-at91/board-sam9260ek.c           |    2 --
 arch/arm/mach-at91/board-sam9261ek.c           |    2 --
 arch/arm/mach-at91/board-sam9263ek.c           |    2 --
 arch/arm/mach-at91/board-sam9g20ek-2slot-mmc.c |    2 --
 arch/arm/mach-at91/board-sam9g20ek.c           |    2 --
 arch/arm/mach-at91/board-sam9m10g45ek.c        |    2 --
 arch/arm/mach-at91/board-sam9rlek.c            |    2 --
 arch/arm/mach-at91/board-stamp9g20.c           |    4 ----
 arch/arm/mach-at91/board-usb-a9260.c           |    2 --
 arch/arm/mach-at91/board-usb-a9263.c           |    2 --
 arch/arm/mach-at91/board-yl-9200.c             |    2 --
 arch/arm/mach-bcmring/arch.c                   |    2 --
 arch/arm/mach-clps711x/autcpu12.c              |    2 --
 arch/arm/mach-clps711x/cdb89712.c              |    2 --
 arch/arm/mach-clps711x/ceiva.c                 |    2 --
 arch/arm/mach-clps711x/clep7312.c              |    2 --
 arch/arm/mach-clps711x/edb7211-arch.c          |    2 --
 arch/arm/mach-clps711x/fortunet.c              |    2 --
 arch/arm/mach-clps711x/p720t.c                 |    2 --
 arch/arm/mach-cns3xxx/cns3420vb.c              |    2 --
 arch/arm/mach-davinci/board-da830-evm.c        |    2 --
 arch/arm/mach-davinci/board-da850-evm.c        |    2 --
 arch/arm/mach-davinci/board-dm355-evm.c        |    2 --
 arch/arm/mach-davinci/board-dm355-leopard.c    |    2 --
 arch/arm/mach-davinci/board-dm365-evm.c        |    2 --
 arch/arm/mach-davinci/board-dm644x-evm.c       |    2 --
 arch/arm/mach-davinci/board-dm646x-evm.c       |    4 ----
 arch/arm/mach-davinci/board-neuros-osd2.c      |    2 --
 arch/arm/mach-davinci/board-sffsdr.c           |    2 --
 arch/arm/mach-dove/dove-db-setup.c             |    2 --
 arch/arm/mach-ebsa110/core.c                   |    2 --
 arch/arm/mach-ep93xx/adssphere.c               |    2 --
 arch/arm/mach-ep93xx/edb93xx.c                 |   16 ----------------
 arch/arm/mach-ep93xx/gesbc9312.c               |    2 --
 arch/arm/mach-ep93xx/micro9.c                  |    8 --------
 arch/arm/mach-ep93xx/simone.c                  |    2 --
 arch/arm/mach-ep93xx/snappercl15.c             |    2 --
 arch/arm/mach-ep93xx/ts72xx.c                  |    2 --
 arch/arm/mach-footbridge/cats-hw.c             |    2 --
 arch/arm/mach-footbridge/ebsa285.c             |    2 --
 arch/arm/mach-footbridge/netwinder-hw.c        |    2 --
 arch/arm/mach-footbridge/personal.c            |    2 --
 arch/arm/mach-gemini/board-rut1xx.c            |    2 --
 arch/arm/mach-h720x/h7201-eval.c               |    2 --
 arch/arm/mach-h720x/h7202-eval.c               |    2 --
 arch/arm/mach-integrator/integrator_ap.c       |    2 --
 arch/arm/mach-integrator/integrator_cp.c       |    2 --
 arch/arm/mach-iop13xx/iq81340mc.c              |    2 --
 arch/arm/mach-iop13xx/iq81340sc.c              |    2 --
 arch/arm/mach-iop32x/em7210.c                  |    2 --
 arch/arm/mach-iop32x/glantank.c                |    2 --
 arch/arm/mach-iop32x/iq31244.c                 |    4 ----
 arch/arm/mach-iop32x/iq80321.c                 |    2 --
 arch/arm/mach-iop32x/n2100.c                   |    2 --
 arch/arm/mach-iop33x/iq80331.c                 |    2 --
 arch/arm/mach-iop33x/iq80332.c                 |    2 --
 arch/arm/mach-ixp2000/enp2611.c                |    2 --
 arch/arm/mach-ixp2000/ixdp2400.c               |    2 --
 arch/arm/mach-ixp2000/ixdp2800.c               |    2 --
 arch/arm/mach-ixp2000/ixdp2x01.c               |    6 ------
 arch/arm/mach-ixp23xx/espresso.c               |    2 --
 arch/arm/mach-ixp23xx/ixdp2351.c               |    2 --
 arch/arm/mach-ixp23xx/roadrunner.c             |    2 --
 arch/arm/mach-ixp4xx/avila-setup.c             |    4 ----
 arch/arm/mach-ixp4xx/coyote-setup.c            |    4 ----
 arch/arm/mach-ixp4xx/dsmg600-setup.c           |    2 --
 arch/arm/mach-ixp4xx/fsg-setup.c               |    2 --
 arch/arm/mach-ixp4xx/gateway7001-setup.c       |    2 --
 arch/arm/mach-ixp4xx/goramo_mlr.c              |    2 --
 arch/arm/mach-ixp4xx/gtwx5715-setup.c          |    2 --
 arch/arm/mach-ixp4xx/ixdp425-setup.c           |    8 --------
 arch/arm/mach-ixp4xx/nas100d-setup.c           |    2 --
 arch/arm/mach-ixp4xx/nslu2-setup.c             |    2 --
 arch/arm/mach-ixp4xx/wg302v2-setup.c           |    2 --
 arch/arm/mach-kirkwood/db88f6281-bp-setup.c    |    2 --
 arch/arm/mach-kirkwood/guruplug-setup.c        |    2 --
 arch/arm/mach-kirkwood/mv88f6281gtw_ge-setup.c |    2 --
 arch/arm/mach-kirkwood/netspace_v2-setup.c     |    4 ----
 arch/arm/mach-kirkwood/netxbig_v2-setup.c      |    4 ----
 arch/arm/mach-kirkwood/openrd-setup.c          |    4 ----
 arch/arm/mach-kirkwood/rd88f6192-nas-setup.c   |    2 --
 arch/arm/mach-kirkwood/rd88f6281-setup.c       |    2 --
 arch/arm/mach-kirkwood/sheevaplug-setup.c      |    4 ----
 arch/arm/mach-kirkwood/ts219-setup.c           |    2 --
 arch/arm/mach-kirkwood/ts41x-setup.c           |    2 --
 arch/arm/mach-ks8695/board-acs5k.c             |    2 --
 arch/arm/mach-ks8695/board-dsm320.c            |    2 --
 arch/arm/mach-ks8695/board-micrel.c            |    2 --
 arch/arm/mach-l7200/core.c                     |    2 --
 arch/arm/mach-lh7a40x/arch-kev7a400.c          |    2 --
 arch/arm/mach-lh7a40x/arch-lpd7a40x.c          |    4 ----
 arch/arm/mach-loki/lb88rc8480-setup.c          |    2 --
 arch/arm/mach-mmp/aspenite.c                   |    4 ----
 arch/arm/mach-mmp/avengers_lite.c              |    2 --
 arch/arm/mach-mmp/flint.c                      |    2 --
 arch/arm/mach-mmp/jasper.c                     |    2 --
 arch/arm/mach-mmp/tavorevb.c                   |    2 --
 arch/arm/mach-mmp/ttc_dkb.c                    |    2 --
 arch/arm/mach-msm/board-halibut.c              |    4 ----
 arch/arm/mach-msm/board-mahimahi.c             |    4 ----
 arch/arm/mach-msm/board-msm7x27.c              |   16 ----------------
 arch/arm/mach-msm/board-msm7x30.c              |   12 ------------
 arch/arm/mach-msm/board-qsd8x50.c              |    8 --------
 arch/arm/mach-msm/board-sapphire.c             |    4 ----
 arch/arm/mach-msm/board-trout.c                |    4 ----
 arch/arm/mach-mv78xx0/buffalo-wxl-setup.c      |    2 --
 arch/arm/mach-mv78xx0/db78x00-bp-setup.c       |    2 --
 arch/arm/mach-mv78xx0/rd78x00-masa-setup.c     |    2 --
 arch/arm/mach-mx1/mach-mx1ads.c                |    4 ----
 arch/arm/mach-mx1/mach-scb9328.c               |    2 --
 arch/arm/mach-mx2/mach-cpuimx27.c              |    2 --
 arch/arm/mach-mx2/mach-imx27lite.c             |    2 --
 arch/arm/mach-mx2/mach-mx21ads.c               |    2 --
 arch/arm/mach-mx2/mach-mx27_3ds.c              |    2 --
 arch/arm/mach-mx2/mach-mx27ads.c               |    2 --
 arch/arm/mach-mx2/mach-mxt_td60.c              |    2 --
 arch/arm/mach-mx2/mach-pca100.c                |    2 --
 arch/arm/mach-mx2/mach-pcm038.c                |    2 --
 arch/arm/mach-mx25/mach-mx25pdk.c              |    2 --
 arch/arm/mach-mx3/mach-armadillo5x0.c          |    2 --
 arch/arm/mach-mx3/mach-kzm_arm11_01.c          |    2 --
 arch/arm/mach-mx3/mach-mx31_3ds.c              |    2 --
 arch/arm/mach-mx3/mach-mx31ads.c               |    2 --
 arch/arm/mach-mx3/mach-mx31lilly.c             |    2 --
 arch/arm/mach-mx3/mach-mx31lite.c              |    2 --
 arch/arm/mach-mx3/mach-mx31moboard.c           |    2 --
 arch/arm/mach-mx3/mach-mx35pdk.c               |    2 --
 arch/arm/mach-mx3/mach-pcm037.c                |    2 --
 arch/arm/mach-mx3/mach-pcm043.c                |    2 --
 arch/arm/mach-mx3/mach-qong.c                  |    2 --
 arch/arm/mach-mx5/board-mx51_babbage.c         |    2 --
 arch/arm/mach-mxc91231/magx-zn5.c              |    2 --
 arch/arm/mach-netx/nxdb500.c                   |    2 --
 arch/arm/mach-netx/nxdkn.c                     |    2 --
 arch/arm/mach-netx/nxeb500hmi.c                |    2 --
 arch/arm/mach-nomadik/board-nhk8815.c          |    2 --
 arch/arm/mach-nuc93x/mach-nuc932evb.c          |    2 --
 arch/arm/mach-omap1/board-ams-delta.c          |    2 --
 arch/arm/mach-omap1/board-fsample.c            |    2 --
 arch/arm/mach-omap1/board-generic.c            |    2 --
 arch/arm/mach-omap1/board-h2.c                 |    2 --
 arch/arm/mach-omap1/board-h3.c                 |    2 --
 arch/arm/mach-omap1/board-htcherald.c          |    2 --
 arch/arm/mach-omap1/board-innovator.c          |    2 --
 arch/arm/mach-omap1/board-nokia770.c           |    2 --
 arch/arm/mach-omap1/board-osk.c                |    2 --
 arch/arm/mach-omap1/board-palmte.c             |    2 --
 arch/arm/mach-omap1/board-palmtt.c             |    2 --
 arch/arm/mach-omap1/board-palmz71.c            |    2 --
 arch/arm/mach-omap1/board-perseus2.c           |    2 --
 arch/arm/mach-omap1/board-sx1.c                |    2 --
 arch/arm/mach-omap1/board-voiceblue.c          |    2 --
 arch/arm/mach-omap2/board-2430sdp.c            |    2 --
 arch/arm/mach-omap2/board-3430sdp.c            |    2 --
 arch/arm/mach-omap2/board-3630sdp.c            |    2 --
 arch/arm/mach-omap2/board-4430sdp.c            |    2 --
 arch/arm/mach-omap2/board-am3517evm.c          |    2 --
 arch/arm/mach-omap2/board-apollon.c            |    2 --
 arch/arm/mach-omap2/board-cm-t35.c             |    2 --
 arch/arm/mach-omap2/board-devkit8000.c         |    2 --
 arch/arm/mach-omap2/board-generic.c            |    2 --
 arch/arm/mach-omap2/board-h4.c                 |    2 --
 arch/arm/mach-omap2/board-igep0020.c           |    2 --
 arch/arm/mach-omap2/board-ldp.c                |    2 --
 arch/arm/mach-omap2/board-n8x0.c               |    6 ------
 arch/arm/mach-omap2/board-omap3beagle.c        |    2 --
 arch/arm/mach-omap2/board-omap3evm.c           |    2 --
 arch/arm/mach-omap2/board-omap3pandora.c       |    2 --
 arch/arm/mach-omap2/board-omap3stalker.c       |    2 --
 arch/arm/mach-omap2/board-omap3touchbook.c     |    2 --
 arch/arm/mach-omap2/board-overo.c              |    2 --
 arch/arm/mach-omap2/board-rx51.c               |    2 --
 arch/arm/mach-omap2/board-zoom2.c              |    2 --
 arch/arm/mach-omap2/board-zoom3.c              |    2 --
 arch/arm/mach-orion5x/d2net-setup.c            |    4 ----
 arch/arm/mach-orion5x/db88f5281-setup.c        |    2 --
 arch/arm/mach-orion5x/dns323-setup.c           |    2 --
 arch/arm/mach-orion5x/edmini_v2-setup.c        |    2 --
 arch/arm/mach-orion5x/kurobox_pro-setup.c      |    4 ----
 arch/arm/mach-orion5x/ls_hgl-setup.c           |    2 --
 arch/arm/mach-orion5x/lsmini-setup.c           |    2 --
 arch/arm/mach-orion5x/mss2-setup.c             |    2 --
 arch/arm/mach-orion5x/mv2120-setup.c           |    2 --
 arch/arm/mach-orion5x/net2big-setup.c          |    2 --
 arch/arm/mach-orion5x/rd88f5181l-fxo-setup.c   |    2 --
 arch/arm/mach-orion5x/rd88f5181l-ge-setup.c    |    2 --
 arch/arm/mach-orion5x/rd88f5182-setup.c        |    2 --
 arch/arm/mach-orion5x/rd88f6183ap-ge-setup.c   |    2 --
 arch/arm/mach-orion5x/terastation_pro2-setup.c |    2 --
 arch/arm/mach-orion5x/ts209-setup.c            |    2 --
 arch/arm/mach-orion5x/ts409-setup.c            |    2 --
 arch/arm/mach-orion5x/ts78xx-setup.c           |    2 --
 arch/arm/mach-orion5x/wnr854t-setup.c          |    2 --
 arch/arm/mach-orion5x/wrt350n-v2-setup.c       |    2 --
 arch/arm/mach-pnx4008/core.c                   |    2 --
 arch/arm/mach-pxa/balloon3.c                   |    2 --
 arch/arm/mach-pxa/capc7117.c                   |    2 --
 arch/arm/mach-pxa/cm-x2xx.c                    |    2 --
 arch/arm/mach-pxa/cm-x300.c                    |    2 --
 arch/arm/mach-pxa/colibri-pxa270.c             |    2 --
 arch/arm/mach-pxa/colibri-pxa300.c             |    2 --
 arch/arm/mach-pxa/colibri-pxa320.c             |    2 --
 arch/arm/mach-pxa/corgi.c                      |    6 ------
 arch/arm/mach-pxa/csb726.c                     |    2 --
 arch/arm/mach-pxa/e330.c                       |    2 --
 arch/arm/mach-pxa/e350.c                       |    2 --
 arch/arm/mach-pxa/e400.c                       |    2 --
 arch/arm/mach-pxa/e740.c                       |    2 --
 arch/arm/mach-pxa/e750.c                       |    2 --
 arch/arm/mach-pxa/e800.c                       |    2 --
 arch/arm/mach-pxa/em-x270.c                    |    4 ----
 arch/arm/mach-pxa/ezx.c                        |   12 ------------
 arch/arm/mach-pxa/gumstix.c                    |    2 --
 arch/arm/mach-pxa/h5000.c                      |    2 --
 arch/arm/mach-pxa/himalaya.c                   |    2 --
 arch/arm/mach-pxa/hx4700.c                     |    2 --
 arch/arm/mach-pxa/icontrol.c                   |    2 --
 arch/arm/mach-pxa/idp.c                        |    2 --
 arch/arm/mach-pxa/imote2.c                     |    2 --
 arch/arm/mach-pxa/littleton.c                  |    2 --
 arch/arm/mach-pxa/lpd270.c                     |    2 --
 arch/arm/mach-pxa/lubbock.c                    |    2 --
 arch/arm/mach-pxa/magician.c                   |    2 --
 arch/arm/mach-pxa/mainstone.c                  |    2 --
 arch/arm/mach-pxa/mioa701.c                    |    2 --
 arch/arm/mach-pxa/mp900.c                      |    2 --
 arch/arm/mach-pxa/palmld.c                     |    2 --
 arch/arm/mach-pxa/palmt5.c                     |    2 --
 arch/arm/mach-pxa/palmtc.c                     |    2 --
 arch/arm/mach-pxa/palmte2.c                    |    2 --
 arch/arm/mach-pxa/palmtreo.c                   |    4 ----
 arch/arm/mach-pxa/palmtx.c                     |    2 --
 arch/arm/mach-pxa/palmz72.c                    |    2 --
 arch/arm/mach-pxa/pcm027.c                     |    2 --
 arch/arm/mach-pxa/poodle.c                     |    2 --
 arch/arm/mach-pxa/raumfeld.c                   |    6 ------
 arch/arm/mach-pxa/saar.c                       |    2 --
 arch/arm/mach-pxa/spitz.c                      |    6 ------
 arch/arm/mach-pxa/stargate2.c                  |    2 --
 arch/arm/mach-pxa/tavorevb.c                   |    2 --
 arch/arm/mach-pxa/tosa.c                       |    2 --
 arch/arm/mach-pxa/trizeps4.c                   |    4 ----
 arch/arm/mach-pxa/viper.c                      |    2 --
 arch/arm/mach-pxa/vpac270.c                    |    2 --
 arch/arm/mach-pxa/xcep.c                       |    2 --
 arch/arm/mach-pxa/z2.c                         |    2 --
 arch/arm/mach-pxa/zeus.c                       |    2 --
 arch/arm/mach-pxa/zylonite.c                   |    2 --
 arch/arm/mach-realview/realview_eb.c           |    2 --
 arch/arm/mach-realview/realview_pb1176.c       |    2 --
 arch/arm/mach-realview/realview_pb11mp.c       |    2 --
 arch/arm/mach-realview/realview_pba8.c         |    2 --
 arch/arm/mach-realview/realview_pbx.c          |    2 --
 arch/arm/mach-rpc/riscpc.c                     |    2 --
 arch/arm/mach-s3c2410/mach-amlm5900.c          |    2 --
 arch/arm/mach-s3c2410/mach-bast.c              |    2 --
 arch/arm/mach-s3c2410/mach-h1940.c             |    2 --
 arch/arm/mach-s3c2410/mach-n30.c               |    4 ----
 arch/arm/mach-s3c2410/mach-otom.c              |    2 --
 arch/arm/mach-s3c2410/mach-qt2410.c            |    2 --
 arch/arm/mach-s3c2410/mach-smdk2410.c          |    2 --
 arch/arm/mach-s3c2410/mach-tct_hammer.c        |    2 --
 arch/arm/mach-s3c2410/mach-vr1000.c            |    2 --
 arch/arm/mach-s3c2412/mach-jive.c              |    2 --
 arch/arm/mach-s3c2412/mach-smdk2413.c          |    6 ------
 arch/arm/mach-s3c2412/mach-vstms.c             |    2 --
 arch/arm/mach-s3c2416/mach-smdk2416.c          |    2 --
 arch/arm/mach-s3c2440/mach-anubis.c            |    2 --
 arch/arm/mach-s3c2440/mach-at2440evb.c         |    2 --
 arch/arm/mach-s3c2440/mach-gta02.c             |    2 --
 arch/arm/mach-s3c2440/mach-mini2440.c          |    2 --
 arch/arm/mach-s3c2440/mach-nexcoder.c          |    2 --
 arch/arm/mach-s3c2440/mach-osiris.c            |    2 --
 arch/arm/mach-s3c2440/mach-rx1950.c            |    2 --
 arch/arm/mach-s3c2440/mach-rx3715.c            |    2 --
 arch/arm/mach-s3c2440/mach-smdk2440.c          |    2 --
 arch/arm/mach-s3c2443/mach-smdk2443.c          |    2 --
 arch/arm/mach-s3c64xx/mach-anw6410.c           |    2 --
 arch/arm/mach-s3c64xx/mach-hmt.c               |    2 --
 arch/arm/mach-s3c64xx/mach-ncp.c               |    2 --
 arch/arm/mach-s3c64xx/mach-smartq5.c           |    2 --
 arch/arm/mach-s3c64xx/mach-smartq7.c           |    2 --
 arch/arm/mach-s3c64xx/mach-smdk6400.c          |    2 --
 arch/arm/mach-s3c64xx/mach-smdk6410.c          |    2 --
 arch/arm/mach-s5p6440/mach-smdk6440.c          |    2 --
 arch/arm/mach-s5p6442/mach-smdk6442.c          |    2 --
 arch/arm/mach-s5pc100/mach-smdkc100.c          |    2 --
 arch/arm/mach-s5pv210/mach-aquila.c            |    2 --
 arch/arm/mach-s5pv210/mach-goni.c              |    2 --
 arch/arm/mach-s5pv210/mach-smdkc110.c          |    2 --
 arch/arm/mach-s5pv210/mach-smdkv210.c          |    2 --
 arch/arm/mach-sa1100/assabet.c                 |    2 --
 arch/arm/mach-sa1100/badge4.c                  |    2 --
 arch/arm/mach-sa1100/cerf.c                    |    2 --
 arch/arm/mach-sa1100/collie.c                  |    2 --
 arch/arm/mach-sa1100/h3100.c                   |    2 --
 arch/arm/mach-sa1100/h3600.c                   |    2 --
 arch/arm/mach-sa1100/hackkit.c                 |    2 --
 arch/arm/mach-sa1100/jornada720.c              |    2 --
 arch/arm/mach-sa1100/lart.c                    |    2 --
 arch/arm/mach-sa1100/pleb.c                    |    2 --
 arch/arm/mach-sa1100/shannon.c                 |    2 --
 arch/arm/mach-sa1100/simpad.c                  |    2 --
 arch/arm/mach-shark/core.c                     |    2 --
 arch/arm/mach-shmobile/board-ap4evb.c          |    2 --
 arch/arm/mach-shmobile/board-g3evm.c           |    2 --
 arch/arm/mach-shmobile/board-g4evm.c           |    2 --
 arch/arm/mach-stmp378x/stmp378x_devb.c         |    2 --
 arch/arm/mach-stmp37xx/stmp37xx_devb.c         |    2 --
 arch/arm/mach-u300/u300.c                      |    2 --
 arch/arm/mach-ux500/board-mop500.c             |    2 --
 arch/arm/mach-ux500/board-u5500.c              |    2 --
 arch/arm/mach-versatile/versatile_ab.c         |    2 --
 arch/arm/mach-versatile/versatile_pb.c         |    2 --
 arch/arm/mach-vexpress/ct-ca9x4.c              |    2 --
 arch/arm/mach-w90x900/mach-nuc910evb.c         |    2 --
 arch/arm/mach-w90x900/mach-nuc950evb.c         |    2 --
 arch/arm/mach-w90x900/mach-nuc960evb.c         |    2 --
 342 files changed, 1 insertion(+), 821 deletions(-)

diff --git a/arch/arm/include/asm/mach/arch.h b/arch/arm/include/asm/mach/arch.h
index c59842d..1f545fe 100644
--- a/arch/arm/include/asm/mach/arch.h
+++ b/arch/arm/include/asm/mach/arch.h
@@ -16,14 +16,10 @@ struct sys_timer;
 
 struct machine_desc {
 	/*
-	 * Note! The first four elements are used
+	 * Note! The first two elements are used
 	 * by assembler code in head.S, head-common.S
 	 */
 	unsigned int		nr;		/* architecture number	*/
-	unsigned int		phys_io;	/* start of physical io	*/
-	unsigned int		io_pg_offst;	/* byte offset for io 
-						 * page tabe entry	*/
-
 	const char		*name;		/* architecture name	*/
 	unsigned long		boot_params;	/* tagged list		*/
 
diff --git a/arch/arm/kernel/asm-offsets.c b/arch/arm/kernel/asm-offsets.c
index 8835115..fdfaa97 100644
--- a/arch/arm/kernel/asm-offsets.c
+++ b/arch/arm/kernel/asm-offsets.c
@@ -99,8 +99,6 @@ int main(void)
   DEFINE(SIZEOF_MACHINE_DESC,	sizeof(struct machine_desc));
   DEFINE(MACHINFO_TYPE,		offsetof(struct machine_desc, nr));
   DEFINE(MACHINFO_NAME,		offsetof(struct machine_desc, name));
-  DEFINE(MACHINFO_PHYSIO,	offsetof(struct machine_desc, phys_io));
-  DEFINE(MACHINFO_PGOFFIO,	offsetof(struct machine_desc, io_pg_offst));
   BLANK();
   DEFINE(PROC_INFO_SZ,		sizeof(struct proc_info_list));
   DEFINE(PROCINFO_INITFUNC,	offsetof(struct proc_info_list, __cpu_flush));
diff --git a/arch/arm/mach-aaec2000/aaed2000.c b/arch/arm/mach-aaec2000/aaed2000.c
index 81a3ecc..0eb3e3e 100644
--- a/arch/arm/mach-aaec2000/aaed2000.c
+++ b/arch/arm/mach-aaec2000/aaed2000.c
@@ -95,8 +95,6 @@ static void __init aaed2000_map_io(void)
 
 MACHINE_START(AAED2000, "Agilent AAED-2000 Development Platform")
 	/* Maintainer: Nicolas Bellido Y Ortega */
-	.phys_io	= PIO_BASE,
-	.io_pg_offst	= ((VIO_BASE) >> 18) & 0xfffc,
 	.map_io		= aaed2000_map_io,
 	.init_irq	= aaed2000_init_irq,
 	.timer		= &aaec2000_timer,
diff --git a/arch/arm/mach-at91/board-1arm.c b/arch/arm/mach-at91/board-1arm.c
index 9b27d16..46bdc82 100644
--- a/arch/arm/mach-at91/board-1arm.c
+++ b/arch/arm/mach-at91/board-1arm.c
@@ -92,8 +92,6 @@ static void __init onearm_board_init(void)
 
 MACHINE_START(ONEARM, "Ajeco 1ARM single board computer")
 	/* Maintainer: Lennert Buytenhek <buytenh@wantstofly.org> */
-	.phys_io	= AT91_BASE_SYS,
-	.io_pg_offst	= (AT91_VA_BASE_SYS >> 18) & 0xfffc,
 	.boot_params	= AT91_SDRAM_BASE + 0x100,
 	.timer		= &at91rm9200_timer,
 	.map_io		= onearm_map_io,
diff --git a/arch/arm/mach-at91/board-afeb-9260v1.c b/arch/arm/mach-at91/board-afeb-9260v1.c
index 50667be..cba7f77 100644
--- a/arch/arm/mach-at91/board-afeb-9260v1.c
+++ b/arch/arm/mach-at91/board-afeb-9260v1.c
@@ -218,8 +218,6 @@ static void __init afeb9260_board_init(void)
 
 MACHINE_START(AFEB9260, "Custom afeb9260 board")
 	/* Maintainer: Sergey Lapin <slapin@ossfans.org> */
-	.phys_io	= AT91_BASE_SYS,
-	.io_pg_offst	= (AT91_VA_BASE_SYS >> 18) & 0xfffc,
 	.boot_params	= AT91_SDRAM_BASE + 0x100,
 	.timer		= &at91sam926x_timer,
 	.map_io		= afeb9260_map_io,
diff --git a/arch/arm/mach-at91/board-at572d940hf_ek.c b/arch/arm/mach-at91/board-at572d940hf_ek.c
index 5daff27..8187b4b 100644
--- a/arch/arm/mach-at91/board-at572d940hf_ek.c
+++ b/arch/arm/mach-at91/board-at572d940hf_ek.c
@@ -318,8 +318,6 @@ static void __init eb_board_init(void)
 
 MACHINE_START(AT572D940HFEB, "Atmel AT91D940HF-EB")
 	/* Maintainer: Atmel <costa.antonior@gmail.com> */
-	.phys_io	= AT91_BASE_SYS,
-	.io_pg_offst	= (AT91_VA_BASE_SYS >> 18) & 0xfffc,
 	.boot_params	= AT91_SDRAM_BASE + 0x100,
 	.timer		= &at91sam926x_timer,
 	.map_io		= eb_map_io,
diff --git a/arch/arm/mach-at91/board-cam60.c b/arch/arm/mach-at91/board-cam60.c
index 02138af..20578d4 100644
--- a/arch/arm/mach-at91/board-cam60.c
+++ b/arch/arm/mach-at91/board-cam60.c
@@ -198,8 +198,6 @@ static void __init cam60_board_init(void)
 
 MACHINE_START(CAM60, "KwikByte CAM60")
 	/* Maintainer: KwikByte */
-	.phys_io	= AT91_BASE_SYS,
-	.io_pg_offst	= (AT91_VA_BASE_SYS >> 18) & 0xfffc,
 	.boot_params	= AT91_SDRAM_BASE + 0x100,
 	.timer		= &at91sam926x_timer,
 	.map_io		= cam60_map_io,
diff --git a/arch/arm/mach-at91/board-cap9adk.c b/arch/arm/mach-at91/board-cap9adk.c
index d694087..e727444 100644
--- a/arch/arm/mach-at91/board-cap9adk.c
+++ b/arch/arm/mach-at91/board-cap9adk.c
@@ -399,8 +399,6 @@ static void __init cap9adk_board_init(void)
 
 MACHINE_START(AT91CAP9ADK, "Atmel AT91CAP9A-DK")
 	/* Maintainer: Stelian Pop <stelian.pop@leadtechdesign.com> */
-	.phys_io	= AT91_BASE_SYS,
-	.io_pg_offst	= (AT91_VA_BASE_SYS >> 18) & 0xfffc,
 	.boot_params	= AT91_SDRAM_BASE + 0x100,
 	.timer		= &at91sam926x_timer,
 	.map_io		= cap9adk_map_io,
diff --git a/arch/arm/mach-at91/board-carmeva.c b/arch/arm/mach-at91/board-carmeva.c
index db1f954..2e74a19 100644
--- a/arch/arm/mach-at91/board-carmeva.c
+++ b/arch/arm/mach-at91/board-carmeva.c
@@ -162,8 +162,6 @@ static void __init carmeva_board_init(void)
 
 MACHINE_START(CARMEVA, "Carmeva")
 	/* Maintainer: Conitec Datasystems */
-	.phys_io	= AT91_BASE_SYS,
-	.io_pg_offst	= (AT91_VA_BASE_SYS >> 18) & 0xfffc,
 	.boot_params	= AT91_SDRAM_BASE + 0x100,
 	.timer		= &at91rm9200_timer,
 	.map_io		= carmeva_map_io,
diff --git a/arch/arm/mach-at91/board-cpu9krea.c b/arch/arm/mach-at91/board-cpu9krea.c
index 4bc2e9f..3838594 100644
--- a/arch/arm/mach-at91/board-cpu9krea.c
+++ b/arch/arm/mach-at91/board-cpu9krea.c
@@ -375,8 +375,6 @@ MACHINE_START(CPUAT9260, "Eukrea CPU9260")
 MACHINE_START(CPUAT9G20, "Eukrea CPU9G20")
 #endif
 	/* Maintainer: Eric Benard - EUKREA Electromatique */
-	.phys_io	= AT91_BASE_SYS,
-	.io_pg_offst	= (AT91_VA_BASE_SYS >> 18) & 0xfffc,
 	.boot_params	= AT91_SDRAM_BASE + 0x100,
 	.timer		= &at91sam926x_timer,
 	.map_io		= cpu9krea_map_io,
diff --git a/arch/arm/mach-at91/board-cpuat91.c b/arch/arm/mach-at91/board-cpuat91.c
index a28d996..2f4dd8c 100644
--- a/arch/arm/mach-at91/board-cpuat91.c
+++ b/arch/arm/mach-at91/board-cpuat91.c
@@ -175,8 +175,6 @@ static void __init cpuat91_board_init(void)
 
 MACHINE_START(CPUAT91, "Eukrea")
 	/* Maintainer: Eric Benard - EUKREA Electromatique */
-	.phys_io	= AT91_BASE_SYS,
-	.io_pg_offst	= (AT91_VA_BASE_SYS >> 18) & 0xfffc,
 	.boot_params	= AT91_SDRAM_BASE + 0x100,
 	.timer		= &at91rm9200_timer,
 	.map_io		= cpuat91_map_io,
diff --git a/arch/arm/mach-at91/board-csb337.c b/arch/arm/mach-at91/board-csb337.c
index fea2529..464839d 100644
--- a/arch/arm/mach-at91/board-csb337.c
+++ b/arch/arm/mach-at91/board-csb337.c
@@ -257,8 +257,6 @@ static void __init csb337_board_init(void)
 
 MACHINE_START(CSB337, "Cogent CSB337")
 	/* Maintainer: Bill Gatliff */
-	.phys_io	= AT91_BASE_SYS,
-	.io_pg_offst	= (AT91_VA_BASE_SYS >> 18) & 0xfffc,
 	.boot_params	= AT91_SDRAM_BASE + 0x100,
 	.timer		= &at91rm9200_timer,
 	.map_io		= csb337_map_io,
diff --git a/arch/arm/mach-at91/board-csb637.c b/arch/arm/mach-at91/board-csb637.c
index cfa3f04..431688c 100644
--- a/arch/arm/mach-at91/board-csb637.c
+++ b/arch/arm/mach-at91/board-csb637.c
@@ -138,8 +138,6 @@ static void __init csb637_board_init(void)
 
 MACHINE_START(CSB637, "Cogent CSB637")
 	/* Maintainer: Bill Gatliff */
-	.phys_io	= AT91_BASE_SYS,
-	.io_pg_offst	= (AT91_VA_BASE_SYS >> 18) & 0xfffc,
 	.boot_params	= AT91_SDRAM_BASE + 0x100,
 	.timer		= &at91rm9200_timer,
 	.map_io		= csb637_map_io,
diff --git a/arch/arm/mach-at91/board-dk.c b/arch/arm/mach-at91/board-dk.c
index 0fd0f5b..e14f0e1 100644
--- a/arch/arm/mach-at91/board-dk.c
+++ b/arch/arm/mach-at91/board-dk.c
@@ -225,8 +225,6 @@ static void __init dk_board_init(void)
 
 MACHINE_START(AT91RM9200DK, "Atmel AT91RM9200-DK")
 	/* Maintainer: SAN People/Atmel */
-	.phys_io	= AT91_BASE_SYS,
-	.io_pg_offst	= (AT91_VA_BASE_SYS >> 18) & 0xfffc,
 	.boot_params	= AT91_SDRAM_BASE + 0x100,
 	.timer		= &at91rm9200_timer,
 	.map_io		= dk_map_io,
diff --git a/arch/arm/mach-at91/board-eb9200.c b/arch/arm/mach-at91/board-eb9200.c
index 5286567..6cf6566 100644
--- a/arch/arm/mach-at91/board-eb9200.c
+++ b/arch/arm/mach-at91/board-eb9200.c
@@ -120,8 +120,6 @@ static void __init eb9200_board_init(void)
 }
 
 MACHINE_START(ATEB9200, "Embest ATEB9200")
-	.phys_io	= AT91_BASE_SYS,
-	.io_pg_offst	= (AT91_VA_BASE_SYS >> 18) & 0xfffc,
 	.boot_params	= AT91_SDRAM_BASE + 0x100,
 	.timer		= &at91rm9200_timer,
 	.map_io		= eb9200_map_io,
diff --git a/arch/arm/mach-at91/board-ecbat91.c b/arch/arm/mach-at91/board-ecbat91.c
index 1d69908..7b58c94 100644
--- a/arch/arm/mach-at91/board-ecbat91.c
+++ b/arch/arm/mach-at91/board-ecbat91.c
@@ -168,8 +168,6 @@ static void __init ecb_at91board_init(void)
 
 MACHINE_START(ECBAT91, "emQbit's ECB_AT91")
 	/* Maintainer: emQbit.com */
-	.phys_io	= AT91_BASE_SYS,
-	.io_pg_offst	= (AT91_VA_BASE_SYS >> 18) & 0xfffc,
 	.boot_params	= AT91_SDRAM_BASE + 0x100,
 	.timer		= &at91rm9200_timer,
 	.map_io		= ecb_at91map_io,
diff --git a/arch/arm/mach-at91/board-eco920.c b/arch/arm/mach-at91/board-eco920.c
index 295a966..a158a0c 100644
--- a/arch/arm/mach-at91/board-eco920.c
+++ b/arch/arm/mach-at91/board-eco920.c
@@ -148,8 +148,6 @@ static void __init eco920_board_init(void)
 
 MACHINE_START(ECO920, "eco920")
 	/* Maintainer: Sascha Hauer */
-	.phys_io	= AT91_BASE_SYS,
-	.io_pg_offst	= (AT91_VA_BASE_SYS >> 18) & 0xfffc,
 	.boot_params	= AT91_SDRAM_BASE + 0x100,
 	.timer		= &at91rm9200_timer,
 	.map_io		= eco920_map_io,
diff --git a/arch/arm/mach-at91/board-ek.c b/arch/arm/mach-at91/board-ek.c
index 4cdfaac..56e92c4 100644
--- a/arch/arm/mach-at91/board-ek.c
+++ b/arch/arm/mach-at91/board-ek.c
@@ -191,8 +191,6 @@ static void __init ek_board_init(void)
 
 MACHINE_START(AT91RM9200EK, "Atmel AT91RM9200-EK")
 	/* Maintainer: SAN People/Atmel */
-	.phys_io	= AT91_BASE_SYS,
-	.io_pg_offst	= (AT91_VA_BASE_SYS >> 18) & 0xfffc,
 	.boot_params	= AT91_SDRAM_BASE + 0x100,
 	.timer		= &at91rm9200_timer,
 	.map_io		= ek_map_io,
diff --git a/arch/arm/mach-at91/board-kafa.c b/arch/arm/mach-at91/board-kafa.c
index a87956c..c0ce79d 100644
--- a/arch/arm/mach-at91/board-kafa.c
+++ b/arch/arm/mach-at91/board-kafa.c
@@ -99,8 +99,6 @@ static void __init kafa_board_init(void)
 
 MACHINE_START(KAFA, "Sperry-Sun KAFA")
 	/* Maintainer: Sergei Sharonov */
-	.phys_io	= AT91_BASE_SYS,
-	.io_pg_offst	= (AT91_VA_BASE_SYS >> 18) & 0xfffc,
 	.boot_params	= AT91_SDRAM_BASE + 0x100,
 	.timer		= &at91rm9200_timer,
 	.map_io		= kafa_map_io,
diff --git a/arch/arm/mach-at91/board-kb9202.c b/arch/arm/mach-at91/board-kb9202.c
index fe9b991..a13d206 100644
--- a/arch/arm/mach-at91/board-kb9202.c
+++ b/arch/arm/mach-at91/board-kb9202.c
@@ -136,8 +136,6 @@ static void __init kb9202_board_init(void)
 
 MACHINE_START(KB9200, "KB920x")
 	/* Maintainer: KwikByte, Inc. */
-	.phys_io	= AT91_BASE_SYS,
-	.io_pg_offst	= (AT91_VA_BASE_SYS >> 18) & 0xfffc,
 	.boot_params	= AT91_SDRAM_BASE + 0x100,
 	.timer		= &at91rm9200_timer,
 	.map_io		= kb9202_map_io,
diff --git a/arch/arm/mach-at91/board-neocore926.c b/arch/arm/mach-at91/board-neocore926.c
index 7c1e382..fe5f1d4 100644
--- a/arch/arm/mach-at91/board-neocore926.c
+++ b/arch/arm/mach-at91/board-neocore926.c
@@ -387,8 +387,6 @@ static void __init neocore926_board_init(void)
 
 MACHINE_START(NEOCORE926, "ADENEO NEOCORE 926")
 	/* Maintainer: ADENEO */
-	.phys_io	= AT91_BASE_SYS,
-	.io_pg_offst	= (AT91_VA_BASE_SYS >> 18) & 0xfffc,
 	.boot_params	= AT91_SDRAM_BASE + 0x100,
 	.timer		= &at91sam926x_timer,
 	.map_io		= neocore926_map_io,
diff --git a/arch/arm/mach-at91/board-picotux200.c b/arch/arm/mach-at91/board-picotux200.c
index 859727e..9d833bb 100644
--- a/arch/arm/mach-at91/board-picotux200.c
+++ b/arch/arm/mach-at91/board-picotux200.c
@@ -156,8 +156,6 @@ static void __init picotux200_board_init(void)
 
 MACHINE_START(PICOTUX2XX, "picotux 200")
 	/* Maintainer: Kleinhenz Elektronik GmbH */
-	.phys_io	= AT91_BASE_SYS,
-	.io_pg_offst	= (AT91_VA_BASE_SYS >> 18) & 0xfffc,
 	.boot_params	= AT91_SDRAM_BASE + 0x100,
 	.timer		= &at91rm9200_timer,
 	.map_io		= picotux200_map_io,
diff --git a/arch/arm/mach-at91/board-qil-a9260.c b/arch/arm/mach-at91/board-qil-a9260.c
index 664938e..69d15a8 100644
--- a/arch/arm/mach-at91/board-qil-a9260.c
+++ b/arch/arm/mach-at91/board-qil-a9260.c
@@ -268,8 +268,6 @@ static void __init ek_board_init(void)
 
 MACHINE_START(QIL_A9260, "CALAO QIL_A9260")
 	/* Maintainer: calao-systems */
-	.phys_io	= AT91_BASE_SYS,
-	.io_pg_offst	= (AT91_VA_BASE_SYS >> 18) & 0xfffc,
 	.boot_params	= AT91_SDRAM_BASE + 0x100,
 	.timer		= &at91sam926x_timer,
 	.map_io		= ek_map_io,
diff --git a/arch/arm/mach-at91/board-sam9-l9260.c b/arch/arm/mach-at91/board-sam9-l9260.c
index b483469..25a26be 100644
--- a/arch/arm/mach-at91/board-sam9-l9260.c
+++ b/arch/arm/mach-at91/board-sam9-l9260.c
@@ -212,8 +212,6 @@ static void __init ek_board_init(void)
 
 MACHINE_START(SAM9_L9260, "Olimex SAM9-L9260")
 	/* Maintainer: Olimex */
-	.phys_io	= AT91_BASE_SYS,
-	.io_pg_offst	= (AT91_VA_BASE_SYS >> 18) & 0xfffc,
 	.boot_params	= AT91_SDRAM_BASE + 0x100,
 	.timer		= &at91sam926x_timer,
 	.map_io		= ek_map_io,
diff --git a/arch/arm/mach-at91/board-sam9260ek.c b/arch/arm/mach-at91/board-sam9260ek.c
index ba9d501..de1816e 100644
--- a/arch/arm/mach-at91/board-sam9260ek.c
+++ b/arch/arm/mach-at91/board-sam9260ek.c
@@ -356,8 +356,6 @@ static void __init ek_board_init(void)
 
 MACHINE_START(AT91SAM9260EK, "Atmel AT91SAM9260-EK")
 	/* Maintainer: Atmel */
-	.phys_io	= AT91_BASE_SYS,
-	.io_pg_offst	= (AT91_VA_BASE_SYS >> 18) & 0xfffc,
 	.boot_params	= AT91_SDRAM_BASE + 0x100,
 	.timer		= &at91sam926x_timer,
 	.map_io		= ek_map_io,
diff --git a/arch/arm/mach-at91/board-sam9261ek.c b/arch/arm/mach-at91/board-sam9261ek.c
index c4c8865..a64e6c4 100644
--- a/arch/arm/mach-at91/board-sam9261ek.c
+++ b/arch/arm/mach-at91/board-sam9261ek.c
@@ -616,8 +616,6 @@ MACHINE_START(AT91SAM9261EK, "Atmel AT91SAM9261-EK")
 MACHINE_START(AT91SAM9G10EK, "Atmel AT91SAM9G10-EK")
 #endif
 	/* Maintainer: Atmel */
-	.phys_io	= AT91_BASE_SYS,
-	.io_pg_offst	= (AT91_VA_BASE_SYS >> 18) & 0xfffc,
 	.boot_params	= AT91_SDRAM_BASE + 0x100,
 	.timer		= &at91sam926x_timer,
 	.map_io		= ek_map_io,
diff --git a/arch/arm/mach-at91/board-sam9263ek.c b/arch/arm/mach-at91/board-sam9263ek.c
index 2d867fb..bfe490d 100644
--- a/arch/arm/mach-at91/board-sam9263ek.c
+++ b/arch/arm/mach-at91/board-sam9263ek.c
@@ -454,8 +454,6 @@ static void __init ek_board_init(void)
 
 MACHINE_START(AT91SAM9263EK, "Atmel AT91SAM9263-EK")
 	/* Maintainer: Atmel */
-	.phys_io	= AT91_BASE_SYS,
-	.io_pg_offst	= (AT91_VA_BASE_SYS >> 18) & 0xfffc,
 	.boot_params	= AT91_SDRAM_BASE + 0x100,
 	.timer		= &at91sam926x_timer,
 	.map_io		= ek_map_io,
diff --git a/arch/arm/mach-at91/board-sam9g20ek-2slot-mmc.c b/arch/arm/mach-at91/board-sam9g20ek-2slot-mmc.c
index a4102d7..8f8cff2 100644
--- a/arch/arm/mach-at91/board-sam9g20ek-2slot-mmc.c
+++ b/arch/arm/mach-at91/board-sam9g20ek-2slot-mmc.c
@@ -274,8 +274,6 @@ static void __init ek_board_init(void)
 
 MACHINE_START(AT91SAM9G20EK_2MMC, "Atmel AT91SAM9G20-EK 2 MMC Slot Mod")
 	/* Maintainer: Rob Emanuele */
-	.phys_io	= AT91_BASE_SYS,
-	.io_pg_offst	= (AT91_VA_BASE_SYS >> 18) & 0xfffc,
 	.boot_params	= AT91_SDRAM_BASE + 0x100,
 	.timer		= &at91sam926x_timer,
 	.map_io		= ek_map_io,
diff --git a/arch/arm/mach-at91/board-sam9g20ek.c b/arch/arm/mach-at91/board-sam9g20ek.c
index c11fd47..b9c8729 100644
--- a/arch/arm/mach-at91/board-sam9g20ek.c
+++ b/arch/arm/mach-at91/board-sam9g20ek.c
@@ -310,8 +310,6 @@ static void __init ek_board_init(void)
 
 MACHINE_START(AT91SAM9G20EK, "Atmel AT91SAM9G20-EK")
 	/* Maintainer: Atmel */
-	.phys_io	= AT91_BASE_SYS,
-	.io_pg_offst	= (AT91_VA_BASE_SYS >> 18) & 0xfffc,
 	.boot_params	= AT91_SDRAM_BASE + 0x100,
 	.timer		= &at91sam926x_timer,
 	.map_io		= ek_map_io,
diff --git a/arch/arm/mach-at91/board-sam9m10g45ek.c b/arch/arm/mach-at91/board-sam9m10g45ek.c
index ee80059..3db8161 100644
--- a/arch/arm/mach-at91/board-sam9m10g45ek.c
+++ b/arch/arm/mach-at91/board-sam9m10g45ek.c
@@ -401,8 +401,6 @@ static void __init ek_board_init(void)
 
 MACHINE_START(AT91SAM9G45EKES, "Atmel AT91SAM9G45-EKES")
 	/* Maintainer: Atmel */
-	.phys_io	= AT91_BASE_SYS,
-	.io_pg_offst	= (AT91_VA_BASE_SYS >> 18) & 0xfffc,
 	.boot_params	= AT91_SDRAM_BASE + 0x100,
 	.timer		= &at91sam926x_timer,
 	.map_io		= ek_map_io,
diff --git a/arch/arm/mach-at91/board-sam9rlek.c b/arch/arm/mach-at91/board-sam9rlek.c
index 7ac20f3..3bf3408 100644
--- a/arch/arm/mach-at91/board-sam9rlek.c
+++ b/arch/arm/mach-at91/board-sam9rlek.c
@@ -329,8 +329,6 @@ static void __init ek_board_init(void)
 
 MACHINE_START(AT91SAM9RLEK, "Atmel AT91SAM9RL-EK")
 	/* Maintainer: Atmel */
-	.phys_io	= AT91_BASE_SYS,
-	.io_pg_offst	= (AT91_VA_BASE_SYS >> 18) & 0xfffc,
 	.boot_params	= AT91_SDRAM_BASE + 0x100,
 	.timer		= &at91sam926x_timer,
 	.map_io		= ek_map_io,
diff --git a/arch/arm/mach-at91/board-stamp9g20.c b/arch/arm/mach-at91/board-stamp9g20.c
index 8795827..5206eef 100644
--- a/arch/arm/mach-at91/board-stamp9g20.c
+++ b/arch/arm/mach-at91/board-stamp9g20.c
@@ -294,8 +294,6 @@ static void __init stamp9g20_board_init(void)
 
 MACHINE_START(PORTUXG20, "taskit PortuxG20")
 	/* Maintainer: taskit GmbH */
-	.phys_io	= AT91_BASE_SYS,
-	.io_pg_offst	= (AT91_VA_BASE_SYS >> 18) & 0xfffc,
 	.boot_params	= AT91_SDRAM_BASE + 0x100,
 	.timer		= &at91sam926x_timer,
 	.map_io		= portuxg20_map_io,
@@ -305,8 +303,6 @@ MACHINE_END
 
 MACHINE_START(STAMP9G20, "taskit Stamp9G20")
 	/* Maintainer: taskit GmbH */
-	.phys_io	= AT91_BASE_SYS,
-	.io_pg_offst	= (AT91_VA_BASE_SYS >> 18) & 0xfffc,
 	.boot_params	= AT91_SDRAM_BASE + 0x100,
 	.timer		= &at91sam926x_timer,
 	.map_io		= stamp9g20_map_io,
diff --git a/arch/arm/mach-at91/board-usb-a9260.c b/arch/arm/mach-at91/board-usb-a9260.c
index 905d6ef..07784ba 100644
--- a/arch/arm/mach-at91/board-usb-a9260.c
+++ b/arch/arm/mach-at91/board-usb-a9260.c
@@ -228,8 +228,6 @@ static void __init ek_board_init(void)
 
 MACHINE_START(USB_A9260, "CALAO USB_A9260")
 	/* Maintainer: calao-systems */
-	.phys_io	= AT91_BASE_SYS,
-	.io_pg_offst	= (AT91_VA_BASE_SYS >> 18) & 0xfffc,
 	.boot_params	= AT91_SDRAM_BASE + 0x100,
 	.timer		= &at91sam926x_timer,
 	.map_io		= ek_map_io,
diff --git a/arch/arm/mach-at91/board-usb-a9263.c b/arch/arm/mach-at91/board-usb-a9263.c
index b6a3480..b614508 100644
--- a/arch/arm/mach-at91/board-usb-a9263.c
+++ b/arch/arm/mach-at91/board-usb-a9263.c
@@ -244,8 +244,6 @@ static void __init ek_board_init(void)
 
 MACHINE_START(USB_A9263, "CALAO USB_A9263")
 	/* Maintainer: calao-systems */
-	.phys_io	= AT91_BASE_SYS,
-	.io_pg_offst	= (AT91_VA_BASE_SYS >> 18) & 0xfffc,
 	.boot_params	= AT91_SDRAM_BASE + 0x100,
 	.timer		= &at91sam926x_timer,
 	.map_io		= ek_map_io,
diff --git a/arch/arm/mach-at91/board-yl-9200.c b/arch/arm/mach-at91/board-yl-9200.c
index e22bf05..89df00a 100644
--- a/arch/arm/mach-at91/board-yl-9200.c
+++ b/arch/arm/mach-at91/board-yl-9200.c
@@ -594,8 +594,6 @@ static void __init yl9200_board_init(void)
 
 MACHINE_START(YL9200, "uCdragon YL-9200")
 	/* Maintainer: S.Birtles */
-	.phys_io	= AT91_BASE_SYS,
-	.io_pg_offst	= (AT91_VA_BASE_SYS >> 18) & 0xfffc,
 	.boot_params	= AT91_SDRAM_BASE + 0x100,
 	.timer		= &at91rm9200_timer,
 	.map_io		= yl9200_map_io,
diff --git a/arch/arm/mach-bcmring/arch.c b/arch/arm/mach-bcmring/arch.c
index 2f13919..73eb066 100644
--- a/arch/arm/mach-bcmring/arch.c
+++ b/arch/arm/mach-bcmring/arch.c
@@ -167,8 +167,6 @@ static void __init bcmring_fixup(struct machine_desc *desc,
 
 MACHINE_START(BCMRING, "BCMRING")
 	/* Maintainer: Broadcom Corporation */
-	.phys_io = MM_IO_START,
-	.io_pg_offst = (MM_IO_BASE >> 18) & 0xfffc,
 	.fixup = bcmring_fixup,
 	.map_io = bcmring_map_io,
 	.init_irq = bcmring_init_irq,
diff --git a/arch/arm/mach-clps711x/autcpu12.c b/arch/arm/mach-clps711x/autcpu12.c
index 5f18ecc..4a74b2c 100644
--- a/arch/arm/mach-clps711x/autcpu12.c
+++ b/arch/arm/mach-clps711x/autcpu12.c
@@ -64,8 +64,6 @@ void __init autcpu12_map_io(void)
 
 MACHINE_START(AUTCPU12, "autronix autcpu12")
 	/* Maintainer: Thomas Gleixner */
-	.phys_io	= 0x80000000,
-	.io_pg_offst	= ((0xff000000) >> 18) & 0xfffc,
 	.boot_params	= 0xc0020000,
 	.map_io		= autcpu12_map_io,
 	.init_irq	= clps711x_init_irq,
diff --git a/arch/arm/mach-clps711x/cdb89712.c b/arch/arm/mach-clps711x/cdb89712.c
index 71a80b5..5a1689d 100644
--- a/arch/arm/mach-clps711x/cdb89712.c
+++ b/arch/arm/mach-clps711x/cdb89712.c
@@ -55,8 +55,6 @@ static void __init cdb89712_map_io(void)
 
 MACHINE_START(CDB89712, "Cirrus-CDB89712")
 	/* Maintainer: Ray Lehtiniemi */
-	.phys_io	= 0x80000000,
-	.io_pg_offst	= ((0xff000000) >> 18) & 0xfffc,
 	.boot_params	= 0xc0000100,
 	.map_io		= cdb89712_map_io,
 	.init_irq	= clps711x_init_irq,
diff --git a/arch/arm/mach-clps711x/ceiva.c b/arch/arm/mach-clps711x/ceiva.c
index 8ada201..16481cf 100644
--- a/arch/arm/mach-clps711x/ceiva.c
+++ b/arch/arm/mach-clps711x/ceiva.c
@@ -56,8 +56,6 @@ static void __init ceiva_map_io(void)
 
 MACHINE_START(CEIVA, "CEIVA/Polaroid Photo MAX Digital Picture Frame")
 	/* Maintainer: Rob Scott */
-	.phys_io	= 0x80000000,
-	.io_pg_offst	= ((0xff000000) >> 18) & 0xfffc,
 	.boot_params	= 0xc0000100,
 	.map_io		= ceiva_map_io,
 	.init_irq	= clps711x_init_irq,
diff --git a/arch/arm/mach-clps711x/clep7312.c b/arch/arm/mach-clps711x/clep7312.c
index 09fb57e..2bb9749 100644
--- a/arch/arm/mach-clps711x/clep7312.c
+++ b/arch/arm/mach-clps711x/clep7312.c
@@ -38,8 +38,6 @@ fixup_clep7312(struct machine_desc *desc, struct tag *tags,
 
 MACHINE_START(CLEP7212, "Cirrus Logic 7212/7312")
 	/* Maintainer: Nobody */
-	.phys_io	= 0x80000000,
-	.io_pg_offst	= ((0xff000000) >> 18) & 0xfffc,
 	.boot_params	= 0xc0000100,
 	.fixup		= fixup_clep7312,
 	.map_io		= clps711x_map_io,
diff --git a/arch/arm/mach-clps711x/edb7211-arch.c b/arch/arm/mach-clps711x/edb7211-arch.c
index dc81cc6..f822789 100644
--- a/arch/arm/mach-clps711x/edb7211-arch.c
+++ b/arch/arm/mach-clps711x/edb7211-arch.c
@@ -52,8 +52,6 @@ fixup_edb7211(struct machine_desc *desc, struct tag *tags,
 
 MACHINE_START(EDB7211, "CL-EDB7211 (EP7211 eval board)")
 	/* Maintainer: Jon McClintock */
-	.phys_io	= 0x80000000,
-	.io_pg_offst	= ((0xff000000) >> 18) & 0xfffc,
 	.boot_params	= 0xc0020100,	/* 0xc0000000 - 0xc001ffff can be video RAM */
 	.fixup		= fixup_edb7211,
 	.map_io		= edb7211_map_io,
diff --git a/arch/arm/mach-clps711x/fortunet.c b/arch/arm/mach-clps711x/fortunet.c
index 7430e40..e736100 100644
--- a/arch/arm/mach-clps711x/fortunet.c
+++ b/arch/arm/mach-clps711x/fortunet.c
@@ -76,8 +76,6 @@ fortunet_fixup(struct machine_desc *desc, struct tag *tags,
 
 MACHINE_START(FORTUNET, "ARM-FortuNet")
 	/* Maintainer: FortuNet Inc. */
-	.phys_io	= 0x80000000,
-	.io_pg_offst	= ((0xf0000000) >> 18) & 0xfffc,
 	.boot_params	= 0x00000000,
 	.fixup		= fortunet_fixup,
 	.map_io		= clps711x_map_io,
diff --git a/arch/arm/mach-clps711x/p720t.c b/arch/arm/mach-clps711x/p720t.c
index 0d94a30..cefbce0 100644
--- a/arch/arm/mach-clps711x/p720t.c
+++ b/arch/arm/mach-clps711x/p720t.c
@@ -89,8 +89,6 @@ static void __init p720t_map_io(void)
 
 MACHINE_START(P720T, "ARM-Prospector720T")
 	/* Maintainer: ARM Ltd/Deep Blue Solutions Ltd */
-	.phys_io	= 0x80000000,
-	.io_pg_offst	= ((0xff000000) >> 18) & 0xfffc,
 	.boot_params	= 0xc0000100,
 	.fixup		= fixup_p720t,
 	.map_io		= p720t_map_io,
diff --git a/arch/arm/mach-cns3xxx/cns3420vb.c b/arch/arm/mach-cns3xxx/cns3420vb.c
index 2e30c82..7d2ab9d 100644
--- a/arch/arm/mach-cns3xxx/cns3420vb.c
+++ b/arch/arm/mach-cns3xxx/cns3420vb.c
@@ -138,8 +138,6 @@ static void __init cns3420_map_io(void)
 }
 
 MACHINE_START(CNS3420VB, "Cavium Networks CNS3420 Validation Board")
-	.phys_io	= CNS3XXX_UART0_BASE,
-	.io_pg_offst	= (CNS3XXX_UART0_BASE_VIRT >> 18) & 0xfffc,
 	.boot_params	= 0x00000100,
 	.map_io		= cns3420_map_io,
 	.init_irq	= cns3xxx_init_irq,
diff --git a/arch/arm/mach-davinci/board-da830-evm.c b/arch/arm/mach-davinci/board-da830-evm.c
index 212d970..353aaf7 100644
--- a/arch/arm/mach-davinci/board-da830-evm.c
+++ b/arch/arm/mach-davinci/board-da830-evm.c
@@ -567,8 +567,6 @@ static void __init da830_evm_map_io(void)
 }
 
 MACHINE_START(DAVINCI_DA830_EVM, "DaVinci DA830/OMAP-L137 EVM")
-	.phys_io	= IO_PHYS,
-	.io_pg_offst	= (__IO_ADDRESS(IO_PHYS) >> 18) & 0xfffc,
 	.boot_params	= (DA8XX_DDR_BASE + 0x100),
 	.map_io		= da830_evm_map_io,
 	.init_irq	= cp_intc_init,
diff --git a/arch/arm/mach-davinci/board-da850-evm.c b/arch/arm/mach-davinci/board-da850-evm.c
index 2ec3095..fddef0a 100644
--- a/arch/arm/mach-davinci/board-da850-evm.c
+++ b/arch/arm/mach-davinci/board-da850-evm.c
@@ -759,8 +759,6 @@ static void __init da850_evm_map_io(void)
 }
 
 MACHINE_START(DAVINCI_DA850_EVM, "DaVinci DA850/OMAP-L138 EVM")
-	.phys_io	= IO_PHYS,
-	.io_pg_offst	= (__IO_ADDRESS(IO_PHYS) >> 18) & 0xfffc,
 	.boot_params	= (DA8XX_DDR_BASE + 0x100),
 	.map_io		= da850_evm_map_io,
 	.init_irq	= cp_intc_init,
diff --git a/arch/arm/mach-davinci/board-dm355-evm.c b/arch/arm/mach-davinci/board-dm355-evm.c
index a319101..6e7cad1 100644
--- a/arch/arm/mach-davinci/board-dm355-evm.c
+++ b/arch/arm/mach-davinci/board-dm355-evm.c
@@ -351,8 +351,6 @@ static __init void dm355_evm_init(void)
 }
 
 MACHINE_START(DAVINCI_DM355_EVM, "DaVinci DM355 EVM")
-	.phys_io      = IO_PHYS,
-	.io_pg_offst  = (__IO_ADDRESS(IO_PHYS) >> 18) & 0xfffc,
 	.boot_params  = (0x80000100),
 	.map_io	      = dm355_evm_map_io,
 	.init_irq     = davinci_irq_init,
diff --git a/arch/arm/mach-davinci/board-dm355-leopard.c b/arch/arm/mach-davinci/board-dm355-leopard.c
index f1d8132..543f991 100644
--- a/arch/arm/mach-davinci/board-dm355-leopard.c
+++ b/arch/arm/mach-davinci/board-dm355-leopard.c
@@ -270,8 +270,6 @@ static __init void dm355_leopard_init(void)
 }
 
 MACHINE_START(DM355_LEOPARD, "DaVinci DM355 leopard")
-	.phys_io      = IO_PHYS,
-	.io_pg_offst  = (__IO_ADDRESS(IO_PHYS) >> 18) & 0xfffc,
 	.boot_params  = (0x80000100),
 	.map_io	      = dm355_leopard_map_io,
 	.init_irq     = davinci_irq_init,
diff --git a/arch/arm/mach-davinci/board-dm365-evm.c b/arch/arm/mach-davinci/board-dm365-evm.c
index 84acef1..944a0cb 100644
--- a/arch/arm/mach-davinci/board-dm365-evm.c
+++ b/arch/arm/mach-davinci/board-dm365-evm.c
@@ -613,8 +613,6 @@ static __init void dm365_evm_init(void)
 }
 
 MACHINE_START(DAVINCI_DM365_EVM, "DaVinci DM365 EVM")
-	.phys_io	= IO_PHYS,
-	.io_pg_offst	= (__IO_ADDRESS(IO_PHYS) >> 18) & 0xfffc,
 	.boot_params	= (0x80000100),
 	.map_io		= dm365_evm_map_io,
 	.init_irq	= davinci_irq_init,
diff --git a/arch/arm/mach-davinci/board-dm644x-evm.c b/arch/arm/mach-davinci/board-dm644x-evm.c
index 34c8b41..d59fba1 100644
--- a/arch/arm/mach-davinci/board-dm644x-evm.c
+++ b/arch/arm/mach-davinci/board-dm644x-evm.c
@@ -706,8 +706,6 @@ static __init void davinci_evm_init(void)
 
 MACHINE_START(DAVINCI_EVM, "DaVinci DM644x EVM")
 	/* Maintainer: MontaVista Software <source@mvista.com> */
-	.phys_io      = IO_PHYS,
-	.io_pg_offst  = (__IO_ADDRESS(IO_PHYS) >> 18) & 0xfffc,
 	.boot_params  = (DAVINCI_DDR_BASE + 0x100),
 	.map_io	      = davinci_evm_map_io,
 	.init_irq     = davinci_irq_init,
diff --git a/arch/arm/mach-davinci/board-dm646x-evm.c b/arch/arm/mach-davinci/board-dm646x-evm.c
index 6d88893..a185a49 100644
--- a/arch/arm/mach-davinci/board-dm646x-evm.c
+++ b/arch/arm/mach-davinci/board-dm646x-evm.c
@@ -751,8 +751,6 @@ void __init dm646x_board_setup_refclk(struct clk *clk)
 }
 
 MACHINE_START(DAVINCI_DM6467_EVM, "DaVinci DM646x EVM")
-	.phys_io      = IO_PHYS,
-	.io_pg_offst  = (__IO_ADDRESS(IO_PHYS) >> 18) & 0xfffc,
 	.boot_params  = (0x80000100),
 	.map_io       = davinci_map_io,
 	.init_irq     = davinci_irq_init,
@@ -761,8 +759,6 @@ MACHINE_START(DAVINCI_DM6467_EVM, "DaVinci DM646x EVM")
 MACHINE_END
 
 MACHINE_START(DAVINCI_DM6467TEVM, "DaVinci DM6467T EVM")
-	.phys_io      = IO_PHYS,
-	.io_pg_offst  = (__IO_ADDRESS(IO_PHYS) >> 18) & 0xfffc,
 	.boot_params  = (0x80000100),
 	.map_io       = davinci_map_io,
 	.init_irq     = davinci_irq_init,
diff --git a/arch/arm/mach-davinci/board-neuros-osd2.c b/arch/arm/mach-davinci/board-neuros-osd2.c
index 4c30e92..a4def88 100644
--- a/arch/arm/mach-davinci/board-neuros-osd2.c
+++ b/arch/arm/mach-davinci/board-neuros-osd2.c
@@ -275,8 +275,6 @@ static __init void davinci_ntosd2_init(void)
 
 MACHINE_START(NEUROS_OSD2, "Neuros OSD2")
 	/* Maintainer: Neuros Technologies <neuros@groups.google.com> */
-	.phys_io	= IO_PHYS,
-	.io_pg_offst	= (__IO_ADDRESS(IO_PHYS) >> 18) & 0xfffc,
 	.boot_params	= (DAVINCI_DDR_BASE + 0x100),
 	.map_io		 = davinci_ntosd2_map_io,
 	.init_irq	= davinci_irq_init,
diff --git a/arch/arm/mach-davinci/board-sffsdr.c b/arch/arm/mach-davinci/board-sffsdr.c
index 23e664a..9bdf8aa 100644
--- a/arch/arm/mach-davinci/board-sffsdr.c
+++ b/arch/arm/mach-davinci/board-sffsdr.c
@@ -154,8 +154,6 @@ static __init void davinci_sffsdr_init(void)
 
 MACHINE_START(SFFSDR, "Lyrtech SFFSDR")
 	/* Maintainer: Hugo Villeneuve hugo.villeneuve at lyrtech.com */
-	.phys_io      = IO_PHYS,
-	.io_pg_offst  = (__IO_ADDRESS(IO_PHYS) >> 18) & 0xfffc,
 	.boot_params  = (DAVINCI_DDR_BASE + 0x100),
 	.map_io	      = davinci_sffsdr_map_io,
 	.init_irq     = davinci_irq_init,
diff --git a/arch/arm/mach-dove/dove-db-setup.c b/arch/arm/mach-dove/dove-db-setup.c
index f2971b7..635ddf5 100644
--- a/arch/arm/mach-dove/dove-db-setup.c
+++ b/arch/arm/mach-dove/dove-db-setup.c
@@ -92,8 +92,6 @@ static void __init dove_db_init(void)
 }
 
 MACHINE_START(DOVE_DB, "Marvell DB-MV88AP510-BP Development Board")
-	.phys_io	= DOVE_SB_REGS_PHYS_BASE,
-	.io_pg_offst	= ((DOVE_SB_REGS_VIRT_BASE) >> 18) & 0xfffc,
 	.boot_params	= 0x00000100,
 	.init_machine	= dove_db_init,
 	.map_io		= dove_map_io,
diff --git a/arch/arm/mach-ebsa110/core.c b/arch/arm/mach-ebsa110/core.c
index c7bc7fb..5df4099 100644
--- a/arch/arm/mach-ebsa110/core.c
+++ b/arch/arm/mach-ebsa110/core.c
@@ -280,8 +280,6 @@ arch_initcall(ebsa110_init);
 
 MACHINE_START(EBSA110, "EBSA110")
 	/* Maintainer: Russell King */
-	.phys_io	= 0xe0000000,
-	.io_pg_offst	= ((0xe0000000) >> 18) & 0xfffc,
 	.boot_params	= 0x00000400,
 	.reserve_lp0	= 1,
 	.reserve_lp2	= 1,
diff --git a/arch/arm/mach-ep93xx/adssphere.c b/arch/arm/mach-ep93xx/adssphere.c
index 3a1a855..1738227 100644
--- a/arch/arm/mach-ep93xx/adssphere.c
+++ b/arch/arm/mach-ep93xx/adssphere.c
@@ -55,8 +55,6 @@ static void __init adssphere_init_machine(void)
 
 MACHINE_START(ADSSPHERE, "ADS Sphere board")
 	/* Maintainer: Lennert Buytenhek <buytenh@wantstofly.org> */
-	.phys_io	= EP93XX_APB_PHYS_BASE,
-	.io_pg_offst	= ((EP93XX_APB_VIRT_BASE) >> 18) & 0xfffc,
 	.boot_params	= EP93XX_SDCE3_PHYS_BASE_SYNC + 0x100,
 	.map_io		= ep93xx_map_io,
 	.init_irq	= ep93xx_init_irq,
diff --git a/arch/arm/mach-ep93xx/edb93xx.c b/arch/arm/mach-ep93xx/edb93xx.c
index 3884182..f6ac621 100644
--- a/arch/arm/mach-ep93xx/edb93xx.c
+++ b/arch/arm/mach-ep93xx/edb93xx.c
@@ -151,8 +151,6 @@ static void __init edb93xx_init_machine(void)
 #ifdef CONFIG_MACH_EDB9301
 MACHINE_START(EDB9301, "Cirrus Logic EDB9301 Evaluation Board")
 	/* Maintainer: H Hartley Sweeten <hsweeten@visionengravers.com> */
-	.phys_io	= EP93XX_APB_PHYS_BASE,
-	.io_pg_offst	= ((EP93XX_APB_VIRT_BASE) >> 18) & 0xfffc,
 	.boot_params	= EP93XX_SDCE3_PHYS_BASE_SYNC + 0x100,
 	.map_io		= ep93xx_map_io,
 	.init_irq	= ep93xx_init_irq,
@@ -164,8 +162,6 @@ MACHINE_END
 #ifdef CONFIG_MACH_EDB9302
 MACHINE_START(EDB9302, "Cirrus Logic EDB9302 Evaluation Board")
 	/* Maintainer: George Kashperko <george@chas.com.ua> */
-	.phys_io	= EP93XX_APB_PHYS_BASE,
-	.io_pg_offst	= ((EP93XX_APB_VIRT_BASE) >> 18) & 0xfffc,
 	.boot_params	= EP93XX_SDCE3_PHYS_BASE_SYNC + 0x100,
 	.map_io		= ep93xx_map_io,
 	.init_irq	= ep93xx_init_irq,
@@ -177,8 +173,6 @@ MACHINE_END
 #ifdef CONFIG_MACH_EDB9302A
 MACHINE_START(EDB9302A, "Cirrus Logic EDB9302A Evaluation Board")
 	/* Maintainer: Lennert Buytenhek <buytenh@wantstofly.org> */
-	.phys_io	= EP93XX_APB_PHYS_BASE,
-	.io_pg_offst	= ((EP93XX_APB_VIRT_BASE) >> 18) & 0xfffc,
 	.boot_params	= EP93XX_SDCE0_PHYS_BASE + 0x100,
 	.map_io		= ep93xx_map_io,
 	.init_irq	= ep93xx_init_irq,
@@ -190,8 +184,6 @@ MACHINE_END
 #ifdef CONFIG_MACH_EDB9307
 MACHINE_START(EDB9307, "Cirrus Logic EDB9307 Evaluation Board")
 	/* Maintainer: Herbert Valerio Riedel <hvr@gnu.org> */
-	.phys_io	= EP93XX_APB_PHYS_BASE,
-	.io_pg_offst	= ((EP93XX_APB_VIRT_BASE) >> 18) & 0xfffc,
 	.boot_params	= EP93XX_SDCE3_PHYS_BASE_SYNC + 0x100,
 	.map_io		= ep93xx_map_io,
 	.init_irq	= ep93xx_init_irq,
@@ -203,8 +195,6 @@ MACHINE_END
 #ifdef CONFIG_MACH_EDB9307A
 MACHINE_START(EDB9307A, "Cirrus Logic EDB9307A Evaluation Board")
 	/* Maintainer: H Hartley Sweeten <hsweeten@visionengravers.com> */
-	.phys_io	= EP93XX_APB_PHYS_BASE,
-	.io_pg_offst	= ((EP93XX_APB_VIRT_BASE) >> 18) & 0xfffc,
 	.boot_params	= EP93XX_SDCE0_PHYS_BASE + 0x100,
 	.map_io		= ep93xx_map_io,
 	.init_irq	= ep93xx_init_irq,
@@ -216,8 +206,6 @@ MACHINE_END
 #ifdef CONFIG_MACH_EDB9312
 MACHINE_START(EDB9312, "Cirrus Logic EDB9312 Evaluation Board")
 	/* Maintainer: Toufeeq Hussain <toufeeq_hussain@infosys.com> */
-	.phys_io	= EP93XX_APB_PHYS_BASE,
-	.io_pg_offst	= ((EP93XX_APB_VIRT_BASE) >> 18) & 0xfffc,
 	.boot_params	= EP93XX_SDCE3_PHYS_BASE_SYNC + 0x100,
 	.map_io		= ep93xx_map_io,
 	.init_irq	= ep93xx_init_irq,
@@ -229,8 +217,6 @@ MACHINE_END
 #ifdef CONFIG_MACH_EDB9315
 MACHINE_START(EDB9315, "Cirrus Logic EDB9315 Evaluation Board")
 	/* Maintainer: Lennert Buytenhek <buytenh@wantstofly.org> */
-	.phys_io	= EP93XX_APB_PHYS_BASE,
-	.io_pg_offst	= ((EP93XX_APB_VIRT_BASE) >> 18) & 0xfffc,
 	.boot_params	= EP93XX_SDCE3_PHYS_BASE_SYNC + 0x100,
 	.map_io		= ep93xx_map_io,
 	.init_irq	= ep93xx_init_irq,
@@ -242,8 +228,6 @@ MACHINE_END
 #ifdef CONFIG_MACH_EDB9315A
 MACHINE_START(EDB9315A, "Cirrus Logic EDB9315A Evaluation Board")
 	/* Maintainer: Lennert Buytenhek <buytenh@wantstofly.org> */
-	.phys_io	= EP93XX_APB_PHYS_BASE,
-	.io_pg_offst	= ((EP93XX_APB_VIRT_BASE) >> 18) & 0xfffc,
 	.boot_params	= EP93XX_SDCE0_PHYS_BASE + 0x100,
 	.map_io		= ep93xx_map_io,
 	.init_irq	= ep93xx_init_irq,
diff --git a/arch/arm/mach-ep93xx/gesbc9312.c b/arch/arm/mach-ep93xx/gesbc9312.c
index a809618..59ef08c 100644
--- a/arch/arm/mach-ep93xx/gesbc9312.c
+++ b/arch/arm/mach-ep93xx/gesbc9312.c
@@ -55,8 +55,6 @@ static void __init gesbc9312_init_machine(void)
 
 MACHINE_START(GESBC9312, "Glomation GESBC-9312-sx")
 	/* Maintainer: Lennert Buytenhek <buytenh@wantstofly.org> */
-	.phys_io	= EP93XX_APB_PHYS_BASE,
-	.io_pg_offst	= ((EP93XX_APB_VIRT_BASE) >> 18) & 0xfffc,
 	.boot_params	= EP93XX_SDCE3_PHYS_BASE_SYNC + 0x100,
 	.map_io		= ep93xx_map_io,
 	.init_irq	= ep93xx_init_irq,
diff --git a/arch/arm/mach-ep93xx/micro9.c b/arch/arm/mach-ep93xx/micro9.c
index 1cc911b..0c81868 100644
--- a/arch/arm/mach-ep93xx/micro9.c
+++ b/arch/arm/mach-ep93xx/micro9.c
@@ -96,8 +96,6 @@ static void __init micro9_init_machine(void)
 #ifdef CONFIG_MACH_MICRO9H
 MACHINE_START(MICRO9, "Contec Micro9-High")
 	/* Maintainer: Hubert Feurstein <hubert.feurstein@contec.at> */
-	.phys_io	= EP93XX_APB_PHYS_BASE,
-	.io_pg_offst	= ((EP93XX_APB_VIRT_BASE) >> 18) & 0xfffc,
 	.boot_params	= EP93XX_SDCE3_PHYS_BASE_SYNC + 0x100,
 	.map_io		= ep93xx_map_io,
 	.init_irq	= ep93xx_init_irq,
@@ -109,8 +107,6 @@ MACHINE_END
 #ifdef CONFIG_MACH_MICRO9M
 MACHINE_START(MICRO9M, "Contec Micro9-Mid")
 	/* Maintainer: Hubert Feurstein <hubert.feurstein@contec.at> */
-	.phys_io	= EP93XX_APB_PHYS_BASE,
-	.io_pg_offst	= ((EP93XX_APB_VIRT_BASE) >> 18) & 0xfffc,
 	.boot_params	= EP93XX_SDCE3_PHYS_BASE_ASYNC + 0x100,
 	.map_io		= ep93xx_map_io,
 	.init_irq	= ep93xx_init_irq,
@@ -122,8 +118,6 @@ MACHINE_END
 #ifdef CONFIG_MACH_MICRO9L
 MACHINE_START(MICRO9L, "Contec Micro9-Lite")
 	/* Maintainer: Hubert Feurstein <hubert.feurstein@contec.at> */
-	.phys_io	= EP93XX_APB_PHYS_BASE,
-	.io_pg_offst	= ((EP93XX_APB_VIRT_BASE) >> 18) & 0xfffc,
 	.boot_params	= EP93XX_SDCE3_PHYS_BASE_SYNC + 0x100,
 	.map_io		= ep93xx_map_io,
 	.init_irq	= ep93xx_init_irq,
@@ -135,8 +129,6 @@ MACHINE_END
 #ifdef CONFIG_MACH_MICRO9S
 MACHINE_START(MICRO9S, "Contec Micro9-Slim")
 	/* Maintainer: Hubert Feurstein <hubert.feurstein@contec.at> */
-	.phys_io	= EP93XX_APB_PHYS_BASE,
-	.io_pg_offst	= ((EP93XX_APB_VIRT_BASE) >> 18) & 0xfffc,
 	.boot_params	= EP93XX_SDCE3_PHYS_BASE_ASYNC + 0x100,
 	.map_io		= ep93xx_map_io,
 	.init_irq	= ep93xx_init_irq,
diff --git a/arch/arm/mach-ep93xx/simone.c b/arch/arm/mach-ep93xx/simone.c
index 388aec9..db86928 100644
--- a/arch/arm/mach-ep93xx/simone.c
+++ b/arch/arm/mach-ep93xx/simone.c
@@ -87,8 +87,6 @@ static void __init simone_init_machine(void)
 
 MACHINE_START(SIM_ONE, "Simplemachines Sim.One Board")
 /* Maintainer: Ryan Mallon <ryan@bluewatersys.com> */
-	.phys_io	= EP93XX_APB_PHYS_BASE,
-	.io_pg_offst	= ((EP93XX_APB_VIRT_BASE) >> 18) & 0xfffc,
 	.boot_params	= EP93XX_SDCE0_PHYS_BASE + 0x100,
 	.map_io		= ep93xx_map_io,
 	.init_irq	= ep93xx_init_irq,
diff --git a/arch/arm/mach-ep93xx/snappercl15.c b/arch/arm/mach-ep93xx/snappercl15.c
index 38deaee..bb02ca4 100644
--- a/arch/arm/mach-ep93xx/snappercl15.c
+++ b/arch/arm/mach-ep93xx/snappercl15.c
@@ -162,8 +162,6 @@ static void __init snappercl15_init_machine(void)
 
 MACHINE_START(SNAPPER_CL15, "Bluewater Systems Snapper CL15")
 	/* Maintainer: Ryan Mallon <ryan@bluewatersys.com> */
-	.phys_io	= EP93XX_APB_PHYS_BASE,
-	.io_pg_offst	= ((EP93XX_APB_VIRT_BASE) >> 18) & 0xfffc,
 	.boot_params	= EP93XX_SDCE0_PHYS_BASE + 0x100,
 	.map_io		= ep93xx_map_io,
 	.init_irq	= ep93xx_init_irq,
diff --git a/arch/arm/mach-ep93xx/ts72xx.c b/arch/arm/mach-ep93xx/ts72xx.c
index ae7319e..528da2c 100644
--- a/arch/arm/mach-ep93xx/ts72xx.c
+++ b/arch/arm/mach-ep93xx/ts72xx.c
@@ -276,8 +276,6 @@ static void __init ts72xx_init_machine(void)
 
 MACHINE_START(TS72XX, "Technologic Systems TS-72xx SBC")
 	/* Maintainer: Lennert Buytenhek <buytenh@wantstofly.org> */
-	.phys_io	= EP93XX_APB_PHYS_BASE,
-	.io_pg_offst	= ((EP93XX_APB_VIRT_BASE) >> 18) & 0xfffc,
 	.boot_params	= EP93XX_SDCE3_PHYS_BASE_SYNC + 0x100,
 	.map_io		= ts72xx_map_io,
 	.init_irq	= ep93xx_init_irq,
diff --git a/arch/arm/mach-footbridge/cats-hw.c b/arch/arm/mach-footbridge/cats-hw.c
index 1b996b2..5b1a8db 100644
--- a/arch/arm/mach-footbridge/cats-hw.c
+++ b/arch/arm/mach-footbridge/cats-hw.c
@@ -86,8 +86,6 @@ fixup_cats(struct machine_desc *desc, struct tag *tags,
 
 MACHINE_START(CATS, "Chalice-CATS")
 	/* Maintainer: Philip Blundell */
-	.phys_io	= DC21285_ARMCSR_BASE,
-	.io_pg_offst	= ((0xfe000000) >> 18) & 0xfffc,
 	.boot_params	= 0x00000100,
 	.soft_reboot	= 1,
 	.fixup		= fixup_cats,
diff --git a/arch/arm/mach-footbridge/ebsa285.c b/arch/arm/mach-footbridge/ebsa285.c
index 30040fd..2ef69ff 100644
--- a/arch/arm/mach-footbridge/ebsa285.c
+++ b/arch/arm/mach-footbridge/ebsa285.c
@@ -15,8 +15,6 @@
 
 MACHINE_START(EBSA285, "EBSA285")
 	/* Maintainer: Russell King */
-	.phys_io	= DC21285_ARMCSR_BASE,
-	.io_pg_offst	= ((0xfe000000) >> 18) & 0xfffc,
 	.boot_params	= 0x00000100,
 	.video_start	= 0x000a0000,
 	.video_end	= 0x000bffff,
diff --git a/arch/arm/mach-footbridge/netwinder-hw.c b/arch/arm/mach-footbridge/netwinder-hw.c
index ac7ffa6..06e514f 100644
--- a/arch/arm/mach-footbridge/netwinder-hw.c
+++ b/arch/arm/mach-footbridge/netwinder-hw.c
@@ -648,8 +648,6 @@ fixup_netwinder(struct machine_desc *desc, struct tag *tags,
 
 MACHINE_START(NETWINDER, "Rebel-NetWinder")
 	/* Maintainer: Russell King/Rebel.com */
-	.phys_io	= DC21285_ARMCSR_BASE,
-	.io_pg_offst	= ((0xfe000000) >> 18) & 0xfffc,
 	.boot_params	= 0x00000100,
 	.video_start	= 0x000a0000,
 	.video_end	= 0x000bffff,
diff --git a/arch/arm/mach-footbridge/personal.c b/arch/arm/mach-footbridge/personal.c
index e2c9f06..3285e91 100644
--- a/arch/arm/mach-footbridge/personal.c
+++ b/arch/arm/mach-footbridge/personal.c
@@ -15,8 +15,6 @@
 
 MACHINE_START(PERSONAL_SERVER, "Compaq-PersonalServer")
 	/* Maintainer: Jamey Hicks / George France */
-	.phys_io	= DC21285_ARMCSR_BASE,
-	.io_pg_offst	= ((0xfe000000) >> 18) & 0xfffc,
 	.boot_params	= 0x00000100,
 	.map_io		= footbridge_map_io,
 	.init_irq	= footbridge_init_irq,
diff --git a/arch/arm/mach-gemini/board-rut1xx.c b/arch/arm/mach-gemini/board-rut1xx.c
index e0de968..a9a0d8b 100644
--- a/arch/arm/mach-gemini/board-rut1xx.c
+++ b/arch/arm/mach-gemini/board-rut1xx.c
@@ -85,8 +85,6 @@ static void __init rut1xx_init(void)
 }
 
 MACHINE_START(RUT100, "Teltonika RUT100")
-	.phys_io	= 0x7fffc000,
-	.io_pg_offst	= ((0xffffc000) >> 18) & 0xfffc,
 	.boot_params	= 0x100,
 	.map_io		= gemini_map_io,
 	.init_irq	= gemini_init_irq,
diff --git a/arch/arm/mach-h720x/h7201-eval.c b/arch/arm/mach-h720x/h7201-eval.c
index 78be457..79f0b89 100644
--- a/arch/arm/mach-h720x/h7201-eval.c
+++ b/arch/arm/mach-h720x/h7201-eval.c
@@ -30,8 +30,6 @@
 
 MACHINE_START(H7201, "Hynix GMS30C7201")
 	/* Maintainer: Robert Schwebel, Pengutronix */
-	.phys_io	= 0x80000000,
-	.io_pg_offst	= ((0xf0000000) >> 18) & 0xfffc,
 	.boot_params	= 0xc0001000,
 	.map_io		= h720x_map_io,
 	.init_irq	= h720x_init_irq,
diff --git a/arch/arm/mach-h720x/h7202-eval.c b/arch/arm/mach-h720x/h7202-eval.c
index 8c0ba99..cc28b1e 100644
--- a/arch/arm/mach-h720x/h7202-eval.c
+++ b/arch/arm/mach-h720x/h7202-eval.c
@@ -72,8 +72,6 @@ static void __init init_eval_h7202(void)
 
 MACHINE_START(H7202, "Hynix HMS30C7202")
 	/* Maintainer: Robert Schwebel, Pengutronix */
-	.phys_io	= 0x80000000,
-	.io_pg_offst	= ((0xf0000000) >> 18) & 0xfffc,
 	.boot_params	= 0x40000100,
 	.map_io		= h720x_map_io,
 	.init_irq	= h7202_init_irq,
diff --git a/arch/arm/mach-integrator/integrator_ap.c b/arch/arm/mach-integrator/integrator_ap.c
index 227cf4d..7967040 100644
--- a/arch/arm/mach-integrator/integrator_ap.c
+++ b/arch/arm/mach-integrator/integrator_ap.c
@@ -498,8 +498,6 @@ static struct sys_timer ap_timer = {
 
 MACHINE_START(INTEGRATOR, "ARM-Integrator")
 	/* Maintainer: ARM Ltd/Deep Blue Solutions Ltd */
-	.phys_io	= 0x16000000,
-	.io_pg_offst	= ((0xf1600000) >> 18) & 0xfffc,
 	.boot_params	= 0x00000100,
 	.map_io		= ap_map_io,
 	.init_irq	= ap_init_irq,
diff --git a/arch/arm/mach-integrator/integrator_cp.c b/arch/arm/mach-integrator/integrator_cp.c
index cde57b2..7ed7e47 100644
--- a/arch/arm/mach-integrator/integrator_cp.c
+++ b/arch/arm/mach-integrator/integrator_cp.c
@@ -597,8 +597,6 @@ static struct sys_timer cp_timer = {
 
 MACHINE_START(CINTEGRATOR, "ARM-IntegratorCP")
 	/* Maintainer: ARM Ltd/Deep Blue Solutions Ltd */
-	.phys_io	= 0x16000000,
-	.io_pg_offst	= ((0xf1600000) >> 18) & 0xfffc,
 	.boot_params	= 0x00000100,
 	.map_io		= intcp_map_io,
 	.init_irq	= intcp_init_irq,
diff --git a/arch/arm/mach-iop13xx/iq81340mc.c b/arch/arm/mach-iop13xx/iq81340mc.c
index f91f315..9b5a63f 100644
--- a/arch/arm/mach-iop13xx/iq81340mc.c
+++ b/arch/arm/mach-iop13xx/iq81340mc.c
@@ -91,8 +91,6 @@ static struct sys_timer iq81340mc_timer = {
 
 MACHINE_START(IQ81340MC, "Intel IQ81340MC")
 	/* Maintainer: Dan Williams <dan.j.williams@intel.com> */
-	.phys_io        = IOP13XX_PMMR_PHYS_MEM_BASE,
-	.io_pg_offst    = (IOP13XX_PMMR_VIRT_MEM_BASE >> 18) & 0xfffc,
 	.boot_params    = 0x00000100,
 	.map_io         = iop13xx_map_io,
 	.init_irq       = iop13xx_init_irq,
diff --git a/arch/arm/mach-iop13xx/iq81340sc.c b/arch/arm/mach-iop13xx/iq81340sc.c
index ddb7a34..df3492a 100644
--- a/arch/arm/mach-iop13xx/iq81340sc.c
+++ b/arch/arm/mach-iop13xx/iq81340sc.c
@@ -93,8 +93,6 @@ static struct sys_timer iq81340sc_timer = {
 
 MACHINE_START(IQ81340SC, "Intel IQ81340SC")
 	/* Maintainer: Dan Williams <dan.j.williams@intel.com> */
-	.phys_io	= IOP13XX_PMMR_PHYS_MEM_BASE,
-	.io_pg_offst	= (IOP13XX_PMMR_VIRT_MEM_BASE >> 18) & 0xfffc,
 	.boot_params    = 0x00000100,
 	.map_io         = iop13xx_map_io,
 	.init_irq       = iop13xx_init_irq,
diff --git a/arch/arm/mach-iop32x/em7210.c b/arch/arm/mach-iop32x/em7210.c
index 2bef9b6..779f924 100644
--- a/arch/arm/mach-iop32x/em7210.c
+++ b/arch/arm/mach-iop32x/em7210.c
@@ -203,8 +203,6 @@ static void __init em7210_init_machine(void)
 }
 
 MACHINE_START(EM7210, "Lanner EM7210")
-	.phys_io	= IQ31244_UART,
-	.io_pg_offst	= ((IQ31244_UART) >> 18) & 0xfffc,
 	.boot_params	= 0xa0000100,
 	.map_io		= em7210_map_io,
 	.init_irq	= iop32x_init_irq,
diff --git a/arch/arm/mach-iop32x/glantank.c b/arch/arm/mach-iop32x/glantank.c
index 10384fc..c6b6f9c 100644
--- a/arch/arm/mach-iop32x/glantank.c
+++ b/arch/arm/mach-iop32x/glantank.c
@@ -207,8 +207,6 @@ static void __init glantank_init_machine(void)
 
 MACHINE_START(GLANTANK, "GLAN Tank")
 	/* Maintainer: Lennert Buytenhek <buytenh@wantstofly.org> */
-	.phys_io	= GLANTANK_UART,
-	.io_pg_offst	= ((GLANTANK_UART) >> 18) & 0xfffc,
 	.boot_params	= 0xa0000100,
 	.map_io		= glantank_map_io,
 	.init_irq	= iop32x_init_irq,
diff --git a/arch/arm/mach-iop32x/iq31244.c b/arch/arm/mach-iop32x/iq31244.c
index d6ac85f..fde962c 100644
--- a/arch/arm/mach-iop32x/iq31244.c
+++ b/arch/arm/mach-iop32x/iq31244.c
@@ -313,8 +313,6 @@ __setup("force_ep80219", force_ep80219_setup);
 
 MACHINE_START(IQ31244, "Intel IQ31244")
 	/* Maintainer: Intel Corp. */
-	.phys_io	= IQ31244_UART,
-	.io_pg_offst	= ((IQ31244_UART) >> 18) & 0xfffc,
 	.boot_params	= 0xa0000100,
 	.map_io		= iq31244_map_io,
 	.init_irq	= iop32x_init_irq,
@@ -329,8 +327,6 @@ MACHINE_END
  */
 MACHINE_START(EP80219, "Intel EP80219")
 	/* Maintainer: Intel Corp. */
-	.phys_io	= IQ31244_UART,
-	.io_pg_offst	= ((IQ31244_UART) >> 18) & 0xfffc,
 	.boot_params	= 0xa0000100,
 	.map_io		= iq31244_map_io,
 	.init_irq	= iop32x_init_irq,
diff --git a/arch/arm/mach-iop32x/iq80321.c b/arch/arm/mach-iop32x/iq80321.c
index c6a0e4e..3a95950 100644
--- a/arch/arm/mach-iop32x/iq80321.c
+++ b/arch/arm/mach-iop32x/iq80321.c
@@ -186,8 +186,6 @@ static void __init iq80321_init_machine(void)
 
 MACHINE_START(IQ80321, "Intel IQ80321")
 	/* Maintainer: Intel Corp. */
-	.phys_io	= IQ80321_UART,
-	.io_pg_offst	= ((IQ80321_UART) >> 18) & 0xfffc,
 	.boot_params	= 0xa0000100,
 	.map_io		= iq80321_map_io,
 	.init_irq	= iop32x_init_irq,
diff --git a/arch/arm/mach-iop32x/n2100.c b/arch/arm/mach-iop32x/n2100.c
index f108a31..626aa37 100644
--- a/arch/arm/mach-iop32x/n2100.c
+++ b/arch/arm/mach-iop32x/n2100.c
@@ -327,8 +327,6 @@ static void __init n2100_init_machine(void)
 
 MACHINE_START(N2100, "Thecus N2100")
 	/* Maintainer: Lennert Buytenhek <buytenh@wantstofly.org> */
-	.phys_io	= N2100_UART,
-	.io_pg_offst	= ((N2100_UART) >> 18) & 0xfffc,
 	.boot_params	= 0xa0000100,
 	.map_io		= n2100_map_io,
 	.init_irq	= iop32x_init_irq,
diff --git a/arch/arm/mach-iop33x/iq80331.c b/arch/arm/mach-iop33x/iq80331.c
index c6ff552..c565f8d 100644
--- a/arch/arm/mach-iop33x/iq80331.c
+++ b/arch/arm/mach-iop33x/iq80331.c
@@ -141,8 +141,6 @@ static void __init iq80331_init_machine(void)
 
 MACHINE_START(IQ80331, "Intel IQ80331")
 	/* Maintainer: Intel Corp. */
-	.phys_io	= 0xfefff000,
-	.io_pg_offst	= ((0xfffff000) >> 18) & 0xfffc,
 	.boot_params	= 0x00000100,
 	.map_io		= iop3xx_map_io,
 	.init_irq	= iop33x_init_irq,
diff --git a/arch/arm/mach-iop33x/iq80332.c b/arch/arm/mach-iop33x/iq80332.c
index fbf5514..36a9efb 100644
--- a/arch/arm/mach-iop33x/iq80332.c
+++ b/arch/arm/mach-iop33x/iq80332.c
@@ -141,8 +141,6 @@ static void __init iq80332_init_machine(void)
 
 MACHINE_START(IQ80332, "Intel IQ80332")
 	/* Maintainer: Intel Corp. */
-	.phys_io	= 0xfefff000,
-	.io_pg_offst	= ((0xfffff000) >> 18) & 0xfffc,
 	.boot_params	= 0x00000100,
 	.map_io		= iop3xx_map_io,
 	.init_irq	= iop33x_init_irq,
diff --git a/arch/arm/mach-ixp2000/enp2611.c b/arch/arm/mach-ixp2000/enp2611.c
index 1a557e0..88663ab 100644
--- a/arch/arm/mach-ixp2000/enp2611.c
+++ b/arch/arm/mach-ixp2000/enp2611.c
@@ -253,8 +253,6 @@ static void __init enp2611_init_machine(void)
 
 MACHINE_START(ENP2611, "Radisys ENP-2611 PCI network processor board")
 	/* Maintainer: Lennert Buytenhek <buytenh@wantstofly.org> */
-	.phys_io	= IXP2000_UART_PHYS_BASE,
-	.io_pg_offst	= ((IXP2000_UART_VIRT_BASE) >> 18) & 0xfffc,
 	.boot_params	= 0x00000100,
 	.map_io		= enp2611_map_io,
 	.init_irq	= ixp2000_init_irq,
diff --git a/arch/arm/mach-ixp2000/ixdp2400.c b/arch/arm/mach-ixp2000/ixdp2400.c
index 55e5c69..dfffc1e 100644
--- a/arch/arm/mach-ixp2000/ixdp2400.c
+++ b/arch/arm/mach-ixp2000/ixdp2400.c
@@ -170,8 +170,6 @@ void __init ixdp2400_init_irq(void)
 
 MACHINE_START(IXDP2400, "Intel IXDP2400 Development Platform")
 	/* Maintainer: MontaVista Software, Inc. */
-	.phys_io	= IXP2000_UART_PHYS_BASE,
-	.io_pg_offst	= ((IXP2000_UART_VIRT_BASE) >> 18) & 0xfffc,
 	.boot_params	= 0x00000100,
 	.map_io		= ixdp2x00_map_io,
 	.init_irq	= ixdp2400_init_irq,
diff --git a/arch/arm/mach-ixp2000/ixdp2800.c b/arch/arm/mach-ixp2000/ixdp2800.c
index 237b61a..cd4c9bc 100644
--- a/arch/arm/mach-ixp2000/ixdp2800.c
+++ b/arch/arm/mach-ixp2000/ixdp2800.c
@@ -285,8 +285,6 @@ void __init ixdp2800_init_irq(void)
 
 MACHINE_START(IXDP2800, "Intel IXDP2800 Development Platform")
 	/* Maintainer: MontaVista Software, Inc. */
-	.phys_io	= IXP2000_UART_PHYS_BASE,
-	.io_pg_offst	= ((IXP2000_UART_VIRT_BASE) >> 18) & 0xfffc,
 	.boot_params	= 0x00000100,
 	.map_io		= ixdp2x00_map_io,
 	.init_irq	= ixdp2800_init_irq,
diff --git a/arch/arm/mach-ixp2000/ixdp2x01.c b/arch/arm/mach-ixp2000/ixdp2x01.c
index 0369ec4..6c121bd 100644
--- a/arch/arm/mach-ixp2000/ixdp2x01.c
+++ b/arch/arm/mach-ixp2000/ixdp2x01.c
@@ -416,8 +416,6 @@ static void __init ixdp2x01_init_machine(void)
 #ifdef CONFIG_ARCH_IXDP2401
 MACHINE_START(IXDP2401, "Intel IXDP2401 Development Platform")
 	/* Maintainer: MontaVista Software, Inc. */
-	.phys_io	= IXP2000_UART_PHYS_BASE,
-	.io_pg_offst	= ((IXP2000_UART_VIRT_BASE) >> 18) & 0xfffc,
 	.boot_params	= 0x00000100,
 	.map_io		= ixdp2x01_map_io,
 	.init_irq	= ixdp2x01_init_irq,
@@ -429,8 +427,6 @@ MACHINE_END
 #ifdef CONFIG_ARCH_IXDP2801
 MACHINE_START(IXDP2801, "Intel IXDP2801 Development Platform")
 	/* Maintainer: MontaVista Software, Inc. */
-	.phys_io	= IXP2000_UART_PHYS_BASE,
-	.io_pg_offst	= ((IXP2000_UART_VIRT_BASE) >> 18) & 0xfffc,
 	.boot_params	= 0x00000100,
 	.map_io		= ixdp2x01_map_io,
 	.init_irq	= ixdp2x01_init_irq,
@@ -444,8 +440,6 @@ MACHINE_END
  */
 MACHINE_START(IXDP28X5, "Intel IXDP2805/2855 Development Platform")
 	/* Maintainer: MontaVista Software, Inc. */
-	.phys_io	= IXP2000_UART_PHYS_BASE,
-	.io_pg_offst	= ((IXP2000_UART_VIRT_BASE) >> 18) & 0xfffc,
 	.boot_params	= 0x00000100,
 	.map_io		= ixdp2x01_map_io,
 	.init_irq	= ixdp2x01_init_irq,
diff --git a/arch/arm/mach-ixp23xx/espresso.c b/arch/arm/mach-ixp23xx/espresso.c
index 1c06bfc..e25e5fe 100644
--- a/arch/arm/mach-ixp23xx/espresso.c
+++ b/arch/arm/mach-ixp23xx/espresso.c
@@ -85,8 +85,6 @@ static void __init espresso_init(void)
 
 MACHINE_START(ESPRESSO, "IP Fabrics Double Espresso")
 	/* Maintainer: Lennert Buytenhek */
-	.phys_io	= IXP23XX_PERIPHERAL_PHYS,
-	.io_pg_offst	= ((IXP23XX_PERIPHERAL_VIRT >> 18)) & 0xfffc,
 	.map_io		= ixp23xx_map_io,
 	.init_irq	= ixp23xx_init_irq,
 	.timer		= &ixp23xx_timer,
diff --git a/arch/arm/mach-ixp23xx/ixdp2351.c b/arch/arm/mach-ixp23xx/ixdp2351.c
index f1b124a..664e39c 100644
--- a/arch/arm/mach-ixp23xx/ixdp2351.c
+++ b/arch/arm/mach-ixp23xx/ixdp2351.c
@@ -328,8 +328,6 @@ static void __init ixdp2351_init(void)
 
 MACHINE_START(IXDP2351, "Intel IXDP2351 Development Platform")
 	/* Maintainer: MontaVista Software, Inc. */
-	.phys_io	= IXP23XX_PERIPHERAL_PHYS,
-	.io_pg_offst	= ((IXP23XX_PERIPHERAL_VIRT >> 18)) & 0xfffc,
 	.map_io		= ixdp2351_map_io,
 	.init_irq	= ixdp2351_init_irq,
 	.timer		= &ixp23xx_timer,
diff --git a/arch/arm/mach-ixp23xx/roadrunner.c b/arch/arm/mach-ixp23xx/roadrunner.c
index 6d38d76..76c61ba 100644
--- a/arch/arm/mach-ixp23xx/roadrunner.c
+++ b/arch/arm/mach-ixp23xx/roadrunner.c
@@ -171,8 +171,6 @@ static void __init roadrunner_init(void)
 
 MACHINE_START(ROADRUNNER, "ADI Engineering RoadRunner Development Platform")
 	/* Maintainer: Deepak Saxena */
-	.phys_io	= IXP23XX_PERIPHERAL_PHYS,
-	.io_pg_offst	= ((IXP23XX_PERIPHERAL_VIRT >> 18)) & 0xfffc,
 	.map_io		= ixp23xx_map_io,
 	.init_irq	= ixp23xx_init_irq,
 	.timer		= &ixp23xx_timer,
diff --git a/arch/arm/mach-ixp4xx/avila-setup.c b/arch/arm/mach-ixp4xx/avila-setup.c
index d8bc86d..73745ff 100644
--- a/arch/arm/mach-ixp4xx/avila-setup.c
+++ b/arch/arm/mach-ixp4xx/avila-setup.c
@@ -164,8 +164,6 @@ static void __init avila_init(void)
 
 MACHINE_START(AVILA, "Gateworks Avila Network Platform")
 	/* Maintainer: Deepak Saxena <dsaxena@plexity.net> */
-	.phys_io	= IXP4XX_PERIPHERAL_BASE_PHYS,
-	.io_pg_offst	= ((IXP4XX_PERIPHERAL_BASE_VIRT) >> 18) & 0xfffc,
 	.map_io		= ixp4xx_map_io,
 	.init_irq	= ixp4xx_init_irq,
 	.timer		= &ixp4xx_timer,
@@ -181,8 +179,6 @@ MACHINE_END
 #ifdef CONFIG_MACH_LOFT
 MACHINE_START(LOFT, "Giant Shoulder Inc Loft board")
 	/* Maintainer: Tom Billman <kernel@giantshoulderinc.com> */
-	.phys_io	= IXP4XX_PERIPHERAL_BASE_PHYS,
-	.io_pg_offst	= ((IXP4XX_PERIPHERAL_BASE_VIRT) >> 18) & 0xfffc,
 	.map_io		= ixp4xx_map_io,
 	.init_irq	= ixp4xx_init_irq,
 	.timer		= &ixp4xx_timer,
diff --git a/arch/arm/mach-ixp4xx/coyote-setup.c b/arch/arm/mach-ixp4xx/coyote-setup.c
index 31a47f6..355e3de 100644
--- a/arch/arm/mach-ixp4xx/coyote-setup.c
+++ b/arch/arm/mach-ixp4xx/coyote-setup.c
@@ -109,8 +109,6 @@ static void __init coyote_init(void)
 #ifdef CONFIG_ARCH_ADI_COYOTE
 MACHINE_START(ADI_COYOTE, "ADI Engineering Coyote")
 	/* Maintainer: MontaVista Software, Inc. */
-	.phys_io	= IXP4XX_PERIPHERAL_BASE_PHYS,
-	.io_pg_offst	= ((IXP4XX_PERIPHERAL_BASE_VIRT) >> 18) & 0xfffc,
 	.map_io		= ixp4xx_map_io,
 	.init_irq	= ixp4xx_init_irq,
 	.timer		= &ixp4xx_timer,
@@ -126,8 +124,6 @@ MACHINE_END
 #ifdef CONFIG_MACH_IXDPG425
 MACHINE_START(IXDPG425, "Intel IXDPG425")
 	/* Maintainer: MontaVista Software, Inc. */
-	.phys_io	= IXP4XX_PERIPHERAL_BASE_PHYS,
-	.io_pg_offst	= ((IXP4XX_PERIPHERAL_BASE_VIRT) >> 18) & 0xfffc,
 	.map_io		= ixp4xx_map_io,
 	.init_irq	= ixp4xx_init_irq,
 	.timer		= &ixp4xx_timer,
diff --git a/arch/arm/mach-ixp4xx/dsmg600-setup.c b/arch/arm/mach-ixp4xx/dsmg600-setup.c
index 7c1fa54..d398229 100644
--- a/arch/arm/mach-ixp4xx/dsmg600-setup.c
+++ b/arch/arm/mach-ixp4xx/dsmg600-setup.c
@@ -279,8 +279,6 @@ static void __init dsmg600_init(void)
 
 MACHINE_START(DSMG600, "D-Link DSM-G600 RevA")
 	/* Maintainer: www.nslu2-linux.org */
-	.phys_io	= IXP4XX_PERIPHERAL_BASE_PHYS,
-	.io_pg_offst	= ((IXP4XX_PERIPHERAL_BASE_VIRT) >> 18) & 0xFFFC,
 	.boot_params	= 0x00000100,
 	.map_io		= ixp4xx_map_io,
 	.init_irq	= ixp4xx_init_irq,
diff --git a/arch/arm/mach-ixp4xx/fsg-setup.c b/arch/arm/mach-ixp4xx/fsg-setup.c
index e7f4bef..727ee39 100644
--- a/arch/arm/mach-ixp4xx/fsg-setup.c
+++ b/arch/arm/mach-ixp4xx/fsg-setup.c
@@ -270,8 +270,6 @@ static void __init fsg_init(void)
 
 MACHINE_START(FSG, "Freecom FSG-3")
 	/* Maintainer: www.nslu2-linux.org */
-	.phys_io	= IXP4XX_PERIPHERAL_BASE_PHYS,
-	.io_pg_offst	= ((IXP4XX_PERIPHERAL_BASE_VIRT) >> 18) & 0xfffc,
 	.map_io		= ixp4xx_map_io,
 	.init_irq	= ixp4xx_init_irq,
 	.timer		= &ixp4xx_timer,
diff --git a/arch/arm/mach-ixp4xx/gateway7001-setup.c b/arch/arm/mach-ixp4xx/gateway7001-setup.c
index 2583b2a..9dc0b4e 100644
--- a/arch/arm/mach-ixp4xx/gateway7001-setup.c
+++ b/arch/arm/mach-ixp4xx/gateway7001-setup.c
@@ -96,8 +96,6 @@ static void __init gateway7001_init(void)
 #ifdef CONFIG_MACH_GATEWAY7001
 MACHINE_START(GATEWAY7001, "Gateway 7001 AP")
 	/* Maintainer: Imre Kaloz <kaloz@openwrt.org> */
-	.phys_io	= IXP4XX_PERIPHERAL_BASE_PHYS,
-	.io_pg_offst	= ((IXP4XX_PERIPHERAL_BASE_VIRT) >> 18) & 0xfffc,
 	.map_io		= ixp4xx_map_io,
 	.init_irq	= ixp4xx_init_irq,
 	.timer		= &ixp4xx_timer,
diff --git a/arch/arm/mach-ixp4xx/goramo_mlr.c b/arch/arm/mach-ixp4xx/goramo_mlr.c
index 1c28048..d0e4861 100644
--- a/arch/arm/mach-ixp4xx/goramo_mlr.c
+++ b/arch/arm/mach-ixp4xx/goramo_mlr.c
@@ -496,8 +496,6 @@ subsys_initcall(gmlr_pci_init);
 
 MACHINE_START(GORAMO_MLR, "MultiLink")
 	/* Maintainer: Krzysztof Halasa */
-	.phys_io	= IXP4XX_PERIPHERAL_BASE_PHYS,
-	.io_pg_offst	= ((IXP4XX_PERIPHERAL_BASE_VIRT) >> 18) & 0xFFFC,
 	.map_io		= ixp4xx_map_io,
 	.init_irq	= ixp4xx_init_irq,
 	.timer		= &ixp4xx_timer,
diff --git a/arch/arm/mach-ixp4xx/gtwx5715-setup.c b/arch/arm/mach-ixp4xx/gtwx5715-setup.c
index c67586b..77abead 100644
--- a/arch/arm/mach-ixp4xx/gtwx5715-setup.c
+++ b/arch/arm/mach-ixp4xx/gtwx5715-setup.c
@@ -164,8 +164,6 @@ static void __init gtwx5715_init(void)
 
 MACHINE_START(GTWX5715, "Gemtek GTWX5715 (Linksys WRV54G)")
 	/* Maintainer: George Joseph */
-	.phys_io	= IXP4XX_UART2_BASE_PHYS,
-	.io_pg_offst	= ((IXP4XX_UART2_BASE_VIRT) >> 18) & 0xfffc,
 	.map_io		= ixp4xx_map_io,
 	.init_irq	= ixp4xx_init_irq,
 	.timer		= &ixp4xx_timer,
diff --git a/arch/arm/mach-ixp4xx/ixdp425-setup.c b/arch/arm/mach-ixp4xx/ixdp425-setup.c
index 827cbc4..eb5f182 100644
--- a/arch/arm/mach-ixp4xx/ixdp425-setup.c
+++ b/arch/arm/mach-ixp4xx/ixdp425-setup.c
@@ -256,8 +256,6 @@ static void __init ixdp425_init(void)
 #ifdef CONFIG_ARCH_IXDP425
 MACHINE_START(IXDP425, "Intel IXDP425 Development Platform")
 	/* Maintainer: MontaVista Software, Inc. */
-	.phys_io	= IXP4XX_PERIPHERAL_BASE_PHYS,
-	.io_pg_offst	= ((IXP4XX_PERIPHERAL_BASE_VIRT) >> 18) & 0xfffc,
 	.map_io		= ixp4xx_map_io,
 	.init_irq	= ixp4xx_init_irq,
 	.timer		= &ixp4xx_timer,
@@ -269,8 +267,6 @@ MACHINE_END
 #ifdef CONFIG_MACH_IXDP465
 MACHINE_START(IXDP465, "Intel IXDP465 Development Platform")
 	/* Maintainer: MontaVista Software, Inc. */
-	.phys_io	= IXP4XX_PERIPHERAL_BASE_PHYS,
-	.io_pg_offst	= ((IXP4XX_PERIPHERAL_BASE_VIRT) >> 18) & 0xfffc,
 	.map_io		= ixp4xx_map_io,
 	.init_irq	= ixp4xx_init_irq,
 	.timer		= &ixp4xx_timer,
@@ -282,8 +278,6 @@ MACHINE_END
 #ifdef CONFIG_ARCH_PRPMC1100
 MACHINE_START(IXCDP1100, "Intel IXCDP1100 Development Platform")
 	/* Maintainer: MontaVista Software, Inc. */
-	.phys_io	= IXP4XX_PERIPHERAL_BASE_PHYS,
-	.io_pg_offst	= ((IXP4XX_PERIPHERAL_BASE_VIRT) >> 18) & 0xfffc,
 	.map_io		= ixp4xx_map_io,
 	.init_irq	= ixp4xx_init_irq,
 	.timer		= &ixp4xx_timer,
@@ -295,8 +289,6 @@ MACHINE_END
 #ifdef CONFIG_MACH_KIXRP435
 MACHINE_START(KIXRP435, "Intel KIXRP435 Reference Platform")
 	/* Maintainer: MontaVista Software, Inc. */
-	.phys_io	= IXP4XX_PERIPHERAL_BASE_PHYS,
-	.io_pg_offst	= ((IXP4XX_PERIPHERAL_BASE_VIRT) >> 18) & 0xfffc,
 	.map_io		= ixp4xx_map_io,
 	.init_irq	= ixp4xx_init_irq,
 	.timer		= &ixp4xx_timer,
diff --git a/arch/arm/mach-ixp4xx/nas100d-setup.c b/arch/arm/mach-ixp4xx/nas100d-setup.c
index e3ee880..f18fee7 100644
--- a/arch/arm/mach-ixp4xx/nas100d-setup.c
+++ b/arch/arm/mach-ixp4xx/nas100d-setup.c
@@ -314,8 +314,6 @@ static void __init nas100d_init(void)
 
 MACHINE_START(NAS100D, "Iomega NAS 100d")
 	/* Maintainer: www.nslu2-linux.org */
-	.phys_io	= IXP4XX_PERIPHERAL_BASE_PHYS,
-	.io_pg_offst	= ((IXP4XX_PERIPHERAL_BASE_VIRT) >> 18) & 0xFFFC,
 	.boot_params	= 0x00000100,
 	.map_io		= ixp4xx_map_io,
 	.init_irq	= ixp4xx_init_irq,
diff --git a/arch/arm/mach-ixp4xx/nslu2-setup.c b/arch/arm/mach-ixp4xx/nslu2-setup.c
index c14e003..f79b62e 100644
--- a/arch/arm/mach-ixp4xx/nslu2-setup.c
+++ b/arch/arm/mach-ixp4xx/nslu2-setup.c
@@ -300,8 +300,6 @@ static void __init nslu2_init(void)
 
 MACHINE_START(NSLU2, "Linksys NSLU2")
 	/* Maintainer: www.nslu2-linux.org */
-	.phys_io	= IXP4XX_PERIPHERAL_BASE_PHYS,
-	.io_pg_offst	= ((IXP4XX_PERIPHERAL_BASE_VIRT) >> 18) & 0xFFFC,
 	.boot_params	= 0x00000100,
 	.map_io		= ixp4xx_map_io,
 	.init_irq	= ixp4xx_init_irq,
diff --git a/arch/arm/mach-ixp4xx/wg302v2-setup.c b/arch/arm/mach-ixp4xx/wg302v2-setup.c
index 4dd7486..5d148c7 100644
--- a/arch/arm/mach-ixp4xx/wg302v2-setup.c
+++ b/arch/arm/mach-ixp4xx/wg302v2-setup.c
@@ -97,8 +97,6 @@ static void __init wg302v2_init(void)
 #ifdef CONFIG_MACH_WG302V2
 MACHINE_START(WG302V2, "Netgear WG302 v2 / WAG302 v2")
 	/* Maintainer: Imre Kaloz <kaloz@openwrt.org> */
-	.phys_io	= IXP4XX_PERIPHERAL_BASE_PHYS,
-	.io_pg_offst	= ((IXP4XX_PERIPHERAL_BASE_VIRT) >> 18) & 0xfffc,
 	.map_io		= ixp4xx_map_io,
 	.init_irq	= ixp4xx_init_irq,
 	.timer		= &ixp4xx_timer,
diff --git a/arch/arm/mach-kirkwood/db88f6281-bp-setup.c b/arch/arm/mach-kirkwood/db88f6281-bp-setup.c
index 39bdf4b..6acc167 100644
--- a/arch/arm/mach-kirkwood/db88f6281-bp-setup.c
+++ b/arch/arm/mach-kirkwood/db88f6281-bp-setup.c
@@ -83,8 +83,6 @@ subsys_initcall(db88f6281_pci_init);
 
 MACHINE_START(DB88F6281_BP, "Marvell DB-88F6281-BP Development Board")
 	/* Maintainer: Saeed Bishara <saeed@marvell.com> */
-	.phys_io	= KIRKWOOD_REGS_PHYS_BASE,
-	.io_pg_offst	= ((KIRKWOOD_REGS_VIRT_BASE) >> 18) & 0xfffc,
 	.boot_params	= 0x00000100,
 	.init_machine	= db88f6281_init,
 	.map_io		= kirkwood_map_io,
diff --git a/arch/arm/mach-kirkwood/guruplug-setup.c b/arch/arm/mach-kirkwood/guruplug-setup.c
index 54d07c8..8f47dc0 100644
--- a/arch/arm/mach-kirkwood/guruplug-setup.c
+++ b/arch/arm/mach-kirkwood/guruplug-setup.c
@@ -121,8 +121,6 @@ static void __init guruplug_init(void)
 
 MACHINE_START(GURUPLUG, "Marvell GuruPlug Reference Board")
 	/* Maintainer: Siddarth Gore <gores@marvell.com> */
-	.phys_io	= KIRKWOOD_REGS_PHYS_BASE,
-	.io_pg_offst	= ((KIRKWOOD_REGS_VIRT_BASE) >> 18) & 0xfffc,
 	.boot_params	= 0x00000100,
 	.init_machine	= guruplug_init,
 	.map_io		= kirkwood_map_io,
diff --git a/arch/arm/mach-kirkwood/mv88f6281gtw_ge-setup.c b/arch/arm/mach-kirkwood/mv88f6281gtw_ge-setup.c
index 5e6f711..69cc1c5 100644
--- a/arch/arm/mach-kirkwood/mv88f6281gtw_ge-setup.c
+++ b/arch/arm/mach-kirkwood/mv88f6281gtw_ge-setup.c
@@ -163,8 +163,6 @@ subsys_initcall(mv88f6281gtw_ge_pci_init);
 
 MACHINE_START(MV88F6281GTW_GE, "Marvell 88F6281 GTW GE Board")
 	/* Maintainer: Lennert Buytenhek <buytenh@marvell.com> */
-	.phys_io	= KIRKWOOD_REGS_PHYS_BASE,
-	.io_pg_offst	= ((KIRKWOOD_REGS_VIRT_BASE) >> 18) & 0xfffc,
 	.boot_params	= 0x00000100,
 	.init_machine	= mv88f6281gtw_ge_init,
 	.map_io		= kirkwood_map_io,
diff --git a/arch/arm/mach-kirkwood/netspace_v2-setup.c b/arch/arm/mach-kirkwood/netspace_v2-setup.c
index 3ae158d..6eed3cd 100644
--- a/arch/arm/mach-kirkwood/netspace_v2-setup.c
+++ b/arch/arm/mach-kirkwood/netspace_v2-setup.c
@@ -311,8 +311,6 @@ static void __init netspace_v2_init(void)
 
 #ifdef CONFIG_MACH_NETSPACE_V2
 MACHINE_START(NETSPACE_V2, "LaCie Network Space v2")
-	.phys_io	= KIRKWOOD_REGS_PHYS_BASE,
-	.io_pg_offst	= ((KIRKWOOD_REGS_VIRT_BASE) >> 18) & 0xfffc,
 	.boot_params	= 0x00000100,
 	.init_machine	= netspace_v2_init,
 	.map_io		= kirkwood_map_io,
@@ -323,8 +321,6 @@ MACHINE_END
 
 #ifdef CONFIG_MACH_INETSPACE_V2
 MACHINE_START(INETSPACE_V2, "LaCie Internet Space v2")
-	.phys_io	= KIRKWOOD_REGS_PHYS_BASE,
-	.io_pg_offst	= ((KIRKWOOD_REGS_VIRT_BASE) >> 18) & 0xfffc,
 	.boot_params	= 0x00000100,
 	.init_machine	= netspace_v2_init,
 	.map_io		= kirkwood_map_io,
diff --git a/arch/arm/mach-kirkwood/netxbig_v2-setup.c b/arch/arm/mach-kirkwood/netxbig_v2-setup.c
index 8a2bb02..2df4415 100644
--- a/arch/arm/mach-kirkwood/netxbig_v2-setup.c
+++ b/arch/arm/mach-kirkwood/netxbig_v2-setup.c
@@ -392,8 +392,6 @@ static void __init netxbig_v2_init(void)
 
 #ifdef CONFIG_MACH_NET2BIG_V2
 MACHINE_START(NET2BIG_V2, "LaCie 2Big Network v2")
-	.phys_io	= KIRKWOOD_REGS_PHYS_BASE,
-	.io_pg_offst	= ((KIRKWOOD_REGS_VIRT_BASE) >> 18) & 0xfffc,
 	.boot_params	= 0x00000100,
 	.init_machine	= netxbig_v2_init,
 	.map_io		= kirkwood_map_io,
@@ -404,8 +402,6 @@ MACHINE_END
 
 #ifdef CONFIG_MACH_NET5BIG_V2
 MACHINE_START(NET5BIG_V2, "LaCie 5Big Network v2")
-	.phys_io	= KIRKWOOD_REGS_PHYS_BASE,
-	.io_pg_offst	= ((KIRKWOOD_REGS_VIRT_BASE) >> 18) & 0xfffc,
 	.boot_params	= 0x00000100,
 	.init_machine	= netxbig_v2_init,
 	.map_io		= kirkwood_map_io,
diff --git a/arch/arm/mach-kirkwood/openrd-setup.c b/arch/arm/mach-kirkwood/openrd-setup.c
index ad3f1ec..d37eff3 100644
--- a/arch/arm/mach-kirkwood/openrd-setup.c
+++ b/arch/arm/mach-kirkwood/openrd-setup.c
@@ -94,8 +94,6 @@ subsys_initcall(openrd_pci_init);
 #ifdef CONFIG_MACH_OPENRD_BASE
 MACHINE_START(OPENRD_BASE, "Marvell OpenRD Base Board")
 	/* Maintainer: Dhaval Vasa <dhaval.vasa@einfochips.com> */
-	.phys_io	= KIRKWOOD_REGS_PHYS_BASE,
-	.io_pg_offst	= ((KIRKWOOD_REGS_VIRT_BASE) >> 18) & 0xfffc,
 	.boot_params	= 0x00000100,
 	.init_machine	= openrd_init,
 	.map_io		= kirkwood_map_io,
@@ -107,8 +105,6 @@ MACHINE_END
 #ifdef CONFIG_MACH_OPENRD_CLIENT
 MACHINE_START(OPENRD_CLIENT, "Marvell OpenRD Client Board")
 	/* Maintainer: Dhaval Vasa <dhaval.vasa@einfochips.com> */
-	.phys_io	= KIRKWOOD_REGS_PHYS_BASE,
-	.io_pg_offst	= ((KIRKWOOD_REGS_VIRT_BASE) >> 18) & 0xfffc,
 	.boot_params	= 0x00000100,
 	.init_machine	= openrd_init,
 	.map_io		= kirkwood_map_io,
diff --git a/arch/arm/mach-kirkwood/rd88f6192-nas-setup.c b/arch/arm/mach-kirkwood/rd88f6192-nas-setup.c
index 3bf6304..f9a1ce7 100644
--- a/arch/arm/mach-kirkwood/rd88f6192-nas-setup.c
+++ b/arch/arm/mach-kirkwood/rd88f6192-nas-setup.c
@@ -79,8 +79,6 @@ subsys_initcall(rd88f6192_pci_init);
 
 MACHINE_START(RD88F6192_NAS, "Marvell RD-88F6192-NAS Development Board")
 	/* Maintainer: Saeed Bishara <saeed@marvell.com> */
-	.phys_io	= KIRKWOOD_REGS_PHYS_BASE,
-	.io_pg_offst	= ((KIRKWOOD_REGS_VIRT_BASE) >> 18) & 0xfffc,
 	.boot_params	= 0x00000100,
 	.init_machine	= rd88f6192_init,
 	.map_io		= kirkwood_map_io,
diff --git a/arch/arm/mach-kirkwood/rd88f6281-setup.c b/arch/arm/mach-kirkwood/rd88f6281-setup.c
index 31708dd..9921d1a 100644
--- a/arch/arm/mach-kirkwood/rd88f6281-setup.c
+++ b/arch/arm/mach-kirkwood/rd88f6281-setup.c
@@ -115,8 +115,6 @@ subsys_initcall(rd88f6281_pci_init);
 
 MACHINE_START(RD88F6281, "Marvell RD-88F6281 Reference Board")
 	/* Maintainer: Saeed Bishara <saeed@marvell.com> */
-	.phys_io	= KIRKWOOD_REGS_PHYS_BASE,
-	.io_pg_offst	= ((KIRKWOOD_REGS_VIRT_BASE) >> 18) & 0xfffc,
 	.boot_params	= 0x00000100,
 	.init_machine	= rd88f6281_init,
 	.map_io		= kirkwood_map_io,
diff --git a/arch/arm/mach-kirkwood/sheevaplug-setup.c b/arch/arm/mach-kirkwood/sheevaplug-setup.c
index a00879d..d2eec35 100644
--- a/arch/arm/mach-kirkwood/sheevaplug-setup.c
+++ b/arch/arm/mach-kirkwood/sheevaplug-setup.c
@@ -131,8 +131,6 @@ static void __init sheevaplug_init(void)
 #ifdef CONFIG_MACH_SHEEVAPLUG
 MACHINE_START(SHEEVAPLUG, "Marvell SheevaPlug Reference Board")
 	/* Maintainer: shadi Ammouri <shadi@marvell.com> */
-	.phys_io	= KIRKWOOD_REGS_PHYS_BASE,
-	.io_pg_offst	= ((KIRKWOOD_REGS_VIRT_BASE) >> 18) & 0xfffc,
 	.boot_params	= 0x00000100,
 	.init_machine	= sheevaplug_init,
 	.map_io		= kirkwood_map_io,
@@ -143,8 +141,6 @@ MACHINE_END
 
 #ifdef CONFIG_MACH_ESATA_SHEEVAPLUG
 MACHINE_START(ESATA_SHEEVAPLUG, "Marvell eSATA SheevaPlug Reference Board")
-	.phys_io	= KIRKWOOD_REGS_PHYS_BASE,
-	.io_pg_offst	= ((KIRKWOOD_REGS_VIRT_BASE) >> 18) & 0xfffc,
 	.boot_params	= 0x00000100,
 	.init_machine	= sheevaplug_init,
 	.map_io		= kirkwood_map_io,
diff --git a/arch/arm/mach-kirkwood/ts219-setup.c b/arch/arm/mach-kirkwood/ts219-setup.c
index 2830f0f..197ab5f 100644
--- a/arch/arm/mach-kirkwood/ts219-setup.c
+++ b/arch/arm/mach-kirkwood/ts219-setup.c
@@ -119,8 +119,6 @@ subsys_initcall(ts219_pci_init);
 
 MACHINE_START(TS219, "QNAP TS-119/TS-219")
 	/* Maintainer: Martin Michlmayr <tbm@cyrius.com> */
-	.phys_io	= KIRKWOOD_REGS_PHYS_BASE,
-	.io_pg_offst	= ((KIRKWOOD_REGS_VIRT_BASE) >> 18) & 0xfffc,
 	.boot_params	= 0x00000100,
 	.init_machine	= qnap_ts219_init,
 	.map_io		= kirkwood_map_io,
diff --git a/arch/arm/mach-kirkwood/ts41x-setup.c b/arch/arm/mach-kirkwood/ts41x-setup.c
index de49c2d..942fe49 100644
--- a/arch/arm/mach-kirkwood/ts41x-setup.c
+++ b/arch/arm/mach-kirkwood/ts41x-setup.c
@@ -144,8 +144,6 @@ subsys_initcall(ts41x_pci_init);
 
 MACHINE_START(TS41X, "QNAP TS-41x")
 	/* Maintainer: Martin Michlmayr <tbm@cyrius.com> */
-	.phys_io	= KIRKWOOD_REGS_PHYS_BASE,
-	.io_pg_offst	= ((KIRKWOOD_REGS_VIRT_BASE) >> 18) & 0xfffc,
 	.boot_params	= 0x00000100,
 	.init_machine	= qnap_ts41x_init,
 	.map_io		= kirkwood_map_io,
diff --git a/arch/arm/mach-ks8695/board-acs5k.c b/arch/arm/mach-ks8695/board-acs5k.c
index 9e3e5a6..3ca4f8e 100644
--- a/arch/arm/mach-ks8695/board-acs5k.c
+++ b/arch/arm/mach-ks8695/board-acs5k.c
@@ -223,8 +223,6 @@ static void __init acs5k_init(void)
 
 MACHINE_START(ACS5K, "Brivo Systems LLC ACS-5000 Master board")
 	/* Maintainer: Simtec Electronics. */
-	.phys_io	= KS8695_IO_PA,
-	.io_pg_offst	= (KS8695_IO_VA >> 18) & 0xfffc,
 	.boot_params	= KS8695_SDRAM_PA + 0x100,
 	.map_io		= ks8695_map_io,
 	.init_irq	= ks8695_init_irq,
diff --git a/arch/arm/mach-ks8695/board-dsm320.c b/arch/arm/mach-ks8695/board-dsm320.c
index 521ff07..ada92b6 100644
--- a/arch/arm/mach-ks8695/board-dsm320.c
+++ b/arch/arm/mach-ks8695/board-dsm320.c
@@ -121,8 +121,6 @@ static void __init dsm320_init(void)
 
 MACHINE_START(DSM320, "D-Link DSM-320 Wireless Media Player")
 	/* Maintainer: Simtec Electronics. */
-	.phys_io	= KS8695_IO_PA,
-	.io_pg_offst	= (KS8695_IO_VA >> 18) & 0xfffc,
 	.boot_params	= KS8695_SDRAM_PA + 0x100,
 	.map_io		= ks8695_map_io,
 	.init_irq	= ks8695_init_irq,
diff --git a/arch/arm/mach-ks8695/board-micrel.c b/arch/arm/mach-ks8695/board-micrel.c
index 8ceaf5a..c7ad09b 100644
--- a/arch/arm/mach-ks8695/board-micrel.c
+++ b/arch/arm/mach-ks8695/board-micrel.c
@@ -53,8 +53,6 @@ static void __init micrel_init(void)
 
 MACHINE_START(KS8695, "KS8695 Centaur Development Board")
 	/* Maintainer: Micrel Semiconductor Inc. */
-	.phys_io	= KS8695_IO_PA,
-	.io_pg_offst	= (KS8695_IO_VA >> 18) & 0xfffc,
 	.boot_params	= KS8695_SDRAM_PA + 0x100,
 	.map_io		= ks8695_map_io,
 	.init_irq	= ks8695_init_irq,
diff --git a/arch/arm/mach-l7200/core.c b/arch/arm/mach-l7200/core.c
index 50d2324..a9a8ff5 100644
--- a/arch/arm/mach-l7200/core.c
+++ b/arch/arm/mach-l7200/core.c
@@ -92,8 +92,6 @@ static void __init l7200_map_io(void)
 
 MACHINE_START(L7200, "LinkUp Systems L7200")
 	/* Maintainer: Steve Hill / Scott McConnell */
-	.phys_io	= 0x80040000,
-	.io_pg_offst	= ((0xd0000000) >> 18) & 0xfffc,
 	.map_io		= l7200_map_io,
 	.init_irq	= l7200_init_irq,
 MACHINE_END
diff --git a/arch/arm/mach-lh7a40x/arch-kev7a400.c b/arch/arm/mach-lh7a40x/arch-kev7a400.c
index 3d7bd50..9088c16 100644
--- a/arch/arm/mach-lh7a40x/arch-kev7a400.c
+++ b/arch/arm/mach-lh7a40x/arch-kev7a400.c
@@ -111,8 +111,6 @@ void __init lh7a40x_init_board_irq (void)
 
 MACHINE_START (KEV7A400, "Sharp KEV7a400")
 	/* Maintainer: Marc Singer */
-	.phys_io	= 0x80000000,
-	.io_pg_offst	= ((io_p2v (0x80000000))>>18) & 0xfffc,
 	.boot_params	= 0xc0000100,
 	.map_io		= kev7a400_map_io,
 	.init_irq	= lh7a400_init_irq,
diff --git a/arch/arm/mach-lh7a40x/arch-lpd7a40x.c b/arch/arm/mach-lh7a40x/arch-lpd7a40x.c
index cb15e5d..7315a56 100644
--- a/arch/arm/mach-lh7a40x/arch-lpd7a40x.c
+++ b/arch/arm/mach-lh7a40x/arch-lpd7a40x.c
@@ -398,8 +398,6 @@ lpd7a40x_map_io(void)
 
 MACHINE_START (LPD7A400, "Logic Product Development LPD7A400-10")
 	/* Maintainer: Marc Singer */
-	.phys_io	= 0x80000000,
-	.io_pg_offst	= ((io_p2v (0x80000000))>>18) & 0xfffc,
 	.boot_params	= 0xc0000100,
 	.map_io		= lpd7a40x_map_io,
 	.init_irq	= lh7a400_init_irq,
@@ -413,8 +411,6 @@ MACHINE_END
 
 MACHINE_START (LPD7A404, "Logic Product Development LPD7A404-10")
 	/* Maintainer: Marc Singer */
-	.phys_io	= 0x80000000,
-	.io_pg_offst	= ((io_p2v (0x80000000))>>18) & 0xfffc,
 	.boot_params	= 0xc0000100,
 	.map_io		= lpd7a40x_map_io,
 	.init_irq	= lh7a404_init_irq,
diff --git a/arch/arm/mach-loki/lb88rc8480-setup.c b/arch/arm/mach-loki/lb88rc8480-setup.c
index 85f9c12..a1e75e7 100644
--- a/arch/arm/mach-loki/lb88rc8480-setup.c
+++ b/arch/arm/mach-loki/lb88rc8480-setup.c
@@ -90,8 +90,6 @@ static void __init lb88rc8480_init(void)
 
 MACHINE_START(LB88RC8480, "Marvell LB88RC8480 Development Board")
 	/* Maintainer: Ke Wei <kewei@marvell.com> */
-	.phys_io	= LOKI_REGS_PHYS_BASE,
-	.io_pg_offst	= ((LOKI_REGS_VIRT_BASE) >> 18) & 0xfffc,
 	.boot_params	= 0x00000100,
 	.init_machine	= lb88rc8480_init,
 	.map_io		= loki_map_io,
diff --git a/arch/arm/mach-mmp/aspenite.c b/arch/arm/mach-mmp/aspenite.c
index 244655d..804c2cc 100644
--- a/arch/arm/mach-mmp/aspenite.c
+++ b/arch/arm/mach-mmp/aspenite.c
@@ -149,9 +149,7 @@ static void __init common_init(void)
 }
 
 MACHINE_START(ASPENITE, "PXA168-based Aspenite Development Platform")
-	.phys_io        = APB_PHYS_BASE,
 	.boot_params    = 0x00000100,
-	.io_pg_offst    = (APB_VIRT_BASE >> 18) & 0xfffc,
 	.map_io		= pxa_map_io,
 	.init_irq       = pxa168_init_irq,
 	.timer          = &pxa168_timer,
@@ -159,9 +157,7 @@ MACHINE_START(ASPENITE, "PXA168-based Aspenite Development Platform")
 MACHINE_END
 
 MACHINE_START(ZYLONITE2, "PXA168-based Zylonite2 Development Platform")
-	.phys_io        = APB_PHYS_BASE,
 	.boot_params    = 0x00000100,
-	.io_pg_offst    = (APB_VIRT_BASE >> 18) & 0xfffc,
 	.map_io		= pxa_map_io,
 	.init_irq       = pxa168_init_irq,
 	.timer          = &pxa168_timer,
diff --git a/arch/arm/mach-mmp/avengers_lite.c b/arch/arm/mach-mmp/avengers_lite.c
index 8c3fa5d..3e29014 100644
--- a/arch/arm/mach-mmp/avengers_lite.c
+++ b/arch/arm/mach-mmp/avengers_lite.c
@@ -41,9 +41,7 @@ static void __init avengers_lite_init(void)
 }
 
 MACHINE_START(AVENGERS_LITE, "PXA168 Avengers lite Development Platform")
-	.phys_io        = APB_PHYS_BASE,
 	.boot_params    = 0x00000100,
-	.io_pg_offst    = (APB_VIRT_BASE >> 18) & 0xfffc,
 	.map_io		= pxa_map_io,
 	.init_irq       = pxa168_init_irq,
 	.timer          = &pxa168_timer,
diff --git a/arch/arm/mach-mmp/flint.c b/arch/arm/mach-mmp/flint.c
index 4ec7709..8c108f7 100644
--- a/arch/arm/mach-mmp/flint.c
+++ b/arch/arm/mach-mmp/flint.c
@@ -113,9 +113,7 @@ static void __init flint_init(void)
 }
 
 MACHINE_START(FLINT, "Flint Development Platform")
-	.phys_io        = APB_PHYS_BASE,
 	.boot_params    = 0x00000100,
-	.io_pg_offst    = (APB_VIRT_BASE >> 18) & 0xfffc,
 	.map_io		= pxa_map_io,
 	.init_irq       = mmp2_init_irq,
 	.timer          = &mmp2_timer,
diff --git a/arch/arm/mach-mmp/jasper.c b/arch/arm/mach-mmp/jasper.c
index d77dd41..5fad1ed 100644
--- a/arch/arm/mach-mmp/jasper.c
+++ b/arch/arm/mach-mmp/jasper.c
@@ -134,9 +134,7 @@ static void __init jasper_init(void)
 }
 
 MACHINE_START(MARVELL_JASPER, "Jasper Development Platform")
-	.phys_io        = APB_PHYS_BASE,
 	.boot_params    = 0x00000100,
-	.io_pg_offst    = (APB_VIRT_BASE >> 18) & 0xfffc,
 	.map_io		= pxa_map_io,
 	.init_irq       = mmp2_init_irq,
 	.timer          = &mmp2_timer,
diff --git a/arch/arm/mach-mmp/tavorevb.c b/arch/arm/mach-mmp/tavorevb.c
index 0e0c922..f436d30 100644
--- a/arch/arm/mach-mmp/tavorevb.c
+++ b/arch/arm/mach-mmp/tavorevb.c
@@ -99,9 +99,7 @@ static void __init tavorevb_init(void)
 }
 
 MACHINE_START(TAVOREVB, "PXA910 Evaluation Board (aka TavorEVB)")
-	.phys_io        = APB_PHYS_BASE,
 	.boot_params    = 0x00000100,
-	.io_pg_offst    = (APB_VIRT_BASE >> 18) & 0xfffc,
 	.map_io		= pxa_map_io,
 	.init_irq       = pxa910_init_irq,
 	.timer          = &pxa910_timer,
diff --git a/arch/arm/mach-mmp/ttc_dkb.c b/arch/arm/mach-mmp/ttc_dkb.c
index b22dec4..e65ef5f 100644
--- a/arch/arm/mach-mmp/ttc_dkb.c
+++ b/arch/arm/mach-mmp/ttc_dkb.c
@@ -122,9 +122,7 @@ static void __init ttc_dkb_init(void)
 }
 
 MACHINE_START(TTC_DKB, "PXA910-based TTC_DKB Development Platform")
-	.phys_io        = APB_PHYS_BASE,
 	.boot_params    = 0x00000100,
-	.io_pg_offst    = (APB_VIRT_BASE >> 18) & 0xfffc,
 	.map_io		= pxa_map_io,
 	.init_irq       = pxa910_init_irq,
 	.timer          = &pxa910_timer,
diff --git a/arch/arm/mach-msm/board-halibut.c b/arch/arm/mach-msm/board-halibut.c
index 7bd72e8..ef6f75b 100644
--- a/arch/arm/mach-msm/board-halibut.c
+++ b/arch/arm/mach-msm/board-halibut.c
@@ -94,10 +94,6 @@ static void __init halibut_map_io(void)
 }
 
 MACHINE_START(HALIBUT, "Halibut Board (QCT SURF7200A)")
-#ifdef CONFIG_MSM_DEBUG_UART
-	.phys_io        = MSM_DEBUG_UART_PHYS,
-	.io_pg_offst    = ((MSM_DEBUG_UART_BASE) >> 18) & 0xfffc,
-#endif
 	.boot_params	= 0x10000100,
 	.fixup		= halibut_fixup,
 	.map_io		= halibut_map_io,
diff --git a/arch/arm/mach-msm/board-mahimahi.c b/arch/arm/mach-msm/board-mahimahi.c
index bcbefdf..7a9a03e 100644
--- a/arch/arm/mach-msm/board-mahimahi.c
+++ b/arch/arm/mach-msm/board-mahimahi.c
@@ -74,10 +74,6 @@ static void __init mahimahi_map_io(void)
 extern struct sys_timer msm_timer;
 
 MACHINE_START(MAHIMAHI, "mahimahi")
-#ifdef CONFIG_MSM_DEBUG_UART
-	.phys_io        = MSM_DEBUG_UART_PHYS,
-	.io_pg_offst    = ((MSM_DEBUG_UART_BASE) >> 18) & 0xfffc,
-#endif
 	.boot_params	= 0x20000100,
 	.fixup		= mahimahi_fixup,
 	.map_io		= mahimahi_map_io,
diff --git a/arch/arm/mach-msm/board-msm7x27.c b/arch/arm/mach-msm/board-msm7x27.c
index db9381b..16d7580 100644
--- a/arch/arm/mach-msm/board-msm7x27.c
+++ b/arch/arm/mach-msm/board-msm7x27.c
@@ -130,10 +130,6 @@ static void __init msm7x2x_map_io(void)
 }
 
 MACHINE_START(MSM7X27_SURF, "QCT MSM7x27 SURF")
-#ifdef CONFIG_MSM_DEBUG_UART
-	.phys_io        = MSM_DEBUG_UART_PHYS,
-	.io_pg_offst    = ((MSM_DEBUG_UART_BASE) >> 18) & 0xfffc,
-#endif
 	.boot_params	= PHYS_OFFSET + 0x100,
 	.map_io		= msm7x2x_map_io,
 	.init_irq	= msm7x2x_init_irq,
@@ -142,10 +138,6 @@ MACHINE_START(MSM7X27_SURF, "QCT MSM7x27 SURF")
 MACHINE_END
 
 MACHINE_START(MSM7X27_FFA, "QCT MSM7x27 FFA")
-#ifdef CONFIG_MSM_DEBUG_UART
-	.phys_io        = MSM_DEBUG_UART_PHYS,
-	.io_pg_offst    = ((MSM_DEBUG_UART_BASE) >> 18) & 0xfffc,
-#endif
 	.boot_params	= PHYS_OFFSET + 0x100,
 	.map_io		= msm7x2x_map_io,
 	.init_irq	= msm7x2x_init_irq,
@@ -154,10 +146,6 @@ MACHINE_START(MSM7X27_FFA, "QCT MSM7x27 FFA")
 MACHINE_END
 
 MACHINE_START(MSM7X25_SURF, "QCT MSM7x25 SURF")
-#ifdef CONFIG_MSM_DEBUG_UART
-	.phys_io        = MSM_DEBUG_UART_PHYS,
-	.io_pg_offst    = ((MSM_DEBUG_UART_BASE) >> 18) & 0xfffc,
-#endif
 	.boot_params	= PHYS_OFFSET + 0x100,
 	.map_io		= msm7x2x_map_io,
 	.init_irq	= msm7x2x_init_irq,
@@ -166,10 +154,6 @@ MACHINE_START(MSM7X25_SURF, "QCT MSM7x25 SURF")
 MACHINE_END
 
 MACHINE_START(MSM7X25_FFA, "QCT MSM7x25 FFA")
-#ifdef CONFIG_MSM_DEBUG_UART
-	.phys_io        = MSM_DEBUG_UART_PHYS,
-	.io_pg_offst    = ((MSM_DEBUG_UART_BASE) >> 18) & 0xfffc,
-#endif
 	.boot_params	= PHYS_OFFSET + 0x100,
 	.map_io		= msm7x2x_map_io,
 	.init_irq	= msm7x2x_init_irq,
diff --git a/arch/arm/mach-msm/board-msm7x30.c b/arch/arm/mach-msm/board-msm7x30.c
index e329819..4929e26 100644
--- a/arch/arm/mach-msm/board-msm7x30.c
+++ b/arch/arm/mach-msm/board-msm7x30.c
@@ -83,10 +83,6 @@ static void __init msm7x30_map_io(void)
 }
 
 MACHINE_START(MSM7X30_SURF, "QCT MSM7X30 SURF")
-#ifdef CONFIG_MSM_DEBUG_UART
-	.phys_io  = MSM_DEBUG_UART_PHYS,
-	.io_pg_offst = ((MSM_DEBUG_UART_BASE) >> 18) & 0xfffc,
-#endif
 	.boot_params = PHYS_OFFSET + 0x100,
 	.map_io = msm7x30_map_io,
 	.init_irq = msm7x30_init_irq,
@@ -95,10 +91,6 @@ MACHINE_START(MSM7X30_SURF, "QCT MSM7X30 SURF")
 MACHINE_END
 
 MACHINE_START(MSM7X30_FFA, "QCT MSM7X30 FFA")
-#ifdef CONFIG_MSM_DEBUG_UART
-	.phys_io  = MSM_DEBUG_UART_PHYS,
-	.io_pg_offst = ((MSM_DEBUG_UART_BASE) >> 18) & 0xfffc,
-#endif
 	.boot_params = PHYS_OFFSET + 0x100,
 	.map_io = msm7x30_map_io,
 	.init_irq = msm7x30_init_irq,
@@ -107,10 +99,6 @@ MACHINE_START(MSM7X30_FFA, "QCT MSM7X30 FFA")
 MACHINE_END
 
 MACHINE_START(MSM7X30_FLUID, "QCT MSM7X30 FLUID")
-#ifdef CONFIG_MSM_DEBUG_UART
-	.phys_io  = MSM_DEBUG_UART_PHYS,
-	.io_pg_offst = ((MSM_DEBUG_UART_BASE) >> 18) & 0xfffc,
-#endif
 	.boot_params = PHYS_OFFSET + 0x100,
 	.map_io = msm7x30_map_io,
 	.init_irq = msm7x30_init_irq,
diff --git a/arch/arm/mach-msm/board-qsd8x50.c b/arch/arm/mach-msm/board-qsd8x50.c
index e3cc807..cf6aa8b 100644
--- a/arch/arm/mach-msm/board-qsd8x50.c
+++ b/arch/arm/mach-msm/board-qsd8x50.c
@@ -69,10 +69,6 @@ static void __init qsd8x50_init(void)
 }
 
 MACHINE_START(QSD8X50_SURF, "QCT QSD8X50 SURF")
-#ifdef CONFIG_MSM_DEBUG_UART
-	.phys_io  = MSM_DEBUG_UART_PHYS,
-	.io_pg_offst = ((MSM_DEBUG_UART_BASE) >> 18) & 0xfffc,
-#endif
 	.boot_params = PHYS_OFFSET + 0x100,
 	.map_io = qsd8x50_map_io,
 	.init_irq = qsd8x50_init_irq,
@@ -81,10 +77,6 @@ MACHINE_START(QSD8X50_SURF, "QCT QSD8X50 SURF")
 MACHINE_END
 
 MACHINE_START(QSD8X50A_ST1_5, "QCT QSD8X50A ST1.5")
-#ifdef CONFIG_MSM_DEBUG_UART
-	.phys_io  = MSM_DEBUG_UART_PHYS,
-	.io_pg_offst = ((MSM_DEBUG_UART_BASE) >> 18) & 0xfffc,
-#endif
 	.boot_params = PHYS_OFFSET + 0x100,
 	.map_io = qsd8x50_map_io,
 	.init_irq = qsd8x50_init_irq,
diff --git a/arch/arm/mach-msm/board-sapphire.c b/arch/arm/mach-msm/board-sapphire.c
index 2bc1b9d..6781ca8 100644
--- a/arch/arm/mach-msm/board-sapphire.c
+++ b/arch/arm/mach-msm/board-sapphire.c
@@ -105,10 +105,6 @@ static void __init sapphire_map_io(void)
 
 MACHINE_START(SAPPHIRE, "sapphire")
 /* Maintainer: Brian Swetland <swetland@google.com> */
-#ifdef CONFIG_MSM_DEBUG_UART
-	.phys_io        = MSM_DEBUG_UART_PHYS,
-	.io_pg_offst    = ((MSM_DEBUG_UART_BASE) >> 18) & 0xfffc,
-#endif
 	.boot_params    = PHYS_OFFSET + 0x100,
 	.fixup          = sapphire_fixup,
 	.map_io         = sapphire_map_io,
diff --git a/arch/arm/mach-msm/board-trout.c b/arch/arm/mach-msm/board-trout.c
index dca5a5f..0833b3d 100644
--- a/arch/arm/mach-msm/board-trout.c
+++ b/arch/arm/mach-msm/board-trout.c
@@ -82,10 +82,6 @@ static void __init trout_map_io(void)
 }
 
 MACHINE_START(TROUT, "HTC Dream")
-#ifdef CONFIG_MSM_DEBUG_UART
-	.phys_io	= MSM_DEBUG_UART_PHYS,
-	.io_pg_offst	= ((MSM_DEBUG_UART_BASE) >> 18) & 0xfffc,
-#endif
 	.boot_params	= 0x10000100,
 	.fixup		= trout_fixup,
 	.map_io		= trout_map_io,
diff --git a/arch/arm/mach-mv78xx0/buffalo-wxl-setup.c b/arch/arm/mach-mv78xx0/buffalo-wxl-setup.c
index 61e5e58..29e390e 100644
--- a/arch/arm/mach-mv78xx0/buffalo-wxl-setup.c
+++ b/arch/arm/mach-mv78xx0/buffalo-wxl-setup.c
@@ -145,8 +145,6 @@ subsys_initcall(wxl_pci_init);
 
 MACHINE_START(TERASTATION_WXL, "Buffalo Nas WXL")
 	/* Maintainer: Sebastien Requiem <sebastien@requiem.fr> */
-	.phys_io	= MV78XX0_REGS_PHYS_BASE,
-	.io_pg_offst	= ((MV78XX0_REGS_VIRT_BASE) >> 18) & 0xfffc,
 	.boot_params	= 0x00000100,
 	.init_machine	= wxl_init,
 	.map_io		= mv78xx0_map_io,
diff --git a/arch/arm/mach-mv78xx0/db78x00-bp-setup.c b/arch/arm/mach-mv78xx0/db78x00-bp-setup.c
index efdabe0..207c95e 100644
--- a/arch/arm/mach-mv78xx0/db78x00-bp-setup.c
+++ b/arch/arm/mach-mv78xx0/db78x00-bp-setup.c
@@ -93,8 +93,6 @@ subsys_initcall(db78x00_pci_init);
 
 MACHINE_START(DB78X00_BP, "Marvell DB-78x00-BP Development Board")
 	/* Maintainer: Lennert Buytenhek <buytenh@marvell.com> */
-	.phys_io	= MV78XX0_REGS_PHYS_BASE,
-	.io_pg_offst	= ((MV78XX0_REGS_VIRT_BASE) >> 18) & 0xfffc,
 	.boot_params	= 0x00000100,
 	.init_machine	= db78x00_init,
 	.map_io		= mv78xx0_map_io,
diff --git a/arch/arm/mach-mv78xx0/rd78x00-masa-setup.c b/arch/arm/mach-mv78xx0/rd78x00-masa-setup.c
index e136b7a..3511ad4 100644
--- a/arch/arm/mach-mv78xx0/rd78x00-masa-setup.c
+++ b/arch/arm/mach-mv78xx0/rd78x00-masa-setup.c
@@ -78,8 +78,6 @@ subsys_initcall(rd78x00_pci_init);
 
 MACHINE_START(RD78X00_MASA, "Marvell RD-78x00-MASA Development Board")
 	/* Maintainer: Lennert Buytenhek <buytenh@marvell.com> */
-	.phys_io	= MV78XX0_REGS_PHYS_BASE,
-	.io_pg_offst	= ((MV78XX0_REGS_VIRT_BASE) >> 18) & 0xfffc,
 	.boot_params	= 0x00000100,
 	.init_machine	= rd78x00_masa_init,
 	.map_io		= mv78xx0_map_io,
diff --git a/arch/arm/mach-mx1/mach-mx1ads.c b/arch/arm/mach-mx1/mach-mx1ads.c
index 51f3cfd..43a0517 100644
--- a/arch/arm/mach-mx1/mach-mx1ads.c
+++ b/arch/arm/mach-mx1/mach-mx1ads.c
@@ -145,8 +145,6 @@ struct sys_timer mx1ads_timer = {
 
 MACHINE_START(MX1ADS, "Freescale MX1ADS")
 	/* Maintainer: Sascha Hauer, Pengutronix */
-	.phys_io	= IMX_IO_PHYS,
-	.io_pg_offst	= (IMX_IO_BASE >> 18) & 0xfffc,
 	.boot_params	= MX1_PHYS_OFFSET + 0x100,
 	.map_io		= mx1_map_io,
 	.init_irq	= mx1_init_irq,
@@ -155,8 +153,6 @@ MACHINE_START(MX1ADS, "Freescale MX1ADS")
 MACHINE_END
 
 MACHINE_START(MXLADS, "Freescale MXLADS")
-	.phys_io	= IMX_IO_PHYS,
-	.io_pg_offst	= (IMX_IO_BASE >> 18) & 0xfffc,
 	.boot_params	= MX1_PHYS_OFFSET + 0x100,
 	.map_io		= mx1_map_io,
 	.init_irq	= mx1_init_irq,
diff --git a/arch/arm/mach-mx1/mach-scb9328.c b/arch/arm/mach-mx1/mach-scb9328.c
index 7587a7a..7432dcd 100644
--- a/arch/arm/mach-mx1/mach-scb9328.c
+++ b/arch/arm/mach-mx1/mach-scb9328.c
@@ -148,8 +148,6 @@ static struct sys_timer scb9328_timer = {
 
 MACHINE_START(SCB9328, "Synertronixx scb9328")
     /* Sascha Hauer */
-	.phys_io	= 0x00200000,
-	.io_pg_offst	= ((0xe0200000) >> 18) & 0xfffc,
 	.boot_params	= 0x08000100,
 	.map_io		= mx1_map_io,
 	.init_irq	= mx1_init_irq,
diff --git a/arch/arm/mach-mx2/mach-cpuimx27.c b/arch/arm/mach-mx2/mach-cpuimx27.c
index 1f616dc..2aa58b0 100644
--- a/arch/arm/mach-mx2/mach-cpuimx27.c
+++ b/arch/arm/mach-mx2/mach-cpuimx27.c
@@ -225,8 +225,6 @@ static struct sys_timer eukrea_cpuimx27_timer = {
 };
 
 MACHINE_START(CPUIMX27, "EUKREA CPUIMX27")
-	.phys_io        = MX27_AIPI_BASE_ADDR,
-	.io_pg_offst    = ((MX27_AIPI_BASE_ADDR_VIRT) >> 18) & 0xfffc,
 	.boot_params    = MX27_PHYS_OFFSET + 0x100,
 	.map_io         = mx27_map_io,
 	.init_irq       = mx27_init_irq,
diff --git a/arch/arm/mach-mx2/mach-imx27lite.c b/arch/arm/mach-mx2/mach-imx27lite.c
index b5710bf..eeca8d3 100644
--- a/arch/arm/mach-mx2/mach-imx27lite.c
+++ b/arch/arm/mach-mx2/mach-imx27lite.c
@@ -85,8 +85,6 @@ static struct sys_timer mx27lite_timer = {
 };
 
 MACHINE_START(IMX27LITE, "LogicPD i.MX27LITE")
-	.phys_io        = MX27_AIPI_BASE_ADDR,
-	.io_pg_offst    = ((MX27_AIPI_BASE_ADDR_VIRT) >> 18) & 0xfffc,
 	.boot_params    = MX27_PHYS_OFFSET + 0x100,
 	.map_io         = mx27_map_io,
 	.init_irq       = mx27_init_irq,
diff --git a/arch/arm/mach-mx2/mach-mx21ads.c b/arch/arm/mach-mx2/mach-mx21ads.c
index 113e58d..c6be895 100644
--- a/arch/arm/mach-mx2/mach-mx21ads.c
+++ b/arch/arm/mach-mx2/mach-mx21ads.c
@@ -284,8 +284,6 @@ static struct sys_timer mx21ads_timer = {
 
 MACHINE_START(MX21ADS, "Freescale i.MX21ADS")
 	/* maintainer: Freescale Semiconductor, Inc. */
-	.phys_io        = MX21_AIPI_BASE_ADDR,
-	.io_pg_offst    = ((MX21_AIPI_BASE_ADDR_VIRT) >> 18) & 0xfffc,
 	.boot_params    = MX21_PHYS_OFFSET + 0x100,
 	.map_io         = mx21ads_map_io,
 	.init_irq       = mx21_init_irq,
diff --git a/arch/arm/mach-mx2/mach-mx27_3ds.c b/arch/arm/mach-mx2/mach-mx27_3ds.c
index b2f4e0d..9f574be 100644
--- a/arch/arm/mach-mx2/mach-mx27_3ds.c
+++ b/arch/arm/mach-mx2/mach-mx27_3ds.c
@@ -85,8 +85,6 @@ static struct sys_timer mx27pdk_timer = {
 
 MACHINE_START(MX27_3DS, "Freescale MX27PDK")
 	/* maintainer: Freescale Semiconductor, Inc. */
-	.phys_io        = MX27_AIPI_BASE_ADDR,
-	.io_pg_offst    = ((MX27_AIPI_BASE_ADDR_VIRT) >> 18) & 0xfffc,
 	.boot_params    = MX27_PHYS_OFFSET + 0x100,
 	.map_io         = mx27_map_io,
 	.init_irq       = mx27_init_irq,
diff --git a/arch/arm/mach-mx2/mach-mx27ads.c b/arch/arm/mach-mx2/mach-mx27ads.c
index 6ce3236..5a25841 100644
--- a/arch/arm/mach-mx2/mach-mx27ads.c
+++ b/arch/arm/mach-mx2/mach-mx27ads.c
@@ -334,8 +334,6 @@ static void __init mx27ads_map_io(void)
 
 MACHINE_START(MX27ADS, "Freescale i.MX27ADS")
 	/* maintainer: Freescale Semiconductor, Inc. */
-	.phys_io        = MX27_AIPI_BASE_ADDR,
-	.io_pg_offst    = ((MX27_AIPI_BASE_ADDR_VIRT) >> 18) & 0xfffc,
 	.boot_params    = MX27_PHYS_OFFSET + 0x100,
 	.map_io         = mx27ads_map_io,
 	.init_irq       = mx27_init_irq,
diff --git a/arch/arm/mach-mx2/mach-mxt_td60.c b/arch/arm/mach-mx2/mach-mxt_td60.c
index bc38559..3733e79 100644
--- a/arch/arm/mach-mx2/mach-mxt_td60.c
+++ b/arch/arm/mach-mx2/mach-mxt_td60.c
@@ -284,8 +284,6 @@ static struct sys_timer mxt_td60_timer = {
 
 MACHINE_START(MXT_TD60, "Maxtrack i-MXT TD60")
 	/* maintainer: Maxtrack Industrial */
-	.phys_io	= MX27_AIPI_BASE_ADDR,
-	.io_pg_offst	= ((MX27_AIPI_BASE_ADDR_VIRT) >> 18) & 0xfffc,
 	.boot_params	= MX27_PHYS_OFFSET + 0x100,
 	.map_io		= mx27_map_io,
 	.init_irq	= mx27_init_irq,
diff --git a/arch/arm/mach-mx2/mach-pca100.c b/arch/arm/mach-mx2/mach-pca100.c
index a87422e..41a45e2 100644
--- a/arch/arm/mach-mx2/mach-pca100.c
+++ b/arch/arm/mach-mx2/mach-pca100.c
@@ -385,8 +385,6 @@ static struct sys_timer pca100_timer = {
 };
 
 MACHINE_START(PCA100, "phyCARD-i.MX27")
-	.phys_io        = MX27_AIPI_BASE_ADDR,
-	.io_pg_offst    = ((MX27_AIPI_BASE_ADDR_VIRT) >> 18) & 0xfffc,
 	.boot_params    = MX27_PHYS_OFFSET + 0x100,
 	.map_io         = mx27_map_io,
 	.init_irq       = mx27_init_irq,
diff --git a/arch/arm/mach-mx2/mach-pcm038.c b/arch/arm/mach-mx2/mach-pcm038.c
index 36c8943..b87f62c 100644
--- a/arch/arm/mach-mx2/mach-pcm038.c
+++ b/arch/arm/mach-mx2/mach-pcm038.c
@@ -349,8 +349,6 @@ static struct sys_timer pcm038_timer = {
 };
 
 MACHINE_START(PCM038, "phyCORE-i.MX27")
-	.phys_io        = MX27_AIPI_BASE_ADDR,
-	.io_pg_offst    = ((MX27_AIPI_BASE_ADDR_VIRT) >> 18) & 0xfffc,
 	.boot_params    = MX27_PHYS_OFFSET + 0x100,
 	.map_io         = mx27_map_io,
 	.init_irq       = mx27_init_irq,
diff --git a/arch/arm/mach-mx25/mach-mx25pdk.c b/arch/arm/mach-mx25/mach-mx25pdk.c
index 83d7410..a2c152d 100644
--- a/arch/arm/mach-mx25/mach-mx25pdk.c
+++ b/arch/arm/mach-mx25/mach-mx25pdk.c
@@ -163,8 +163,6 @@ static struct sys_timer mx25pdk_timer = {
 
 MACHINE_START(MX25_3DS, "Freescale MX25PDK (3DS)")
 	/* Maintainer: Freescale Semiconductor, Inc. */
-	.phys_io	= MX25_AIPS1_BASE_ADDR,
-	.io_pg_offst	= ((MX25_AIPS1_BASE_ADDR_VIRT) >> 18) & 0xfffc,
 	.boot_params    = MX25_PHYS_OFFSET + 0x100,
 	.map_io         = mx25_map_io,
 	.init_irq       = mx25_init_irq,
diff --git a/arch/arm/mach-mx3/mach-armadillo5x0.c b/arch/arm/mach-mx3/mach-armadillo5x0.c
index 5f72ec9..443fa69 100644
--- a/arch/arm/mach-mx3/mach-armadillo5x0.c
+++ b/arch/arm/mach-mx3/mach-armadillo5x0.c
@@ -572,8 +572,6 @@ static struct sys_timer armadillo5x0_timer = {
 
 MACHINE_START(ARMADILLO5X0, "Armadillo-500")
 	/* Maintainer: Alberto Panizzo  */
-	.phys_io	= MX31_AIPS1_BASE_ADDR,
-	.io_pg_offst	= (MX31_AIPS1_BASE_ADDR_VIRT >> 18) & 0xfffc,
 	.boot_params	= MX3x_PHYS_OFFSET + 0x100,
 	.map_io		= mx31_map_io,
 	.init_irq	= mx31_init_irq,
diff --git a/arch/arm/mach-mx3/mach-kzm_arm11_01.c b/arch/arm/mach-mx3/mach-kzm_arm11_01.c
index f085d5d..be8804b 100644
--- a/arch/arm/mach-mx3/mach-kzm_arm11_01.c
+++ b/arch/arm/mach-mx3/mach-kzm_arm11_01.c
@@ -263,8 +263,6 @@ static struct sys_timer kzm_timer = {
  * initialize __mach_desc_KZM_ARM11_01 data structure.
  */
 MACHINE_START(KZM_ARM11_01, "Kyoto Microcomputer Co., Ltd. KZM-ARM11-01")
-	.phys_io        = MX31_AIPS1_BASE_ADDR,
-	.io_pg_offst    = (MX31_AIPS1_BASE_ADDR_VIRT >> 18) & 0xfffc,
 	.boot_params    = MX3x_PHYS_OFFSET + 0x100,
 	.map_io         = kzm_map_io,
 	.init_irq       = mx31_init_irq,
diff --git a/arch/arm/mach-mx3/mach-mx31_3ds.c b/arch/arm/mach-mx3/mach-mx31_3ds.c
index 58e5729..02a3ed4 100644
--- a/arch/arm/mach-mx3/mach-mx31_3ds.c
+++ b/arch/arm/mach-mx3/mach-mx31_3ds.c
@@ -421,8 +421,6 @@ static struct sys_timer mx31_3ds_timer = {
  */
 MACHINE_START(MX31_3DS, "Freescale MX31PDK (3DS)")
 	/* Maintainer: Freescale Semiconductor, Inc. */
-	.phys_io	= MX31_AIPS1_BASE_ADDR,
-	.io_pg_offst	= (MX31_AIPS1_BASE_ADDR_VIRT >> 18) & 0xfffc,
 	.boot_params    = MX3x_PHYS_OFFSET + 0x100,
 	.map_io         = mx31_3ds_map_io,
 	.init_irq       = mx31_init_irq,
diff --git a/arch/arm/mach-mx3/mach-mx31ads.c b/arch/arm/mach-mx3/mach-mx31ads.c
index b3d1a18..b6910c2 100644
--- a/arch/arm/mach-mx3/mach-mx31ads.c
+++ b/arch/arm/mach-mx3/mach-mx31ads.c
@@ -549,8 +549,6 @@ static struct sys_timer mx31ads_timer = {
  */
 MACHINE_START(MX31ADS, "Freescale MX31ADS")
 	/* Maintainer: Freescale Semiconductor, Inc. */
-	.phys_io	= MX31_AIPS1_BASE_ADDR,
-	.io_pg_offst	= (MX31_AIPS1_BASE_ADDR_VIRT >> 18) & 0xfffc,
 	.boot_params    = MX3x_PHYS_OFFSET + 0x100,
 	.map_io         = mx31ads_map_io,
 	.init_irq       = mx31ads_init_irq,
diff --git a/arch/arm/mach-mx3/mach-mx31lilly.c b/arch/arm/mach-mx3/mach-mx31lilly.c
index b2c7f51..379c11e 100644
--- a/arch/arm/mach-mx3/mach-mx31lilly.c
+++ b/arch/arm/mach-mx3/mach-mx31lilly.c
@@ -351,8 +351,6 @@ static struct sys_timer mx31lilly_timer = {
 };
 
 MACHINE_START(LILLY1131, "INCO startec LILLY-1131")
-	.phys_io	= MX31_AIPS1_BASE_ADDR,
-	.io_pg_offst	= (MX31_AIPS1_BASE_ADDR_VIRT >> 18) & 0xfffc,
 	.boot_params	= MX3x_PHYS_OFFSET + 0x100,
 	.map_io		= mx31_map_io,
 	.init_irq	= mx31_init_irq,
diff --git a/arch/arm/mach-mx3/mach-mx31lite.c b/arch/arm/mach-mx3/mach-mx31lite.c
index 2b6d114..7e63658 100644
--- a/arch/arm/mach-mx3/mach-mx31lite.c
+++ b/arch/arm/mach-mx3/mach-mx31lite.c
@@ -287,8 +287,6 @@ struct sys_timer mx31lite_timer = {
 
 MACHINE_START(MX31LITE, "LogicPD i.MX31 SOM")
 	/* Maintainer: Freescale Semiconductor, Inc. */
-	.phys_io        = MX31_AIPS1_BASE_ADDR,
-	.io_pg_offst    = (MX31_AIPS1_BASE_ADDR_VIRT >> 18) & 0xfffc,
 	.boot_params    = MX3x_PHYS_OFFSET + 0x100,
 	.map_io         = mx31lite_map_io,
 	.init_irq       = mx31_init_irq,
diff --git a/arch/arm/mach-mx3/mach-mx31moboard.c b/arch/arm/mach-mx3/mach-mx31moboard.c
index 62b5e40..0b949b9 100644
--- a/arch/arm/mach-mx3/mach-mx31moboard.c
+++ b/arch/arm/mach-mx3/mach-mx31moboard.c
@@ -554,8 +554,6 @@ struct sys_timer mx31moboard_timer = {
 
 MACHINE_START(MX31MOBOARD, "EPFL Mobots mx31moboard")
 	/* Maintainer: Valentin Longchamp, EPFL Mobots group */
-	.phys_io	= MX31_AIPS1_BASE_ADDR,
-	.io_pg_offst	= (MX31_AIPS1_BASE_ADDR_VIRT >> 18) & 0xfffc,
 	.boot_params    = MX3x_PHYS_OFFSET + 0x100,
 	.map_io         = mx31_map_io,
 	.init_irq       = mx31_init_irq,
diff --git a/arch/arm/mach-mx3/mach-mx35pdk.c b/arch/arm/mach-mx3/mach-mx35pdk.c
index bcac84d..80490d0 100644
--- a/arch/arm/mach-mx3/mach-mx35pdk.c
+++ b/arch/arm/mach-mx3/mach-mx35pdk.c
@@ -106,8 +106,6 @@ struct sys_timer mx35pdk_timer = {
 
 MACHINE_START(MX35_3DS, "Freescale MX35PDK")
 	/* Maintainer: Freescale Semiconductor, Inc */
-	.phys_io	= MX35_AIPS1_BASE_ADDR,
-	.io_pg_offst	= ((MX35_AIPS1_BASE_ADDR_VIRT) >> 18) & 0xfffc,
 	.boot_params    = MX3x_PHYS_OFFSET + 0x100,
 	.map_io         = mx35_map_io,
 	.init_irq       = mx35_init_irq,
diff --git a/arch/arm/mach-mx3/mach-pcm037.c b/arch/arm/mach-mx3/mach-pcm037.c
index cce4106..c9164b3 100644
--- a/arch/arm/mach-mx3/mach-pcm037.c
+++ b/arch/arm/mach-mx3/mach-pcm037.c
@@ -684,8 +684,6 @@ struct sys_timer pcm037_timer = {
 
 MACHINE_START(PCM037, "Phytec Phycore pcm037")
 	/* Maintainer: Pengutronix */
-	.phys_io	= MX31_AIPS1_BASE_ADDR,
-	.io_pg_offst	= (MX31_AIPS1_BASE_ADDR_VIRT >> 18) & 0xfffc,
 	.boot_params    = MX3x_PHYS_OFFSET + 0x100,
 	.map_io         = mx31_map_io,
 	.init_irq       = mx31_init_irq,
diff --git a/arch/arm/mach-mx3/mach-pcm043.c b/arch/arm/mach-mx3/mach-pcm043.c
index 78d9185..ba36ac5 100644
--- a/arch/arm/mach-mx3/mach-pcm043.c
+++ b/arch/arm/mach-mx3/mach-pcm043.c
@@ -403,8 +403,6 @@ struct sys_timer pcm043_timer = {
 
 MACHINE_START(PCM043, "Phytec Phycore pcm043")
 	/* Maintainer: Pengutronix */
-	.phys_io	= MX35_AIPS1_BASE_ADDR,
-	.io_pg_offst	= ((MX35_AIPS1_BASE_ADDR_VIRT) >> 18) & 0xfffc,
 	.boot_params    = MX3x_PHYS_OFFSET + 0x100,
 	.map_io         = mx35_map_io,
 	.init_irq       = mx35_init_irq,
diff --git a/arch/arm/mach-mx3/mach-qong.c b/arch/arm/mach-mx3/mach-qong.c
index e5b5b83..3d7f131 100644
--- a/arch/arm/mach-mx3/mach-qong.c
+++ b/arch/arm/mach-mx3/mach-qong.c
@@ -273,8 +273,6 @@ static struct sys_timer qong_timer = {
 
 MACHINE_START(QONG, "Dave/DENX QongEVB-LITE")
 	/* Maintainer: DENX Software Engineering GmbH */
-	.phys_io        = MX31_AIPS1_BASE_ADDR,
-	.io_pg_offst    = (MX31_AIPS1_BASE_ADDR_VIRT >> 18) & 0xfffc,
 	.boot_params    = MX3x_PHYS_OFFSET + 0x100,
 	.map_io         = mx31_map_io,
 	.init_irq       = mx31_init_irq,
diff --git a/arch/arm/mach-mx5/board-mx51_babbage.c b/arch/arm/mach-mx5/board-mx51_babbage.c
index ed885f9..5781bcf 100644
--- a/arch/arm/mach-mx5/board-mx51_babbage.c
+++ b/arch/arm/mach-mx5/board-mx51_babbage.c
@@ -255,8 +255,6 @@ static struct sys_timer mxc_timer = {
 
 MACHINE_START(MX51_BABBAGE, "Freescale MX51 Babbage Board")
 	/* Maintainer: Amit Kucheria <amit.kucheria@canonical.com> */
-	.phys_io = MX51_AIPS1_BASE_ADDR,
-	.io_pg_offst = ((MX51_AIPS1_BASE_ADDR_VIRT) >> 18) & 0xfffc,
 	.boot_params = PHYS_OFFSET + 0x100,
 	.map_io = mx51_map_io,
 	.init_irq = mx51_init_irq,
diff --git a/arch/arm/mach-mxc91231/magx-zn5.c b/arch/arm/mach-mxc91231/magx-zn5.c
index 69816ba..395d83b 100644
--- a/arch/arm/mach-mxc91231/magx-zn5.c
+++ b/arch/arm/mach-mxc91231/magx-zn5.c
@@ -53,8 +53,6 @@ struct sys_timer zn5_timer = {
 };
 
 MACHINE_START(MAGX_ZN5, "Motorola Zn5")
-	.phys_io	= MXC91231_AIPS1_BASE_ADDR,
-	.io_pg_offst	= ((MXC91231_AIPS1_BASE_ADDR_VIRT) >> 18) & 0xfffc,
 	.boot_params	= MXC91231_PHYS_OFFSET + 0x100,
 	.map_io		= mxc91231_map_io,
 	.init_irq	= mxc91231_init_irq,
diff --git a/arch/arm/mach-netx/nxdb500.c b/arch/arm/mach-netx/nxdb500.c
index c9b174b..ca8b203 100644
--- a/arch/arm/mach-netx/nxdb500.c
+++ b/arch/arm/mach-netx/nxdb500.c
@@ -200,8 +200,6 @@ static void __init nxdb500_init(void)
 }
 
 MACHINE_START(NXDB500, "Hilscher nxdb500")
-	.phys_io	= 0x00100000,
-	.io_pg_offst	= (io_p2v(0x00100000) >> 18) & 0xfffc,
 	.boot_params	= 0x80000100,
 	.map_io		= netx_map_io,
 	.init_irq	= netx_init_irq,
diff --git a/arch/arm/mach-netx/nxdkn.c b/arch/arm/mach-netx/nxdkn.c
index 15b54c6..d775cbe 100644
--- a/arch/arm/mach-netx/nxdkn.c
+++ b/arch/arm/mach-netx/nxdkn.c
@@ -93,8 +93,6 @@ static void __init nxdkn_init(void)
 }
 
 MACHINE_START(NXDKN, "Hilscher nxdkn")
-	.phys_io	= 0x00100000,
-	.io_pg_offst	= (io_p2v(0x00100000) >> 18) & 0xfffc,
 	.boot_params	= 0x80000100,
 	.map_io		= netx_map_io,
 	.init_irq	= netx_init_irq,
diff --git a/arch/arm/mach-netx/nxeb500hmi.c b/arch/arm/mach-netx/nxeb500hmi.c
index 1061c01..de369cd 100644
--- a/arch/arm/mach-netx/nxeb500hmi.c
+++ b/arch/arm/mach-netx/nxeb500hmi.c
@@ -177,8 +177,6 @@ static void __init nxeb500hmi_init(void)
 }
 
 MACHINE_START(NXEB500HMI, "Hilscher nxeb500hmi")
-	.phys_io	= 0x00100000,
-	.io_pg_offst	= (io_p2v(0x00100000) >> 18) & 0xfffc,
 	.boot_params	= 0x80000100,
 	.map_io		= netx_map_io,
 	.init_irq	= netx_init_irq,
diff --git a/arch/arm/mach-nomadik/board-nhk8815.c b/arch/arm/mach-nomadik/board-nhk8815.c
index 841d459..1399303 100644
--- a/arch/arm/mach-nomadik/board-nhk8815.c
+++ b/arch/arm/mach-nomadik/board-nhk8815.c
@@ -276,8 +276,6 @@ static void __init nhk8815_platform_init(void)
 
 MACHINE_START(NOMADIK, "NHK8815")
 	/* Maintainer: ST MicroElectronics */
-	.phys_io	= NOMADIK_UART0_BASE,
-	.io_pg_offst	= (IO_ADDRESS(NOMADIK_UART0_BASE) >> 18) & 0xfffc,
 	.boot_params	= 0x100,
 	.map_io		= cpu8815_map_io,
 	.init_irq	= cpu8815_init_irq,
diff --git a/arch/arm/mach-nuc93x/mach-nuc932evb.c b/arch/arm/mach-nuc93x/mach-nuc932evb.c
index 9f79266..d702570 100644
--- a/arch/arm/mach-nuc93x/mach-nuc932evb.c
+++ b/arch/arm/mach-nuc93x/mach-nuc932evb.c
@@ -35,8 +35,6 @@ static void __init nuc932evb_init(void)
 
 MACHINE_START(NUC932EVB, "NUC932EVB")
 	/* Maintainer: Wan ZongShun */
-	.phys_io	= NUC93X_PA_UART,
-	.io_pg_offst	= (((u32)NUC93X_VA_UART) >> 18) & 0xfffc,
 	.boot_params	= 0,
 	.map_io		= nuc932evb_map_io,
 	.init_irq	= nuc93x_init_irq,
diff --git a/arch/arm/mach-omap1/board-ams-delta.c b/arch/arm/mach-omap1/board-ams-delta.c
index fdd1dd5..93a91f8 100644
--- a/arch/arm/mach-omap1/board-ams-delta.c
+++ b/arch/arm/mach-omap1/board-ams-delta.c
@@ -297,8 +297,6 @@ static void __init ams_delta_map_io(void)
 
 MACHINE_START(AMS_DELTA, "Amstrad E3 (Delta)")
 	/* Maintainer: Jonathan McDowell <noodles@earth.li> */
-	.phys_io	= 0xfff00000,
-	.io_pg_offst	= ((0xfef00000) >> 18) & 0xfffc,
 	.boot_params	= 0x10000100,
 	.map_io		= ams_delta_map_io,
 	.init_irq	= ams_delta_init_irq,
diff --git a/arch/arm/mach-omap1/board-fsample.c b/arch/arm/mach-omap1/board-fsample.c
index 096f2ed..e952f2a 100644
--- a/arch/arm/mach-omap1/board-fsample.c
+++ b/arch/arm/mach-omap1/board-fsample.c
@@ -374,8 +374,6 @@ static void __init omap_fsample_map_io(void)
 
 MACHINE_START(OMAP_FSAMPLE, "OMAP730 F-Sample")
 /* Maintainer: Brian Swetland <swetland@google.com> */
-	.phys_io	= 0xfff00000,
-	.io_pg_offst	= ((0xfef00000) >> 18) & 0xfffc,
 	.boot_params	= 0x10000100,
 	.map_io		= omap_fsample_map_io,
 	.init_irq	= omap_fsample_init_irq,
diff --git a/arch/arm/mach-omap1/board-generic.c b/arch/arm/mach-omap1/board-generic.c
index e1195a3..0b2ae00 100644
--- a/arch/arm/mach-omap1/board-generic.c
+++ b/arch/arm/mach-omap1/board-generic.c
@@ -94,8 +94,6 @@ static void __init omap_generic_map_io(void)
 
 MACHINE_START(OMAP_GENERIC, "Generic OMAP1510/1610/1710")
 	/* Maintainer: Tony Lindgren <tony@atomide.com> */
-	.phys_io	= 0xfff00000,
-	.io_pg_offst	= ((0xfef00000) >> 18) & 0xfffc,
 	.boot_params	= 0x10000100,
 	.map_io		= omap_generic_map_io,
 	.init_irq	= omap_generic_init_irq,
diff --git a/arch/arm/mach-omap1/board-h2.c b/arch/arm/mach-omap1/board-h2.c
index d1100e4..0d1193c 100644
--- a/arch/arm/mach-omap1/board-h2.c
+++ b/arch/arm/mach-omap1/board-h2.c
@@ -463,8 +463,6 @@ static void __init h2_map_io(void)
 
 MACHINE_START(OMAP_H2, "TI-H2")
 	/* Maintainer: Imre Deak <imre.deak@nokia.com> */
-	.phys_io	= 0xfff00000,
-	.io_pg_offst	= ((0xfef00000) >> 18) & 0xfffc,
 	.boot_params	= 0x10000100,
 	.map_io		= h2_map_io,
 	.init_irq	= h2_init_irq,
diff --git a/arch/arm/mach-omap1/board-h3.c b/arch/arm/mach-omap1/board-h3.c
index a53ab82..fcecd8c 100644
--- a/arch/arm/mach-omap1/board-h3.c
+++ b/arch/arm/mach-omap1/board-h3.c
@@ -433,8 +433,6 @@ static void __init h3_map_io(void)
 
 MACHINE_START(OMAP_H3, "TI OMAP1710 H3 board")
 	/* Maintainer: Texas Instruments, Inc. */
-	.phys_io	= 0xfff00000,
-	.io_pg_offst	= ((0xfef00000) >> 18) & 0xfffc,
 	.boot_params	= 0x10000100,
 	.map_io		= h3_map_io,
 	.init_irq	= h3_init_irq,
diff --git a/arch/arm/mach-omap1/board-htcherald.c b/arch/arm/mach-omap1/board-htcherald.c
index 8e313b4..170168e 100644
--- a/arch/arm/mach-omap1/board-htcherald.c
+++ b/arch/arm/mach-omap1/board-htcherald.c
@@ -300,8 +300,6 @@ static void __init htcherald_init_irq(void)
 MACHINE_START(HERALD, "HTC Herald")
 	/* Maintainer: Cory Maccarrone <darkstar6262@gmail.com> */
 	/* Maintainer: wing-linux.sourceforge.net */
-	.phys_io        = 0xfff00000,
-	.io_pg_offst    = ((0xfef00000) >> 18) & 0xfffc,
 	.boot_params    = 0x10000100,
 	.map_io         = htcherald_map_io,
 	.init_irq       = htcherald_init_irq,
diff --git a/arch/arm/mach-omap1/board-innovator.c b/arch/arm/mach-omap1/board-innovator.c
index 5d12fd3..3db2ec4 100644
--- a/arch/arm/mach-omap1/board-innovator.c
+++ b/arch/arm/mach-omap1/board-innovator.c
@@ -459,8 +459,6 @@ static void __init innovator_map_io(void)
 
 MACHINE_START(OMAP_INNOVATOR, "TI-Innovator")
 	/* Maintainer: MontaVista Software, Inc. */
-	.phys_io	= 0xfff00000,
-	.io_pg_offst	= ((0xfef00000) >> 18) & 0xfffc,
 	.boot_params	= 0x10000100,
 	.map_io		= innovator_map_io,
 	.init_irq	= innovator_init_irq,
diff --git a/arch/arm/mach-omap1/board-nokia770.c b/arch/arm/mach-omap1/board-nokia770.c
index 71e1a3f..ba32406 100644
--- a/arch/arm/mach-omap1/board-nokia770.c
+++ b/arch/arm/mach-omap1/board-nokia770.c
@@ -396,8 +396,6 @@ static void __init omap_nokia770_map_io(void)
 }
 
 MACHINE_START(NOKIA770, "Nokia 770")
-	.phys_io	= 0xfff00000,
-	.io_pg_offst	= ((0xfef00000) >> 18) & 0xfffc,
 	.boot_params	= 0x10000100,
 	.map_io		= omap_nokia770_map_io,
 	.init_irq	= omap_nokia770_init_irq,
diff --git a/arch/arm/mach-omap1/board-osk.c b/arch/arm/mach-omap1/board-osk.c
index 80d8620..62c85c4 100644
--- a/arch/arm/mach-omap1/board-osk.c
+++ b/arch/arm/mach-omap1/board-osk.c
@@ -580,8 +580,6 @@ static void __init osk_map_io(void)
 
 MACHINE_START(OMAP_OSK, "TI-OSK")
 	/* Maintainer: Dirk Behme <dirk.behme@de.bosch.com> */
-	.phys_io	= 0xfff00000,
-	.io_pg_offst	= ((0xfef00000) >> 18) & 0xfffc,
 	.boot_params	= 0x10000100,
 	.map_io		= osk_map_io,
 	.init_irq	= osk_init_irq,
diff --git a/arch/arm/mach-omap1/board-palmte.c b/arch/arm/mach-omap1/board-palmte.c
index 569b4c9..3e8ce2f 100644
--- a/arch/arm/mach-omap1/board-palmte.c
+++ b/arch/arm/mach-omap1/board-palmte.c
@@ -369,8 +369,6 @@ static void __init omap_palmte_map_io(void)
 }
 
 MACHINE_START(OMAP_PALMTE, "OMAP310 based Palm Tungsten E")
-	.phys_io	= 0xfff00000,
-	.io_pg_offst	= ((0xfef00000) >> 18) & 0xfffc,
 	.boot_params	= 0x10000100,
 	.map_io		= omap_palmte_map_io,
 	.init_irq	= omap_palmte_init_irq,
diff --git a/arch/arm/mach-omap1/board-palmtt.c b/arch/arm/mach-omap1/board-palmtt.c
index 6ad49a2..d3f123b 100644
--- a/arch/arm/mach-omap1/board-palmtt.c
+++ b/arch/arm/mach-omap1/board-palmtt.c
@@ -317,8 +317,6 @@ static void __init omap_palmtt_map_io(void)
 }
 
 MACHINE_START(OMAP_PALMTT, "OMAP1510 based Palm Tungsten|T")
-	.phys_io	= 0xfff00000,
-	.io_pg_offst	= ((0xfef00000) >> 18) & 0xfffc,
 	.boot_params	= 0x10000100,
 	.map_io		= omap_palmtt_map_io,
 	.init_irq	= omap_palmtt_init_irq,
diff --git a/arch/arm/mach-omap1/board-palmz71.c b/arch/arm/mach-omap1/board-palmz71.c
index 6641de9..7386be7 100644
--- a/arch/arm/mach-omap1/board-palmz71.c
+++ b/arch/arm/mach-omap1/board-palmz71.c
@@ -338,8 +338,6 @@ omap_palmz71_map_io(void)
 }
 
 MACHINE_START(OMAP_PALMZ71, "OMAP310 based Palm Zire71")
-	.phys_io = 0xfff00000,
-	.io_pg_offst = ((0xfef00000) >> 18) & 0xfffc,
 	.boot_params = 0x10000100,.map_io = omap_palmz71_map_io,
 	.init_irq = omap_palmz71_init_irq,
 	.init_machine = omap_palmz71_init,
diff --git a/arch/arm/mach-omap1/board-perseus2.c b/arch/arm/mach-omap1/board-perseus2.c
index e854d57..f8fe085 100644
--- a/arch/arm/mach-omap1/board-perseus2.c
+++ b/arch/arm/mach-omap1/board-perseus2.c
@@ -335,8 +335,6 @@ static void __init omap_perseus2_map_io(void)
 
 MACHINE_START(OMAP_PERSEUS2, "OMAP730 Perseus2")
 	/* Maintainer: Kevin Hilman <kjh@hilman.org> */
-	.phys_io	= 0xfff00000,
-	.io_pg_offst	= ((0xfef00000) >> 18) & 0xfffc,
 	.boot_params	= 0x10000100,
 	.map_io		= omap_perseus2_map_io,
 	.init_irq	= omap_perseus2_init_irq,
diff --git a/arch/arm/mach-omap1/board-sx1.c b/arch/arm/mach-omap1/board-sx1.c
index 2fb1e5f..4c0ac43 100644
--- a/arch/arm/mach-omap1/board-sx1.c
+++ b/arch/arm/mach-omap1/board-sx1.c
@@ -419,8 +419,6 @@ static void __init omap_sx1_map_io(void)
 }
 
 MACHINE_START(SX1, "OMAP310 based Siemens SX1")
-	.phys_io	= 0xfff00000,
-	.io_pg_offst	= ((0xfef00000) >> 18) & 0xfffc,
 	.boot_params	= 0x10000100,
 	.map_io		= omap_sx1_map_io,
 	.init_irq		= omap_sx1_init_irq,
diff --git a/arch/arm/mach-omap1/board-voiceblue.c b/arch/arm/mach-omap1/board-voiceblue.c
index 87b9436..0a1f805 100644
--- a/arch/arm/mach-omap1/board-voiceblue.c
+++ b/arch/arm/mach-omap1/board-voiceblue.c
@@ -283,8 +283,6 @@ EXPORT_SYMBOL(voiceblue_wdt_ping);
 
 MACHINE_START(VOICEBLUE, "VoiceBlue OMAP5910")
 	/* Maintainer: Ladislav Michl <michl@2n.cz> */
-	.phys_io	= 0xfff00000,
-	.io_pg_offst	= ((0xfef00000) >> 18) & 0xfffc,
 	.boot_params	= 0x10000100,
 	.map_io		= voiceblue_map_io,
 	.init_irq	= voiceblue_init_irq,
diff --git a/arch/arm/mach-omap2/board-2430sdp.c b/arch/arm/mach-omap2/board-2430sdp.c
index a11a575..cf77daa 100644
--- a/arch/arm/mach-omap2/board-2430sdp.c
+++ b/arch/arm/mach-omap2/board-2430sdp.c
@@ -244,8 +244,6 @@ static void __init omap_2430sdp_map_io(void)
 
 MACHINE_START(OMAP_2430SDP, "OMAP2430 sdp2430 board")
 	/* Maintainer: Syed Khasim - Texas Instruments Inc */
-	.phys_io	= 0x48000000,
-	.io_pg_offst	= ((0xfa000000) >> 18) & 0xfffc,
 	.boot_params	= 0x80000100,
 	.map_io		= omap_2430sdp_map_io,
 	.init_irq	= omap_2430sdp_init_irq,
diff --git a/arch/arm/mach-omap2/board-3430sdp.c b/arch/arm/mach-omap2/board-3430sdp.c
index f474a80..5bb5f1c 100644
--- a/arch/arm/mach-omap2/board-3430sdp.c
+++ b/arch/arm/mach-omap2/board-3430sdp.c
@@ -811,8 +811,6 @@ static void __init omap_3430sdp_map_io(void)
 
 MACHINE_START(OMAP_3430SDP, "OMAP3430 3430SDP board")
 	/* Maintainer: Syed Khasim - Texas Instruments Inc */
-	.phys_io	= 0x48000000,
-	.io_pg_offst	= ((0xfa000000) >> 18) & 0xfffc,
 	.boot_params	= 0x80000100,
 	.map_io		= omap_3430sdp_map_io,
 	.init_irq	= omap_3430sdp_init_irq,
diff --git a/arch/arm/mach-omap2/board-3630sdp.c b/arch/arm/mach-omap2/board-3630sdp.c
index 504d2bd..134c3c8 100644
--- a/arch/arm/mach-omap2/board-3630sdp.c
+++ b/arch/arm/mach-omap2/board-3630sdp.c
@@ -104,8 +104,6 @@ static void __init omap_sdp_init(void)
 }
 
 MACHINE_START(OMAP_3630SDP, "OMAP 3630SDP board")
-	.phys_io	= 0x48000000,
-	.io_pg_offst	= ((0xfa000000) >> 18) & 0xfffc,
 	.boot_params	= 0x80000100,
 	.map_io		= omap_sdp_map_io,
 	.init_irq	= omap_sdp_init_irq,
diff --git a/arch/arm/mach-omap2/board-4430sdp.c b/arch/arm/mach-omap2/board-4430sdp.c
index e4a5d66..5937c24 100644
--- a/arch/arm/mach-omap2/board-4430sdp.c
+++ b/arch/arm/mach-omap2/board-4430sdp.c
@@ -398,8 +398,6 @@ static void __init omap_4430sdp_map_io(void)
 
 MACHINE_START(OMAP_4430SDP, "OMAP4430 4430SDP board")
 	/* Maintainer: Santosh Shilimkar - Texas Instruments Inc */
-	.phys_io	= 0x48000000,
-	.io_pg_offst	= ((0xfa000000) >> 18) & 0xfffc,
 	.boot_params	= 0x80000100,
 	.map_io		= omap_4430sdp_map_io,
 	.init_irq	= omap_4430sdp_init_irq,
diff --git a/arch/arm/mach-omap2/board-am3517evm.c b/arch/arm/mach-omap2/board-am3517evm.c
index af383a8..88f11a7 100644
--- a/arch/arm/mach-omap2/board-am3517evm.c
+++ b/arch/arm/mach-omap2/board-am3517evm.c
@@ -468,8 +468,6 @@ static void __init am3517_evm_map_io(void)
 }
 
 MACHINE_START(OMAP3517EVM, "OMAP3517/AM3517 EVM")
-	.phys_io	= 0x48000000,
-	.io_pg_offst	= ((0xd8000000) >> 18) & 0xfffc,
 	.boot_params	= 0x80000100,
 	.map_io		= am3517_evm_map_io,
 	.init_irq	= am3517_evm_init_irq,
diff --git a/arch/arm/mach-omap2/board-apollon.c b/arch/arm/mach-omap2/board-apollon.c
index aa69fb9..090f05b 100644
--- a/arch/arm/mach-omap2/board-apollon.c
+++ b/arch/arm/mach-omap2/board-apollon.c
@@ -342,8 +342,6 @@ static void __init omap_apollon_map_io(void)
 
 MACHINE_START(OMAP_APOLLON, "OMAP24xx Apollon")
 	/* Maintainer: Kyungmin Park <kyungmin.park@samsung.com> */
-	.phys_io	= 0x48000000,
-	.io_pg_offst	= ((0xfa000000) >> 18) & 0xfffc,
 	.boot_params	= 0x80000100,
 	.map_io		= omap_apollon_map_io,
 	.init_irq	= omap_apollon_init_irq,
diff --git a/arch/arm/mach-omap2/board-cm-t35.c b/arch/arm/mach-omap2/board-cm-t35.c
index e679a2c..d3418be 100644
--- a/arch/arm/mach-omap2/board-cm-t35.c
+++ b/arch/arm/mach-omap2/board-cm-t35.c
@@ -833,8 +833,6 @@ static void __init cm_t35_init(void)
 }
 
 MACHINE_START(CM_T35, "Compulab CM-T35")
-	.phys_io	= 0x48000000,
-	.io_pg_offst	= ((0xd8000000) >> 18) & 0xfffc,
 	.boot_params	= 0x80000100,
 	.map_io		= cm_t35_map_io,
 	.init_irq	= cm_t35_init_irq,
diff --git a/arch/arm/mach-omap2/board-devkit8000.c b/arch/arm/mach-omap2/board-devkit8000.c
index 77022b5..99baba9 100644
--- a/arch/arm/mach-omap2/board-devkit8000.c
+++ b/arch/arm/mach-omap2/board-devkit8000.c
@@ -821,8 +821,6 @@ static void __init devkit8000_map_io(void)
 }
 
 MACHINE_START(DEVKIT8000, "OMAP3 Devkit8000")
-	.phys_io	= 0x48000000,
-	.io_pg_offst	= ((0xd8000000) >> 18) & 0xfffc,
 	.boot_params	= 0x80000100,
 	.map_io		= devkit8000_map_io,
 	.init_irq	= devkit8000_init_irq,
diff --git a/arch/arm/mach-omap2/board-generic.c b/arch/arm/mach-omap2/board-generic.c
index 16cc068..69dce7c 100644
--- a/arch/arm/mach-omap2/board-generic.c
+++ b/arch/arm/mach-omap2/board-generic.c
@@ -55,8 +55,6 @@ static void __init omap_generic_map_io(void)
 
 MACHINE_START(OMAP_GENERIC, "Generic OMAP24xx")
 	/* Maintainer: Paul Mundt <paul.mundt@nokia.com> */
-	.phys_io	= 0x48000000,
-	.io_pg_offst	= ((0xfa000000) >> 18) & 0xfffc,
 	.boot_params	= 0x80000100,
 	.map_io		= omap_generic_map_io,
 	.init_irq	= omap_generic_init_irq,
diff --git a/arch/arm/mach-omap2/board-h4.c b/arch/arm/mach-omap2/board-h4.c
index 0665f2c..8cdd94e 100644
--- a/arch/arm/mach-omap2/board-h4.c
+++ b/arch/arm/mach-omap2/board-h4.c
@@ -374,8 +374,6 @@ static void __init omap_h4_map_io(void)
 
 MACHINE_START(OMAP_H4, "OMAP2420 H4 board")
 	/* Maintainer: Paul Mundt <paul.mundt@nokia.com> */
-	.phys_io	= 0x48000000,
-	.io_pg_offst	= ((0xfa000000) >> 18) & 0xfffc,
 	.boot_params	= 0x80000100,
 	.map_io		= omap_h4_map_io,
 	.init_irq	= omap_h4_init_irq,
diff --git a/arch/arm/mach-omap2/board-igep0020.c b/arch/arm/mach-omap2/board-igep0020.c
index d55c57b..dc5ea06 100644
--- a/arch/arm/mach-omap2/board-igep0020.c
+++ b/arch/arm/mach-omap2/board-igep0020.c
@@ -539,8 +539,6 @@ static void __init igep2_map_io(void)
 }
 
 MACHINE_START(IGEP0020, "IGEP v2 board")
-	.phys_io	= 0x48000000,
-	.io_pg_offst	= ((0xfa000000) >> 18) & 0xfffc,
 	.boot_params	= 0x80000100,
 	.map_io		= igep2_map_io,
 	.init_irq	= igep2_init_irq,
diff --git a/arch/arm/mach-omap2/board-ldp.c b/arch/arm/mach-omap2/board-ldp.c
index fefd7e6..e49b636 100644
--- a/arch/arm/mach-omap2/board-ldp.c
+++ b/arch/arm/mach-omap2/board-ldp.c
@@ -413,8 +413,6 @@ static void __init omap_ldp_map_io(void)
 }
 
 MACHINE_START(OMAP_LDP, "OMAP LDP board")
-	.phys_io	= 0x48000000,
-	.io_pg_offst	= ((0xfa000000) >> 18) & 0xfffc,
 	.boot_params	= 0x80000100,
 	.map_io		= omap_ldp_map_io,
 	.init_irq	= omap_ldp_init_irq,
diff --git a/arch/arm/mach-omap2/board-n8x0.c b/arch/arm/mach-omap2/board-n8x0.c
index 3ccc34e..ae971e0 100644
--- a/arch/arm/mach-omap2/board-n8x0.c
+++ b/arch/arm/mach-omap2/board-n8x0.c
@@ -663,8 +663,6 @@ static void __init n8x0_init_machine(void)
 }
 
 MACHINE_START(NOKIA_N800, "Nokia N800")
-	.phys_io	= 0x48000000,
-	.io_pg_offst	= ((0xfa000000) >> 18) & 0xfffc,
 	.boot_params	= 0x80000100,
 	.map_io		= n8x0_map_io,
 	.init_irq	= n8x0_init_irq,
@@ -673,8 +671,6 @@ MACHINE_START(NOKIA_N800, "Nokia N800")
 MACHINE_END
 
 MACHINE_START(NOKIA_N810, "Nokia N810")
-	.phys_io	= 0x48000000,
-	.io_pg_offst	= ((0xfa000000) >> 18) & 0xfffc,
 	.boot_params	= 0x80000100,
 	.map_io		= n8x0_map_io,
 	.init_irq	= n8x0_init_irq,
@@ -683,8 +679,6 @@ MACHINE_START(NOKIA_N810, "Nokia N810")
 MACHINE_END
 
 MACHINE_START(NOKIA_N810_WIMAX, "Nokia N810 WiMAX")
-	.phys_io	= 0x48000000,
-	.io_pg_offst	= ((0xfa000000) >> 18) & 0xfffc,
 	.boot_params	= 0x80000100,
 	.map_io		= n8x0_map_io,
 	.init_irq	= n8x0_init_irq,
diff --git a/arch/arm/mach-omap2/board-omap3beagle.c b/arch/arm/mach-omap2/board-omap3beagle.c
index 69b154c..88c396c 100644
--- a/arch/arm/mach-omap2/board-omap3beagle.c
+++ b/arch/arm/mach-omap2/board-omap3beagle.c
@@ -515,8 +515,6 @@ static void __init omap3_beagle_map_io(void)
 
 MACHINE_START(OMAP3_BEAGLE, "OMAP3 Beagle Board")
 	/* Maintainer: Syed Mohammed Khasim - http://beagleboard.org */
-	.phys_io	= 0x48000000,
-	.io_pg_offst	= ((0xfa000000) >> 18) & 0xfffc,
 	.boot_params	= 0x80000100,
 	.map_io		= omap3_beagle_map_io,
 	.init_irq	= omap3_beagle_init_irq,
diff --git a/arch/arm/mach-omap2/board-omap3evm.c b/arch/arm/mach-omap2/board-omap3evm.c
index b952610..f484996 100644
--- a/arch/arm/mach-omap2/board-omap3evm.c
+++ b/arch/arm/mach-omap2/board-omap3evm.c
@@ -723,8 +723,6 @@ static void __init omap3_evm_map_io(void)
 
 MACHINE_START(OMAP3EVM, "OMAP3 EVM")
 	/* Maintainer: Syed Mohammed Khasim - Texas Instruments */
-	.phys_io	= 0x48000000,
-	.io_pg_offst	= ((0xfa000000) >> 18) & 0xfffc,
 	.boot_params	= 0x80000100,
 	.map_io		= omap3_evm_map_io,
 	.init_irq	= omap3_evm_init_irq,
diff --git a/arch/arm/mach-omap2/board-omap3pandora.c b/arch/arm/mach-omap2/board-omap3pandora.c
index db06dc9..f662420 100644
--- a/arch/arm/mach-omap2/board-omap3pandora.c
+++ b/arch/arm/mach-omap2/board-omap3pandora.c
@@ -597,8 +597,6 @@ static void __init omap3pandora_map_io(void)
 }
 
 MACHINE_START(OMAP3_PANDORA, "Pandora Handheld Console")
-	.phys_io	= 0x48000000,
-	.io_pg_offst	= ((0xfa000000) >> 18) & 0xfffc,
 	.boot_params	= 0x80000100,
 	.map_io		= omap3pandora_map_io,
 	.init_irq	= omap3pandora_init_irq,
diff --git a/arch/arm/mach-omap2/board-omap3stalker.c b/arch/arm/mach-omap2/board-omap3stalker.c
index a04cffd..064f70a 100644
--- a/arch/arm/mach-omap2/board-omap3stalker.c
+++ b/arch/arm/mach-omap2/board-omap3stalker.c
@@ -660,8 +660,6 @@ static void __init omap3_stalker_map_io(void)
 
 MACHINE_START(SBC3530, "OMAP3 STALKER")
 	/* Maintainer: Jason Lam -lzg at ema-tech.com */
-	.phys_io		= 0x48000000,
-	.io_pg_offst		= ((0xfa000000) >> 18) & 0xfffc,
 	.boot_params		= 0x80000100,
 	.map_io			= omap3_stalker_map_io,
 	.init_irq		= omap3_stalker_init_irq,
diff --git a/arch/arm/mach-omap2/board-omap3touchbook.c b/arch/arm/mach-omap2/board-omap3touchbook.c
index 2f5f823..39884a1 100644
--- a/arch/arm/mach-omap2/board-omap3touchbook.c
+++ b/arch/arm/mach-omap2/board-omap3touchbook.c
@@ -567,8 +567,6 @@ static void __init omap3_touchbook_map_io(void)
 
 MACHINE_START(TOUCHBOOK, "OMAP3 touchbook Board")
 	/* Maintainer: Gregoire Gentil - http://www.alwaysinnovating.com */
-	.phys_io	= 0x48000000,
-	.io_pg_offst	= ((0xd8000000) >> 18) & 0xfffc,
 	.boot_params	= 0x80000100,
 	.map_io		= omap3_touchbook_map_io,
 	.init_irq	= omap3_touchbook_init_irq,
diff --git a/arch/arm/mach-omap2/board-overo.c b/arch/arm/mach-omap2/board-overo.c
index 79ac414..d231db1 100644
--- a/arch/arm/mach-omap2/board-overo.c
+++ b/arch/arm/mach-omap2/board-overo.c
@@ -491,8 +491,6 @@ static void __init overo_map_io(void)
 }
 
 MACHINE_START(OVERO, "Gumstix Overo")
-	.phys_io	= 0x48000000,
-	.io_pg_offst	= ((0xfa000000) >> 18) & 0xfffc,
 	.boot_params	= 0x80000100,
 	.map_io		= overo_map_io,
 	.init_irq	= overo_init_irq,
diff --git a/arch/arm/mach-omap2/board-rx51.c b/arch/arm/mach-omap2/board-rx51.c
index 1b86b5b..42a55fd 100644
--- a/arch/arm/mach-omap2/board-rx51.c
+++ b/arch/arm/mach-omap2/board-rx51.c
@@ -150,8 +150,6 @@ static void __init rx51_map_io(void)
 
 MACHINE_START(NOKIA_RX51, "Nokia RX-51 board")
 	/* Maintainer: Lauri Leukkunen <lauri.leukkunen@nokia.com> */
-	.phys_io	= 0x48000000,
-	.io_pg_offst	= ((0xfa000000) >> 18) & 0xfffc,
 	.boot_params	= 0x80000100,
 	.map_io		= rx51_map_io,
 	.init_irq	= rx51_init_irq,
diff --git a/arch/arm/mach-omap2/board-zoom2.c b/arch/arm/mach-omap2/board-zoom2.c
index 803ef14..c45b0b1 100644
--- a/arch/arm/mach-omap2/board-zoom2.c
+++ b/arch/arm/mach-omap2/board-zoom2.c
@@ -91,8 +91,6 @@ static void __init omap_zoom2_map_io(void)
 }
 
 MACHINE_START(OMAP_ZOOM2, "OMAP Zoom2 board")
-	.phys_io	= ZOOM_UART_BASE,
-	.io_pg_offst	= (ZOOM_UART_VIRT >> 18) & 0xfffc,
 	.boot_params	= 0x80000100,
 	.map_io		= omap_zoom2_map_io,
 	.init_irq	= omap_zoom2_init_irq,
diff --git a/arch/arm/mach-omap2/board-zoom3.c b/arch/arm/mach-omap2/board-zoom3.c
index 3314704..8603c4a 100644
--- a/arch/arm/mach-omap2/board-zoom3.c
+++ b/arch/arm/mach-omap2/board-zoom3.c
@@ -73,8 +73,6 @@ static void __init omap_zoom_init(void)
 }
 
 MACHINE_START(OMAP_ZOOM3, "OMAP Zoom3 board")
-	.phys_io	= ZOOM_UART_BASE,
-	.io_pg_offst	= (ZOOM_UART_VIRT >> 18) & 0xfffc,
 	.boot_params	= 0x80000100,
 	.map_io		= omap_zoom_map_io,
 	.init_irq	= omap_zoom_init_irq,
diff --git a/arch/arm/mach-orion5x/d2net-setup.c b/arch/arm/mach-orion5x/d2net-setup.c
index 7130904..b1c451f 100644
--- a/arch/arm/mach-orion5x/d2net-setup.c
+++ b/arch/arm/mach-orion5x/d2net-setup.c
@@ -336,8 +336,6 @@ static void __init d2net_init(void)
 
 #ifdef CONFIG_MACH_D2NET
 MACHINE_START(D2NET, "LaCie d2 Network")
-	.phys_io	= ORION5X_REGS_PHYS_BASE,
-	.io_pg_offst	= ((ORION5X_REGS_VIRT_BASE) >> 18) & 0xFFFC,
 	.boot_params	= 0x00000100,
 	.init_machine	= d2net_init,
 	.map_io		= orion5x_map_io,
@@ -349,8 +347,6 @@ MACHINE_END
 
 #ifdef CONFIG_MACH_BIGDISK
 MACHINE_START(BIGDISK, "LaCie Big Disk Network")
-	.phys_io	= ORION5X_REGS_PHYS_BASE,
-	.io_pg_offst	= ((ORION5X_REGS_VIRT_BASE) >> 18) & 0xFFFC,
 	.boot_params	= 0x00000100,
 	.init_machine	= d2net_init,
 	.map_io		= orion5x_map_io,
diff --git a/arch/arm/mach-orion5x/db88f5281-setup.c b/arch/arm/mach-orion5x/db88f5281-setup.c
index d318bea..df1083f 100644
--- a/arch/arm/mach-orion5x/db88f5281-setup.c
+++ b/arch/arm/mach-orion5x/db88f5281-setup.c
@@ -358,8 +358,6 @@ static void __init db88f5281_init(void)
 
 MACHINE_START(DB88F5281, "Marvell Orion-2 Development Board")
 	/* Maintainer: Tzachi Perelstein <tzachi@marvell.com> */
-	.phys_io	= ORION5X_REGS_PHYS_BASE,
-	.io_pg_offst	= ((ORION5X_REGS_VIRT_BASE) >> 18) & 0xfffc,
 	.boot_params	= 0x00000100,
 	.init_machine	= db88f5281_init,
 	.map_io		= orion5x_map_io,
diff --git a/arch/arm/mach-orion5x/dns323-setup.c b/arch/arm/mach-orion5x/dns323-setup.c
index fe0de16..3f2e6fd 100644
--- a/arch/arm/mach-orion5x/dns323-setup.c
+++ b/arch/arm/mach-orion5x/dns323-setup.c
@@ -488,8 +488,6 @@ static void __init dns323_init(void)
 /* Warning: D-Link uses a wrong mach-type (=526) in their bootloader */
 MACHINE_START(DNS323, "D-Link DNS-323")
 	/* Maintainer: Herbert Valerio Riedel <hvr@gnu.org> */
-	.phys_io	= ORION5X_REGS_PHYS_BASE,
-	.io_pg_offst	= ((ORION5X_REGS_VIRT_BASE) >> 18) & 0xFFFC,
 	.boot_params	= 0x00000100,
 	.init_machine	= dns323_init,
 	.map_io		= orion5x_map_io,
diff --git a/arch/arm/mach-orion5x/edmini_v2-setup.c b/arch/arm/mach-orion5x/edmini_v2-setup.c
index b24ee0c..ba98459 100644
--- a/arch/arm/mach-orion5x/edmini_v2-setup.c
+++ b/arch/arm/mach-orion5x/edmini_v2-setup.c
@@ -251,8 +251,6 @@ static void __init edmini_v2_init(void)
 /* Warning: LaCie use a wrong mach-type (0x20e=526) in their bootloader. */
 MACHINE_START(EDMINI_V2, "LaCie Ethernet Disk mini V2")
 	/* Maintainer: Christopher Moore <moore@free.fr> */
-	.phys_io	= ORION5X_REGS_PHYS_BASE,
-	.io_pg_offst	= ((ORION5X_REGS_VIRT_BASE) >> 18) & 0xFFFC,
 	.boot_params	= 0x00000100,
 	.init_machine	= edmini_v2_init,
 	.map_io		= orion5x_map_io,
diff --git a/arch/arm/mach-orion5x/kurobox_pro-setup.c b/arch/arm/mach-orion5x/kurobox_pro-setup.c
index dfbb68d..4be9aa0 100644
--- a/arch/arm/mach-orion5x/kurobox_pro-setup.c
+++ b/arch/arm/mach-orion5x/kurobox_pro-setup.c
@@ -379,8 +379,6 @@ static void __init kurobox_pro_init(void)
 #ifdef CONFIG_MACH_KUROBOX_PRO
 MACHINE_START(KUROBOX_PRO, "Buffalo/Revogear Kurobox Pro")
 	/* Maintainer: Ronen Shitrit <rshitrit@marvell.com> */
-	.phys_io	= ORION5X_REGS_PHYS_BASE,
-	.io_pg_offst	= ((ORION5X_REGS_VIRT_BASE) >> 18) & 0xFFFC,
 	.boot_params	= 0x00000100,
 	.init_machine	= kurobox_pro_init,
 	.map_io		= orion5x_map_io,
@@ -393,8 +391,6 @@ MACHINE_END
 #ifdef CONFIG_MACH_LINKSTATION_PRO
 MACHINE_START(LINKSTATION_PRO, "Buffalo Linkstation Pro/Live")
 	/* Maintainer: Byron Bradley <byron.bbradley@gmail.com> */
-	.phys_io	= ORION5X_REGS_PHYS_BASE,
-	.io_pg_offst	= ((ORION5X_REGS_VIRT_BASE) >> 18) & 0xFFFC,
 	.boot_params	= 0x00000100,
 	.init_machine	= kurobox_pro_init,
 	.map_io		= orion5x_map_io,
diff --git a/arch/arm/mach-orion5x/ls_hgl-setup.c b/arch/arm/mach-orion5x/ls_hgl-setup.c
index 8e569be..437364b 100644
--- a/arch/arm/mach-orion5x/ls_hgl-setup.c
+++ b/arch/arm/mach-orion5x/ls_hgl-setup.c
@@ -265,8 +265,6 @@ static void __init ls_hgl_init(void)
 
 MACHINE_START(LINKSTATION_LS_HGL, "Buffalo Linkstation LS-HGL")
 	/* Maintainer: Zhu Qingsen <zhuqs@cn.fujistu.com> */
-	.phys_io	= ORION5X_REGS_PHYS_BASE,
-	.io_pg_offst	= ((ORION5X_REGS_VIRT_BASE) >> 18) & 0xFFFC,
 	.boot_params	= 0x00000100,
 	.init_machine	= ls_hgl_init,
 	.map_io		= orion5x_map_io,
diff --git a/arch/arm/mach-orion5x/lsmini-setup.c b/arch/arm/mach-orion5x/lsmini-setup.c
index c704f05..ab9b0cf 100644
--- a/arch/arm/mach-orion5x/lsmini-setup.c
+++ b/arch/arm/mach-orion5x/lsmini-setup.c
@@ -267,8 +267,6 @@ static void __init lsmini_init(void)
 #ifdef CONFIG_MACH_LINKSTATION_MINI
 MACHINE_START(LINKSTATION_MINI, "Buffalo Linkstation Mini")
 	/* Maintainer: Alexey Kopytko <alexey@kopytko.ru> */
-	.phys_io	= ORION5X_REGS_PHYS_BASE,
-	.io_pg_offst	= ((ORION5X_REGS_VIRT_BASE) >> 18) & 0xFFFC,
 	.boot_params	= 0x00000100,
 	.init_machine	= lsmini_init,
 	.map_io		= orion5x_map_io,
diff --git a/arch/arm/mach-orion5x/mss2-setup.c b/arch/arm/mach-orion5x/mss2-setup.c
index 61c086b..2f0e16c 100644
--- a/arch/arm/mach-orion5x/mss2-setup.c
+++ b/arch/arm/mach-orion5x/mss2-setup.c
@@ -261,8 +261,6 @@ static void __init mss2_init(void)
 
 MACHINE_START(MSS2, "Maxtor Shared Storage II")
 	/* Maintainer: Sylver Bruneau <sylver.bruneau@googlemail.com> */
-	.phys_io	= ORION5X_REGS_PHYS_BASE,
-	.io_pg_offst	= ((ORION5X_REGS_VIRT_BASE) >> 18) & 0xFFFC,
 	.boot_params	= 0x00000100,
 	.init_machine	= mss2_init,
 	.map_io		= orion5x_map_io,
diff --git a/arch/arm/mach-orion5x/mv2120-setup.c b/arch/arm/mach-orion5x/mv2120-setup.c
index 97c9ccb..b3d90f2 100644
--- a/arch/arm/mach-orion5x/mv2120-setup.c
+++ b/arch/arm/mach-orion5x/mv2120-setup.c
@@ -229,8 +229,6 @@ static void __init mv2120_init(void)
 /* Warning: HP uses a wrong mach-type (=526) in their bootloader */
 MACHINE_START(MV2120, "HP Media Vault mv2120")
 	/* Maintainer: Martin Michlmayr <tbm@cyrius.com> */
-	.phys_io	= ORION5X_REGS_PHYS_BASE,
-	.io_pg_offst	= ((ORION5X_REGS_VIRT_BASE) >> 18) & 0xFFFC,
 	.boot_params	= 0x00000100,
 	.init_machine	= mv2120_init,
 	.map_io		= orion5x_map_io,
diff --git a/arch/arm/mach-orion5x/net2big-setup.c b/arch/arm/mach-orion5x/net2big-setup.c
index 7bd6283..d6665b3 100644
--- a/arch/arm/mach-orion5x/net2big-setup.c
+++ b/arch/arm/mach-orion5x/net2big-setup.c
@@ -419,8 +419,6 @@ static void __init net2big_init(void)
 
 /* Warning: LaCie use a wrong mach-type (0x20e=526) in their bootloader. */
 MACHINE_START(NET2BIG, "LaCie 2Big Network")
-	.phys_io	= ORION5X_REGS_PHYS_BASE,
-	.io_pg_offst	= ((ORION5X_REGS_VIRT_BASE) >> 18) & 0xFFFC,
 	.boot_params	= 0x00000100,
 	.init_machine	= net2big_init,
 	.map_io		= orion5x_map_io,
diff --git a/arch/arm/mach-orion5x/rd88f5181l-fxo-setup.c b/arch/arm/mach-orion5x/rd88f5181l-fxo-setup.c
index 9c1ca41..f4c26fd 100644
--- a/arch/arm/mach-orion5x/rd88f5181l-fxo-setup.c
+++ b/arch/arm/mach-orion5x/rd88f5181l-fxo-setup.c
@@ -169,8 +169,6 @@ subsys_initcall(rd88f5181l_fxo_pci_init);
 
 MACHINE_START(RD88F5181L_FXO, "Marvell Orion-VoIP FXO Reference Design")
 	/* Maintainer: Nicolas Pitre <nico@marvell.com> */
-	.phys_io	= ORION5X_REGS_PHYS_BASE,
-	.io_pg_offst	= ((ORION5X_REGS_VIRT_BASE) >> 18) & 0xFFFC,
 	.boot_params	= 0x00000100,
 	.init_machine	= rd88f5181l_fxo_init,
 	.map_io		= orion5x_map_io,
diff --git a/arch/arm/mach-orion5x/rd88f5181l-ge-setup.c b/arch/arm/mach-orion5x/rd88f5181l-ge-setup.c
index ee1399f..b594290 100644
--- a/arch/arm/mach-orion5x/rd88f5181l-ge-setup.c
+++ b/arch/arm/mach-orion5x/rd88f5181l-ge-setup.c
@@ -181,8 +181,6 @@ subsys_initcall(rd88f5181l_ge_pci_init);
 
 MACHINE_START(RD88F5181L_GE, "Marvell Orion-VoIP GE Reference Design")
 	/* Maintainer: Lennert Buytenhek <buytenh@marvell.com> */
-	.phys_io	= ORION5X_REGS_PHYS_BASE,
-	.io_pg_offst	= ((ORION5X_REGS_VIRT_BASE) >> 18) & 0xFFFC,
 	.boot_params	= 0x00000100,
 	.init_machine	= rd88f5181l_ge_init,
 	.map_io		= orion5x_map_io,
diff --git a/arch/arm/mach-orion5x/rd88f5182-setup.c b/arch/arm/mach-orion5x/rd88f5182-setup.c
index a04f9e4..165ed87 100644
--- a/arch/arm/mach-orion5x/rd88f5182-setup.c
+++ b/arch/arm/mach-orion5x/rd88f5182-setup.c
@@ -305,8 +305,6 @@ static void __init rd88f5182_init(void)
 
 MACHINE_START(RD88F5182, "Marvell Orion-NAS Reference Design")
 	/* Maintainer: Ronen Shitrit <rshitrit@marvell.com> */
-	.phys_io	= ORION5X_REGS_PHYS_BASE,
-	.io_pg_offst	= ((ORION5X_REGS_VIRT_BASE) >> 18) & 0xFFFC,
 	.boot_params	= 0x00000100,
 	.init_machine	= rd88f5182_init,
 	.map_io		= orion5x_map_io,
diff --git a/arch/arm/mach-orion5x/rd88f6183ap-ge-setup.c b/arch/arm/mach-orion5x/rd88f6183ap-ge-setup.c
index 7737cf9..02ff45f 100644
--- a/arch/arm/mach-orion5x/rd88f6183ap-ge-setup.c
+++ b/arch/arm/mach-orion5x/rd88f6183ap-ge-setup.c
@@ -123,8 +123,6 @@ subsys_initcall(rd88f6183ap_ge_pci_init);
 
 MACHINE_START(RD88F6183AP_GE, "Marvell Orion-1-90 AP GE Reference Design")
 	/* Maintainer: Lennert Buytenhek <buytenh@marvell.com> */
-	.phys_io	= ORION5X_REGS_PHYS_BASE,
-	.io_pg_offst	= ((ORION5X_REGS_VIRT_BASE) >> 18) & 0xFFFC,
 	.boot_params	= 0x00000100,
 	.init_machine	= rd88f6183ap_ge_init,
 	.map_io		= orion5x_map_io,
diff --git a/arch/arm/mach-orion5x/terastation_pro2-setup.c b/arch/arm/mach-orion5x/terastation_pro2-setup.c
index 0b101d7..4403fae 100644
--- a/arch/arm/mach-orion5x/terastation_pro2-setup.c
+++ b/arch/arm/mach-orion5x/terastation_pro2-setup.c
@@ -358,8 +358,6 @@ static void __init tsp2_init(void)
 
 MACHINE_START(TERASTATION_PRO2, "Buffalo Terastation Pro II/Live")
 	/* Maintainer:  Sylver Bruneau <sylver.bruneau@googlemail.com> */
-	.phys_io	= ORION5X_REGS_PHYS_BASE,
-	.io_pg_offst	= ((ORION5X_REGS_VIRT_BASE) >> 18) & 0xFFFC,
 	.boot_params	= 0x00000100,
 	.init_machine	= tsp2_init,
 	.map_io		= orion5x_map_io,
diff --git a/arch/arm/mach-orion5x/ts209-setup.c b/arch/arm/mach-orion5x/ts209-setup.c
index 9d68905..1e19612 100644
--- a/arch/arm/mach-orion5x/ts209-setup.c
+++ b/arch/arm/mach-orion5x/ts209-setup.c
@@ -322,8 +322,6 @@ static void __init qnap_ts209_init(void)
 
 MACHINE_START(TS209, "QNAP TS-109/TS-209")
 	/* Maintainer: Byron Bradley <byron.bbradley@gmail.com> */
-	.phys_io	= ORION5X_REGS_PHYS_BASE,
-	.io_pg_offst	= ((ORION5X_REGS_VIRT_BASE) >> 18) & 0xFFFC,
 	.boot_params	= 0x00000100,
 	.init_machine	= qnap_ts209_init,
 	.map_io		= orion5x_map_io,
diff --git a/arch/arm/mach-orion5x/ts409-setup.c b/arch/arm/mach-orion5x/ts409-setup.c
index d85588a..428af20 100644
--- a/arch/arm/mach-orion5x/ts409-setup.c
+++ b/arch/arm/mach-orion5x/ts409-setup.c
@@ -311,8 +311,6 @@ static void __init qnap_ts409_init(void)
 
 MACHINE_START(TS409, "QNAP TS-409")
 	/* Maintainer:  Sylver Bruneau <sylver.bruneau@gmail.com> */
-	.phys_io	= ORION5X_REGS_PHYS_BASE,
-	.io_pg_offst	= ((ORION5X_REGS_VIRT_BASE) >> 18) & 0xFFFC,
 	.boot_params	= 0x00000100,
 	.init_machine	= qnap_ts409_init,
 	.map_io		= orion5x_map_io,
diff --git a/arch/arm/mach-orion5x/ts78xx-setup.c b/arch/arm/mach-orion5x/ts78xx-setup.c
index 5041d1b..65b97c4 100644
--- a/arch/arm/mach-orion5x/ts78xx-setup.c
+++ b/arch/arm/mach-orion5x/ts78xx-setup.c
@@ -549,8 +549,6 @@ static void __init ts78xx_init(void)
 
 MACHINE_START(TS78XX, "Technologic Systems TS-78xx SBC")
 	/* Maintainer: Alexander Clouter <alex@digriz.org.uk> */
-	.phys_io	= ORION5X_REGS_PHYS_BASE,
-	.io_pg_offst	= ((ORION5X_REGS_VIRT_BASE) >> 18) & 0xFFFC,
 	.boot_params	= 0x00000100,
 	.init_machine	= ts78xx_init,
 	.map_io		= ts78xx_map_io,
diff --git a/arch/arm/mach-orion5x/wnr854t-setup.c b/arch/arm/mach-orion5x/wnr854t-setup.c
index 6920821..7994d6e 100644
--- a/arch/arm/mach-orion5x/wnr854t-setup.c
+++ b/arch/arm/mach-orion5x/wnr854t-setup.c
@@ -172,8 +172,6 @@ subsys_initcall(wnr854t_pci_init);
 
 MACHINE_START(WNR854T, "Netgear WNR854T")
 	/* Maintainer: Imre Kaloz <kaloz@openwrt.org> */
-	.phys_io	= ORION5X_REGS_PHYS_BASE,
-	.io_pg_offst	= ((ORION5X_REGS_VIRT_BASE) >> 18) & 0xFFFC,
 	.boot_params	= 0x00000100,
 	.init_machine	= wnr854t_init,
 	.map_io		= orion5x_map_io,
diff --git a/arch/arm/mach-orion5x/wrt350n-v2-setup.c b/arch/arm/mach-orion5x/wrt350n-v2-setup.c
index f9f222e..a5989b7 100644
--- a/arch/arm/mach-orion5x/wrt350n-v2-setup.c
+++ b/arch/arm/mach-orion5x/wrt350n-v2-setup.c
@@ -260,8 +260,6 @@ subsys_initcall(wrt350n_v2_pci_init);
 
 MACHINE_START(WRT350N_V2, "Linksys WRT350N v2")
 	/* Maintainer: Lennert Buytenhek <buytenh@marvell.com> */
-	.phys_io	= ORION5X_REGS_PHYS_BASE,
-	.io_pg_offst	= ((ORION5X_REGS_VIRT_BASE) >> 18) & 0xFFFC,
 	.boot_params	= 0x00000100,
 	.init_machine	= wrt350n_v2_init,
 	.map_io		= orion5x_map_io,
diff --git a/arch/arm/mach-pnx4008/core.c b/arch/arm/mach-pnx4008/core.c
index 45734bb..6339975 100644
--- a/arch/arm/mach-pnx4008/core.c
+++ b/arch/arm/mach-pnx4008/core.c
@@ -264,8 +264,6 @@ extern struct sys_timer pnx4008_timer;
 
 MACHINE_START(PNX4008, "Philips PNX4008")
 	/* Maintainer: MontaVista Software Inc. */
-	.phys_io 		= 0x40090000,
-	.io_pg_offst 		= (0xf4090000 >> 18) & 0xfffc,
 	.boot_params		= 0x80000100,
 	.map_io 		= pnx4008_map_io,
 	.init_irq 		= pnx4008_init_irq,
diff --git a/arch/arm/mach-pxa/balloon3.c b/arch/arm/mach-pxa/balloon3.c
index f3b5ace..c5f49ee 100644
--- a/arch/arm/mach-pxa/balloon3.c
+++ b/arch/arm/mach-pxa/balloon3.c
@@ -346,8 +346,6 @@ static void __init balloon3_map_io(void)
 
 MACHINE_START(BALLOON3, "Balloon3")
 	/* Maintainer: Nick Bane. */
-	.phys_io	= 0x40000000,
-	.io_pg_offst	= (io_p2v(0x40000000) >> 18) & 0xfffc,
 	.map_io		= balloon3_map_io,
 	.init_irq	= balloon3_init_irq,
 	.timer		= &pxa_timer,
diff --git a/arch/arm/mach-pxa/capc7117.c b/arch/arm/mach-pxa/capc7117.c
index aae5446..4bd7a3c 100644
--- a/arch/arm/mach-pxa/capc7117.c
+++ b/arch/arm/mach-pxa/capc7117.c
@@ -148,9 +148,7 @@ static void __init capc7117_init(void)
 
 MACHINE_START(CAPC7117,
 	      "Embedian CAPC-7117 evaluation kit based on the MXM-8x10 CoM")
-	.phys_io = 0x40000000,
 	.boot_params = 0xa0000100,
-	.io_pg_offst = (io_p2v(0x40000000) >> 18) & 0xfffc,
 	.map_io = pxa_map_io,
 	.init_irq = pxa3xx_init_irq,
 	.timer = &pxa_timer,
diff --git a/arch/arm/mach-pxa/cm-x2xx.c b/arch/arm/mach-pxa/cm-x2xx.c
index bff6e78..45922b5 100644
--- a/arch/arm/mach-pxa/cm-x2xx.c
+++ b/arch/arm/mach-pxa/cm-x2xx.c
@@ -511,8 +511,6 @@ static void __init cmx2xx_map_io(void)
 
 MACHINE_START(ARMCORE, "Compulab CM-X2XX")
 	.boot_params	= 0xa0000100,
-	.phys_io	= 0x40000000,
-	.io_pg_offst	= (io_p2v(0x40000000) >> 18) & 0xfffc,
 	.map_io		= cmx2xx_map_io,
 	.init_irq	= cmx2xx_init_irq,
 	.timer		= &pxa_timer,
diff --git a/arch/arm/mach-pxa/cm-x300.c b/arch/arm/mach-pxa/cm-x300.c
index fdda6be..650b49d 100644
--- a/arch/arm/mach-pxa/cm-x300.c
+++ b/arch/arm/mach-pxa/cm-x300.c
@@ -777,9 +777,7 @@ static void __init cm_x300_fixup(struct machine_desc *mdesc, struct tag *tags,
 }
 
 MACHINE_START(CM_X300, "CM-X300 module")
-	.phys_io	= 0x40000000,
 	.boot_params	= 0xa0000100,
-	.io_pg_offst	= (io_p2v(0x40000000) >> 18) & 0xfffc,
 	.map_io		= pxa_map_io,
 	.init_irq	= pxa3xx_init_irq,
 	.timer		= &pxa_timer,
diff --git a/arch/arm/mach-pxa/colibri-pxa270.c b/arch/arm/mach-pxa/colibri-pxa270.c
index 061c453..1261337 100644
--- a/arch/arm/mach-pxa/colibri-pxa270.c
+++ b/arch/arm/mach-pxa/colibri-pxa270.c
@@ -137,8 +137,6 @@ static void __init colibri_pxa270_init(void)
 }
 
 MACHINE_START(COLIBRI, "Toradex Colibri PXA270")
-	.phys_io	= 0x40000000,
-	.io_pg_offst	= (io_p2v(0x40000000) >> 18) & 0xfffc,
 	.boot_params	= COLIBRI_SDRAM_BASE + 0x100,
 	.init_machine	= colibri_pxa270_init,
 	.map_io		= pxa_map_io,
diff --git a/arch/arm/mach-pxa/colibri-pxa300.c b/arch/arm/mach-pxa/colibri-pxa300.c
index 45c23fd..d415527 100644
--- a/arch/arm/mach-pxa/colibri-pxa300.c
+++ b/arch/arm/mach-pxa/colibri-pxa300.c
@@ -185,8 +185,6 @@ void __init colibri_pxa300_init(void)
 }
 
 MACHINE_START(COLIBRI300, "Toradex Colibri PXA300")
-	.phys_io	= 0x40000000,
-	.io_pg_offst	= (io_p2v(0x40000000) >> 18) & 0xfffc,
 	.boot_params	= COLIBRI_SDRAM_BASE + 0x100,
 	.init_machine	= colibri_pxa300_init,
 	.map_io		= pxa_map_io,
diff --git a/arch/arm/mach-pxa/colibri-pxa320.c b/arch/arm/mach-pxa/colibri-pxa320.c
index ae835fa..da46bd6 100644
--- a/arch/arm/mach-pxa/colibri-pxa320.c
+++ b/arch/arm/mach-pxa/colibri-pxa320.c
@@ -215,8 +215,6 @@ void __init colibri_pxa320_init(void)
 }
 
 MACHINE_START(COLIBRI320, "Toradex Colibri PXA320")
-	.phys_io	= 0x40000000,
-	.io_pg_offst	= (io_p2v(0x40000000) >> 18) & 0xfffc,
 	.boot_params	= COLIBRI_SDRAM_BASE + 0x100,
 	.init_machine	= colibri_pxa320_init,
 	.map_io		= pxa_map_io,
diff --git a/arch/arm/mach-pxa/corgi.c b/arch/arm/mach-pxa/corgi.c
index 3d1dcb9..8ea82a3 100644
--- a/arch/arm/mach-pxa/corgi.c
+++ b/arch/arm/mach-pxa/corgi.c
@@ -724,8 +724,6 @@ static void __init fixup_corgi(struct machine_desc *desc,
 
 #ifdef CONFIG_MACH_CORGI
 MACHINE_START(CORGI, "SHARP Corgi")
-	.phys_io	= 0x40000000,
-	.io_pg_offst	= (io_p2v(0x40000000) >> 18) & 0xfffc,
 	.fixup		= fixup_corgi,
 	.map_io		= pxa_map_io,
 	.init_irq	= pxa25x_init_irq,
@@ -736,8 +734,6 @@ MACHINE_END
 
 #ifdef CONFIG_MACH_SHEPHERD
 MACHINE_START(SHEPHERD, "SHARP Shepherd")
-	.phys_io	= 0x40000000,
-	.io_pg_offst	= (io_p2v(0x40000000) >> 18) & 0xfffc,
 	.fixup		= fixup_corgi,
 	.map_io		= pxa_map_io,
 	.init_irq	= pxa25x_init_irq,
@@ -748,8 +744,6 @@ MACHINE_END
 
 #ifdef CONFIG_MACH_HUSKY
 MACHINE_START(HUSKY, "SHARP Husky")
-	.phys_io	= 0x40000000,
-	.io_pg_offst	= (io_p2v(0x40000000) >> 18) & 0xfffc,
 	.fixup		= fixup_corgi,
 	.map_io		= pxa_map_io,
 	.init_irq	= pxa25x_init_irq,
diff --git a/arch/arm/mach-pxa/csb726.c b/arch/arm/mach-pxa/csb726.c
index 91fd4fe..57cacaf 100644
--- a/arch/arm/mach-pxa/csb726.c
+++ b/arch/arm/mach-pxa/csb726.c
@@ -272,9 +272,7 @@ static void __init csb726_init(void)
 }
 
 MACHINE_START(CSB726, "Cogent CSB726")
-	.phys_io	= 0x40000000,
 	.boot_params	= 0xa0000100,
-	.io_pg_offst	= (io_p2v(0x40000000) >> 18) & 0xfffc,
 	.map_io         = pxa_map_io,
 	.init_irq       = pxa27x_init_irq,
 	.init_machine   = csb726_init,
diff --git a/arch/arm/mach-pxa/e330.c b/arch/arm/mach-pxa/e330.c
index 8fde338..260ff6e 100644
--- a/arch/arm/mach-pxa/e330.c
+++ b/arch/arm/mach-pxa/e330.c
@@ -66,8 +66,6 @@ static void __init e330_init(void)
 
 MACHINE_START(E330, "Toshiba e330")
 	/* Maintainer: Ian Molton (spyro at f2s.com) */
-	.phys_io	= 0x40000000,
-	.io_pg_offst	= (io_p2v(0x40000000) >> 18) & 0xfffc,
 	.boot_params	= 0xa0000100,
 	.map_io		= pxa_map_io,
 	.init_irq	= pxa25x_init_irq,
diff --git a/arch/arm/mach-pxa/e350.c b/arch/arm/mach-pxa/e350.c
index f50f055..4a76cf9 100644
--- a/arch/arm/mach-pxa/e350.c
+++ b/arch/arm/mach-pxa/e350.c
@@ -67,8 +67,6 @@ static void __init e350_init(void)
 
 MACHINE_START(E350, "Toshiba e350")
 	/* Maintainer: Ian Molton (spyro at f2s.com) */
-	.phys_io	= 0x40000000,
-	.io_pg_offst	= (io_p2v(0x40000000) >> 18) & 0xfffc,
 	.boot_params	= 0xa0000100,
 	.map_io		= pxa_map_io,
 	.init_irq	= pxa25x_init_irq,
diff --git a/arch/arm/mach-pxa/e400.c b/arch/arm/mach-pxa/e400.c
index 55b950f..c36da6b 100644
--- a/arch/arm/mach-pxa/e400.c
+++ b/arch/arm/mach-pxa/e400.c
@@ -143,8 +143,6 @@ static void __init e400_init(void)
 
 MACHINE_START(E400, "Toshiba e400")
 	/* Maintainer: Ian Molton (spyro at f2s.com) */
-	.phys_io	= 0x40000000,
-	.io_pg_offst	= (io_p2v(0x40000000) >> 18) & 0xfffc,
 	.boot_params	= 0xa0000100,
 	.map_io		= pxa_map_io,
 	.init_irq	= pxa25x_init_irq,
diff --git a/arch/arm/mach-pxa/e740.c b/arch/arm/mach-pxa/e740.c
index d578021..a3335b3 100644
--- a/arch/arm/mach-pxa/e740.c
+++ b/arch/arm/mach-pxa/e740.c
@@ -213,8 +213,6 @@ static void __init e740_init(void)
 
 MACHINE_START(E740, "Toshiba e740")
 	/* Maintainer: Ian Molton (spyro at f2s.com) */
-	.phys_io	= 0x40000000,
-	.io_pg_offst	= (io_p2v(0x40000000) >> 18) & 0xfffc,
 	.boot_params	= 0xa0000100,
 	.map_io		= pxa_map_io,
 	.init_irq	= pxa25x_init_irq,
diff --git a/arch/arm/mach-pxa/e750.c b/arch/arm/mach-pxa/e750.c
index af83caa..7e968fb 100644
--- a/arch/arm/mach-pxa/e750.c
+++ b/arch/arm/mach-pxa/e750.c
@@ -214,8 +214,6 @@ static void __init e750_init(void)
 
 MACHINE_START(E750, "Toshiba e750")
 	/* Maintainer: Ian Molton (spyro at f2s.com) */
-	.phys_io	= 0x40000000,
-	.io_pg_offst	= (io_p2v(0x40000000) >> 18) & 0xfffc,
 	.boot_params	= 0xa0000100,
 	.map_io		= pxa_map_io,
 	.init_irq	= pxa25x_init_irq,
diff --git a/arch/arm/mach-pxa/e800.c b/arch/arm/mach-pxa/e800.c
index 8ea97bf..6ddd096 100644
--- a/arch/arm/mach-pxa/e800.c
+++ b/arch/arm/mach-pxa/e800.c
@@ -217,8 +217,6 @@ static void __init e800_init(void)
 
 MACHINE_START(E800, "Toshiba e800")
 	/* Maintainer: Ian Molton (spyro at f2s.com) */
-	.phys_io	= 0x40000000,
-	.io_pg_offst	= (io_p2v(0x40000000) >> 18) & 0xfffc,
 	.boot_params	= 0xa0000100,
 	.map_io		= pxa_map_io,
 	.init_irq	= pxa25x_init_irq,
diff --git a/arch/arm/mach-pxa/em-x270.c b/arch/arm/mach-pxa/em-x270.c
index 0517c17..8b257d1 100644
--- a/arch/arm/mach-pxa/em-x270.c
+++ b/arch/arm/mach-pxa/em-x270.c
@@ -1301,8 +1301,6 @@ static void __init em_x270_init(void)
 
 MACHINE_START(EM_X270, "Compulab EM-X270")
 	.boot_params	= 0xa0000100,
-	.phys_io	= 0x40000000,
-	.io_pg_offst	= (io_p2v(0x40000000) >> 18) & 0xfffc,
 	.map_io		= pxa_map_io,
 	.init_irq	= pxa27x_init_irq,
 	.timer		= &pxa_timer,
@@ -1311,8 +1309,6 @@ MACHINE_END
 
 MACHINE_START(EXEDA, "Compulab eXeda")
 	.boot_params	= 0xa0000100,
-	.phys_io	= 0x40000000,
-	.io_pg_offst	= (io_p2v(0x40000000) >> 18) & 0xfffc,
 	.map_io		= pxa_map_io,
 	.init_irq	= pxa27x_init_irq,
 	.timer		= &pxa_timer,
diff --git a/arch/arm/mach-pxa/ezx.c b/arch/arm/mach-pxa/ezx.c
index 626c82b..a257723 100644
--- a/arch/arm/mach-pxa/ezx.c
+++ b/arch/arm/mach-pxa/ezx.c
@@ -796,8 +796,6 @@ static void __init a780_init(void)
 }
 
 MACHINE_START(EZX_A780, "Motorola EZX A780")
-	.phys_io        = 0x40000000,
-	.io_pg_offst    = (io_p2v(0x40000000) >> 18) & 0xfffc,
 	.boot_params    = 0xa0000100,
 	.map_io         = pxa_map_io,
 	.init_irq       = pxa27x_init_irq,
@@ -862,8 +860,6 @@ static void __init e680_init(void)
 }
 
 MACHINE_START(EZX_E680, "Motorola EZX E680")
-	.phys_io        = 0x40000000,
-	.io_pg_offst    = (io_p2v(0x40000000) >> 18) & 0xfffc,
 	.boot_params    = 0xa0000100,
 	.map_io         = pxa_map_io,
 	.init_irq       = pxa27x_init_irq,
@@ -928,8 +924,6 @@ static void __init a1200_init(void)
 }
 
 MACHINE_START(EZX_A1200, "Motorola EZX A1200")
-	.phys_io        = 0x40000000,
-	.io_pg_offst    = (io_p2v(0x40000000) >> 18) & 0xfffc,
 	.boot_params    = 0xa0000100,
 	.map_io         = pxa_map_io,
 	.init_irq       = pxa27x_init_irq,
@@ -1120,8 +1114,6 @@ static void __init a910_init(void)
 }
 
 MACHINE_START(EZX_A910, "Motorola EZX A910")
-	.phys_io        = 0x40000000,
-	.io_pg_offst    = (io_p2v(0x40000000) >> 18) & 0xfffc,
 	.boot_params    = 0xa0000100,
 	.map_io         = pxa_map_io,
 	.init_irq       = pxa27x_init_irq,
@@ -1186,8 +1178,6 @@ static void __init e6_init(void)
 }
 
 MACHINE_START(EZX_E6, "Motorola EZX E6")
-	.phys_io        = 0x40000000,
-	.io_pg_offst    = (io_p2v(0x40000000) >> 18) & 0xfffc,
 	.boot_params    = 0xa0000100,
 	.map_io         = pxa_map_io,
 	.init_irq       = pxa27x_init_irq,
@@ -1226,8 +1216,6 @@ static void __init e2_init(void)
 }
 
 MACHINE_START(EZX_E2, "Motorola EZX E2")
-	.phys_io        = 0x40000000,
-	.io_pg_offst    = (io_p2v(0x40000000) >> 18) & 0xfffc,
 	.boot_params    = 0xa0000100,
 	.map_io         = pxa_map_io,
 	.init_irq       = pxa27x_init_irq,
diff --git a/arch/arm/mach-pxa/gumstix.c b/arch/arm/mach-pxa/gumstix.c
index 96c3451..1e2a9a1 100644
--- a/arch/arm/mach-pxa/gumstix.c
+++ b/arch/arm/mach-pxa/gumstix.c
@@ -224,9 +224,7 @@ static void __init gumstix_init(void)
 }
 
 MACHINE_START(GUMSTIX, "Gumstix")
-	.phys_io	= 0x40000000,
 	.boot_params	= 0xa0000100, /* match u-boot bi_boot_params */
-	.io_pg_offst	= (io_p2v(0x40000000) >> 18) & 0xfffc,
 	.map_io		= pxa_map_io,
 	.init_irq	= pxa25x_init_irq,
 	.timer		= &pxa_timer,
diff --git a/arch/arm/mach-pxa/h5000.c b/arch/arm/mach-pxa/h5000.c
index c1cab08..7057a1f 100644
--- a/arch/arm/mach-pxa/h5000.c
+++ b/arch/arm/mach-pxa/h5000.c
@@ -201,8 +201,6 @@ static void __init h5000_init(void)
 }
 
 MACHINE_START(H5400, "HP iPAQ H5000")
-	.phys_io = 0x40000000,
-	.io_pg_offst = (io_p2v(0x40000000) >> 18) & 0xfffc,
 	.boot_params = 0xa0000100,
 	.map_io = pxa_map_io,
 	.init_irq = pxa25x_init_irq,
diff --git a/arch/arm/mach-pxa/himalaya.c b/arch/arm/mach-pxa/himalaya.c
index f9a2e4b..01b7f07 100644
--- a/arch/arm/mach-pxa/himalaya.c
+++ b/arch/arm/mach-pxa/himalaya.c
@@ -159,8 +159,6 @@ static void __init himalaya_init(void)
 
 
 MACHINE_START(HIMALAYA, "HTC Himalaya")
-	.phys_io = 0x40000000,
-	.io_pg_offst = (io_p2v(0x40000000) >> 18) & 0xfffc,
 	.boot_params = 0xa0000100,
 	.map_io = pxa_map_io,
 	.init_irq = pxa25x_init_irq,
diff --git a/arch/arm/mach-pxa/hx4700.c b/arch/arm/mach-pxa/hx4700.c
index 848c861..c2eddee 100644
--- a/arch/arm/mach-pxa/hx4700.c
+++ b/arch/arm/mach-pxa/hx4700.c
@@ -870,8 +870,6 @@ static void __init hx4700_init(void)
 }
 
 MACHINE_START(H4700, "HP iPAQ HX4700")
-	.phys_io      = 0x40000000,
-	.io_pg_offst  = (io_p2v(0x40000000) >> 18) & 0xfffc,
 	.boot_params  = 0xa0000100,
 	.map_io       = pxa_map_io,
 	.init_irq     = pxa27x_init_irq,
diff --git a/arch/arm/mach-pxa/icontrol.c b/arch/arm/mach-pxa/icontrol.c
index 5ccb0ce..d51ee3d 100644
--- a/arch/arm/mach-pxa/icontrol.c
+++ b/arch/arm/mach-pxa/icontrol.c
@@ -191,9 +191,7 @@ static void __init icontrol_init(void)
 }
 
 MACHINE_START(ICONTROL, "iControl/SafeTcam boards using Embedian MXM-8x10 CoM")
-	.phys_io	= 0x40000000,
 	.boot_params	= 0xa0000100,
-	.io_pg_offst	= (io_p2v(0x40000000) >> 18) & 0xfffc,
 	.map_io		= pxa_map_io,
 	.init_irq	= pxa3xx_init_irq,
 	.timer		= &pxa_timer,
diff --git a/arch/arm/mach-pxa/idp.c b/arch/arm/mach-pxa/idp.c
index bc78c4d..e773dce 100644
--- a/arch/arm/mach-pxa/idp.c
+++ b/arch/arm/mach-pxa/idp.c
@@ -194,8 +194,6 @@ static void __init idp_map_io(void)
 
 MACHINE_START(PXA_IDP, "Vibren PXA255 IDP")
 	/* Maintainer: Vibren Technologies */
-	.phys_io	= 0x40000000,
-	.io_pg_offst	= (io_p2v(0x40000000) >> 18) & 0xfffc,
 	.map_io		= idp_map_io,
 	.init_irq	= pxa25x_init_irq,
 	.timer		= &pxa_timer,
diff --git a/arch/arm/mach-pxa/imote2.c b/arch/arm/mach-pxa/imote2.c
index 5161dca..7155ffb 100644
--- a/arch/arm/mach-pxa/imote2.c
+++ b/arch/arm/mach-pxa/imote2.c
@@ -580,8 +580,6 @@ static void __init imote2_init(void)
 }
 
 MACHINE_START(INTELMOTE2, "IMOTE 2")
-	.phys_io	= 0x40000000,
-	.io_pg_offst	= (io_p2v(0x40000000) >> 18) & 0xfffc,
 	.map_io		= pxa_map_io,
 	.init_irq	= pxa27x_init_irq,
 	.timer		= &pxa_timer,
diff --git a/arch/arm/mach-pxa/littleton.c b/arch/arm/mach-pxa/littleton.c
index 9b90461..887bd5c 100644
--- a/arch/arm/mach-pxa/littleton.c
+++ b/arch/arm/mach-pxa/littleton.c
@@ -437,9 +437,7 @@ static void __init littleton_init(void)
 }
 
 MACHINE_START(LITTLETON, "Marvell Form Factor Development Platform (aka Littleton)")
-	.phys_io	= 0x40000000,
 	.boot_params	= 0xa0000100,
-	.io_pg_offst	= (io_p2v(0x40000000) >> 18) & 0xfffc,
 	.map_io		= pxa_map_io,
 	.init_irq	= pxa3xx_init_irq,
 	.timer		= &pxa_timer,
diff --git a/arch/arm/mach-pxa/lpd270.c b/arch/arm/mach-pxa/lpd270.c
index d279507..584ab7c 100644
--- a/arch/arm/mach-pxa/lpd270.c
+++ b/arch/arm/mach-pxa/lpd270.c
@@ -505,8 +505,6 @@ static void __init lpd270_map_io(void)
 
 MACHINE_START(LOGICPD_PXA270, "LogicPD PXA270 Card Engine")
 	/* Maintainer: Peter Barada */
-	.phys_io	= 0x40000000,
-	.io_pg_offst	= (io_p2v(0x40000000) >> 18) & 0xfffc,
 	.boot_params	= 0xa0000100,
 	.map_io		= lpd270_map_io,
 	.init_irq	= lpd270_init_irq,
diff --git a/arch/arm/mach-pxa/lubbock.c b/arch/arm/mach-pxa/lubbock.c
index 330c328..cf8d0c9 100644
--- a/arch/arm/mach-pxa/lubbock.c
+++ b/arch/arm/mach-pxa/lubbock.c
@@ -557,8 +557,6 @@ static void __init lubbock_map_io(void)
 
 MACHINE_START(LUBBOCK, "Intel DBPXA250 Development Platform (aka Lubbock)")
 	/* Maintainer: MontaVista Software Inc. */
-	.phys_io	= 0x40000000,
-	.io_pg_offst	= (io_p2v(0x40000000) >> 18) & 0xfffc,
 	.map_io		= lubbock_map_io,
 	.init_irq	= lubbock_init_irq,
 	.timer		= &pxa_timer,
diff --git a/arch/arm/mach-pxa/magician.c b/arch/arm/mach-pxa/magician.c
index e81dd0c..1018b62 100644
--- a/arch/arm/mach-pxa/magician.c
+++ b/arch/arm/mach-pxa/magician.c
@@ -764,8 +764,6 @@ static void __init magician_init(void)
 
 
 MACHINE_START(MAGICIAN, "HTC Magician")
-	.phys_io = 0x40000000,
-	.io_pg_offst = (io_p2v(0x40000000) >> 18) & 0xfffc,
 	.boot_params = 0xa0000100,
 	.map_io = pxa_map_io,
 	.init_irq = pxa27x_init_irq,
diff --git a/arch/arm/mach-pxa/mainstone.c b/arch/arm/mach-pxa/mainstone.c
index 5543c64..0165ccb 100644
--- a/arch/arm/mach-pxa/mainstone.c
+++ b/arch/arm/mach-pxa/mainstone.c
@@ -624,9 +624,7 @@ static void __init mainstone_map_io(void)
 
 MACHINE_START(MAINSTONE, "Intel HCDDBBVA0 Development Platform (aka Mainstone)")
 	/* Maintainer: MontaVista Software Inc. */
-	.phys_io	= 0x40000000,
 	.boot_params	= 0xa0000100,	/* BLOB boot parameter setting */
-	.io_pg_offst	= (io_p2v(0x40000000) >> 18) & 0xfffc,
 	.map_io		= mainstone_map_io,
 	.init_irq	= mainstone_init_irq,
 	.timer		= &pxa_timer,
diff --git a/arch/arm/mach-pxa/mioa701.c b/arch/arm/mach-pxa/mioa701.c
index fa6a708..e86a317 100644
--- a/arch/arm/mach-pxa/mioa701.c
+++ b/arch/arm/mach-pxa/mioa701.c
@@ -815,8 +815,6 @@ static void mioa701_machine_exit(void)
 }
 
 MACHINE_START(MIOA701, "MIO A701")
-	.phys_io	= 0x40000000,
-	.io_pg_offst	= (io_p2v(0x40000000) >> 18) & 0xfffc,
 	.boot_params	= 0xa0000100,
 	.map_io		= &pxa_map_io,
 	.init_irq	= &pxa27x_init_irq,
diff --git a/arch/arm/mach-pxa/mp900.c b/arch/arm/mach-pxa/mp900.c
index 6d45039..116167a 100644
--- a/arch/arm/mach-pxa/mp900.c
+++ b/arch/arm/mach-pxa/mp900.c
@@ -92,9 +92,7 @@ static void __init mp900c_init(void)
 
 /* Maintainer - Michael Petchkovsky <mkpetch@internode.on.net> */
 MACHINE_START(NEC_MP900, "MobilePro900/C")
-	.phys_io	= 0x40000000,
 	.boot_params	= 0xa0220100,
-	.io_pg_offst	= (io_p2v(0x40000000) >> 18) & 0xfffc,
 	.timer		= &pxa_timer,
 	.map_io		= pxa_map_io,
 	.init_irq	= pxa25x_init_irq,
diff --git a/arch/arm/mach-pxa/palmld.c b/arch/arm/mach-pxa/palmld.c
index 1963819..b8b6656 100644
--- a/arch/arm/mach-pxa/palmld.c
+++ b/arch/arm/mach-pxa/palmld.c
@@ -527,8 +527,6 @@ static void __init palmld_init(void)
 }
 
 MACHINE_START(PALMLD, "Palm LifeDrive")
-	.phys_io	= PALMLD_PHYS_IO_START,
-	.io_pg_offst	= (io_p2v(0x40000000) >> 18) & 0xfffc,
 	.boot_params	= 0xa0000100,
 	.map_io		= palmld_map_io,
 	.init_irq	= pxa27x_init_irq,
diff --git a/arch/arm/mach-pxa/palmt5.c b/arch/arm/mach-pxa/palmt5.c
index 5305a39..89441be 100644
--- a/arch/arm/mach-pxa/palmt5.c
+++ b/arch/arm/mach-pxa/palmt5.c
@@ -417,8 +417,6 @@ static void __init palmt5_init(void)
 }
 
 MACHINE_START(PALMT5, "Palm Tungsten|T5")
-	.phys_io	= PALMT5_PHYS_IO_START,
-	.io_pg_offst	= (io_p2v(0x40000000) >> 18) & 0xfffc,
 	.boot_params	= 0xa0000100,
 	.map_io		= pxa_map_io,
 	.init_irq	= pxa27x_init_irq,
diff --git a/arch/arm/mach-pxa/palmtc.c b/arch/arm/mach-pxa/palmtc.c
index ce1104d..2131d58 100644
--- a/arch/arm/mach-pxa/palmtc.c
+++ b/arch/arm/mach-pxa/palmtc.c
@@ -412,9 +412,7 @@ static void __init palmtc_init(void)
 };
 
 MACHINE_START(PALMTC, "Palm Tungsten|C")
-	.phys_io	= 0x40000000,
 	.boot_params 	= 0xa0000100,
-	.io_pg_offst	= (io_p2v(0x40000000) >> 18) & 0xfffc,
 	.map_io		= pxa_map_io,
 	.init_irq	= pxa25x_init_irq,
 	.timer		= &pxa_timer,
diff --git a/arch/arm/mach-pxa/palmte2.c b/arch/arm/mach-pxa/palmte2.c
index 3d284ff..c315742 100644
--- a/arch/arm/mach-pxa/palmte2.c
+++ b/arch/arm/mach-pxa/palmte2.c
@@ -369,8 +369,6 @@ static void __init palmte2_init(void)
 }
 
 MACHINE_START(PALMTE2, "Palm Tungsten|E2")
-	.phys_io	= 0x40000000,
-	.io_pg_offst	= (io_p2v(0x40000000) >> 18) & 0xfffc,
 	.boot_params	= 0xa0000100,
 	.map_io		= pxa_map_io,
 	.init_irq	= pxa25x_init_irq,
diff --git a/arch/arm/mach-pxa/palmtreo.c b/arch/arm/mach-pxa/palmtreo.c
index d8b4469..d44b6a1 100644
--- a/arch/arm/mach-pxa/palmtreo.c
+++ b/arch/arm/mach-pxa/palmtreo.c
@@ -664,8 +664,6 @@ static void __init treo680_init(void)
 }
 
 MACHINE_START(TREO680, "Palm Treo 680")
-	.phys_io        = TREO_PHYS_IO_START,
-	.io_pg_offst    = io_p2v(0x40000000),
 	.boot_params    = 0xa0000100,
 	.map_io         = pxa_map_io,
 	.init_irq       = pxa27x_init_irq,
@@ -687,8 +685,6 @@ static void __init centro_init(void)
 }
 
 MACHINE_START(CENTRO, "Palm Centro 685")
-	.phys_io        = TREO_PHYS_IO_START,
-	.io_pg_offst    = io_p2v(0x40000000),
 	.boot_params    = 0xa0000100,
 	.map_io         = pxa_map_io,
 	.init_irq       = pxa27x_init_irq,
diff --git a/arch/arm/mach-pxa/palmtx.c b/arch/arm/mach-pxa/palmtx.c
index ecc1a40..e272e64 100644
--- a/arch/arm/mach-pxa/palmtx.c
+++ b/arch/arm/mach-pxa/palmtx.c
@@ -568,8 +568,6 @@ static void __init palmtx_init(void)
 }
 
 MACHINE_START(PALMTX, "Palm T|X")
-	.phys_io	= PALMTX_PHYS_IO_START,
-	.io_pg_offst	= io_p2v(0x40000000),
 	.boot_params	= 0xa0000100,
 	.map_io		= palmtx_map_io,
 	.init_irq	= pxa27x_init_irq,
diff --git a/arch/arm/mach-pxa/palmz72.c b/arch/arm/mach-pxa/palmz72.c
index 3a7925c..76426f9 100644
--- a/arch/arm/mach-pxa/palmz72.c
+++ b/arch/arm/mach-pxa/palmz72.c
@@ -489,8 +489,6 @@ static void __init palmz72_init(void)
 }
 
 MACHINE_START(PALMZ72, "Palm Zire72")
-	.phys_io	= 0x40000000,
-	.io_pg_offst	= io_p2v(0x40000000),
 	.boot_params	= 0xa0000100,
 	.map_io		= pxa_map_io,
 	.init_irq	= pxa27x_init_irq,
diff --git a/arch/arm/mach-pxa/pcm027.c b/arch/arm/mach-pxa/pcm027.c
index 2190af0..78cf961 100644
--- a/arch/arm/mach-pxa/pcm027.c
+++ b/arch/arm/mach-pxa/pcm027.c
@@ -259,8 +259,6 @@ static void __init pcm027_map_io(void)
 MACHINE_START(PCM027, "Phytec Messtechnik GmbH phyCORE-PXA270")
 	/* Maintainer: Pengutronix */
 	.boot_params	= 0xa0000100,
-	.phys_io	= 0x40000000,
-	.io_pg_offst	= (io_p2v(0x40000000) >> 18) & 0xfffc,
 	.map_io		= pcm027_map_io,
 	.init_irq	= pxa27x_init_irq,
 	.timer		= &pxa_timer,
diff --git a/arch/arm/mach-pxa/poodle.c b/arch/arm/mach-pxa/poodle.c
index f4abdaa..ce12edf 100644
--- a/arch/arm/mach-pxa/poodle.c
+++ b/arch/arm/mach-pxa/poodle.c
@@ -468,8 +468,6 @@ static void __init fixup_poodle(struct machine_desc *desc,
 }
 
 MACHINE_START(POODLE, "SHARP Poodle")
-	.phys_io	= 0x40000000,
-	.io_pg_offst	= (io_p2v(0x40000000) >> 18) & 0xfffc,
 	.fixup		= fixup_poodle,
 	.map_io		= pxa_map_io,
 	.init_irq	= pxa25x_init_irq,
diff --git a/arch/arm/mach-pxa/raumfeld.c b/arch/arm/mach-pxa/raumfeld.c
index d4b61b3..b995207 100644
--- a/arch/arm/mach-pxa/raumfeld.c
+++ b/arch/arm/mach-pxa/raumfeld.c
@@ -1070,8 +1070,6 @@ static void __init raumfeld_speaker_init(void)
 
 #ifdef CONFIG_MACH_RAUMFELD_RC
 MACHINE_START(RAUMFELD_RC, "Raumfeld Controller")
-	.phys_io	= 0x40000000,
-	.io_pg_offst	= (io_p2v(0x40000000) >> 18) & 0xfffc,
 	.boot_params	= RAUMFELD_SDRAM_BASE + 0x100,
 	.init_machine	= raumfeld_controller_init,
 	.map_io		= pxa_map_io,
@@ -1082,8 +1080,6 @@ MACHINE_END
 
 #ifdef CONFIG_MACH_RAUMFELD_CONNECTOR
 MACHINE_START(RAUMFELD_CONNECTOR, "Raumfeld Connector")
-	.phys_io	= 0x40000000,
-	.io_pg_offst	= (io_p2v(0x40000000) >> 18) & 0xfffc,
 	.boot_params	= RAUMFELD_SDRAM_BASE + 0x100,
 	.init_machine	= raumfeld_connector_init,
 	.map_io		= pxa_map_io,
@@ -1094,8 +1090,6 @@ MACHINE_END
 
 #ifdef CONFIG_MACH_RAUMFELD_SPEAKER
 MACHINE_START(RAUMFELD_SPEAKER, "Raumfeld Speaker")
-	.phys_io	= 0x40000000,
-	.io_pg_offst	= (io_p2v(0x40000000) >> 18) & 0xfffc,
 	.boot_params	= RAUMFELD_SDRAM_BASE + 0x100,
 	.init_machine	= raumfeld_speaker_init,
 	.map_io		= pxa_map_io,
diff --git a/arch/arm/mach-pxa/saar.c b/arch/arm/mach-pxa/saar.c
index 115b6f2..4b521e0 100644
--- a/arch/arm/mach-pxa/saar.c
+++ b/arch/arm/mach-pxa/saar.c
@@ -596,9 +596,7 @@ static void __init saar_init(void)
 
 MACHINE_START(SAAR, "PXA930 Handheld Platform (aka SAAR)")
 	/* Maintainer: Eric Miao <eric.miao@marvell.com> */
-	.phys_io        = 0x40000000,
 	.boot_params    = 0xa0000100,
-	.io_pg_offst    = (io_p2v(0x40000000) >> 18) & 0xfffc,
 	.map_io         = pxa_map_io,
 	.init_irq       = pxa3xx_init_irq,
 	.timer          = &pxa_timer,
diff --git a/arch/arm/mach-pxa/spitz.c b/arch/arm/mach-pxa/spitz.c
index c1048a3..a775378 100644
--- a/arch/arm/mach-pxa/spitz.c
+++ b/arch/arm/mach-pxa/spitz.c
@@ -853,8 +853,6 @@ static void __init fixup_spitz(struct machine_desc *desc,
 
 #ifdef CONFIG_MACH_SPITZ
 MACHINE_START(SPITZ, "SHARP Spitz")
-	.phys_io	= 0x40000000,
-	.io_pg_offst	= (io_p2v(0x40000000) >> 18) & 0xfffc,
 	.fixup		= fixup_spitz,
 	.map_io		= pxa_map_io,
 	.init_irq	= pxa27x_init_irq,
@@ -865,8 +863,6 @@ MACHINE_END
 
 #ifdef CONFIG_MACH_BORZOI
 MACHINE_START(BORZOI, "SHARP Borzoi")
-	.phys_io	= 0x40000000,
-	.io_pg_offst	= (io_p2v(0x40000000) >> 18) & 0xfffc,
 	.fixup		= fixup_spitz,
 	.map_io		= pxa_map_io,
 	.init_irq	= pxa27x_init_irq,
@@ -877,8 +873,6 @@ MACHINE_END
 
 #ifdef CONFIG_MACH_AKITA
 MACHINE_START(AKITA, "SHARP Akita")
-	.phys_io	= 0x40000000,
-	.io_pg_offst	= (io_p2v(0x40000000) >> 18) & 0xfffc,
 	.fixup		= fixup_spitz,
 	.map_io		= pxa_map_io,
 	.init_irq	= pxa27x_init_irq,
diff --git a/arch/arm/mach-pxa/stargate2.c b/arch/arm/mach-pxa/stargate2.c
index af40d2a..3571c06 100644
--- a/arch/arm/mach-pxa/stargate2.c
+++ b/arch/arm/mach-pxa/stargate2.c
@@ -782,8 +782,6 @@ static void __init stargate2_init(void)
 }
 
 MACHINE_START(STARGATE2, "Stargate 2")
-	.phys_io = 0x40000000,
-	.io_pg_offst = (io_p2v(0x40000000) >> 18) & 0xfffc,
 	.map_io = pxa_map_io,
 	.init_irq = pxa27x_init_irq,
 	.timer = &pxa_timer,
diff --git a/arch/arm/mach-pxa/tavorevb.c b/arch/arm/mach-pxa/tavorevb.c
index f02dcb5..5ac6e09 100644
--- a/arch/arm/mach-pxa/tavorevb.c
+++ b/arch/arm/mach-pxa/tavorevb.c
@@ -489,9 +489,7 @@ static void __init tavorevb_init(void)
 
 MACHINE_START(TAVOREVB, "PXA930 Evaluation Board (aka TavorEVB)")
 	/* Maintainer: Eric Miao <eric.miao@marvell.com> */
-	.phys_io        = 0x40000000,
 	.boot_params    = 0xa0000100,
-	.io_pg_offst    = (io_p2v(0x40000000) >> 18) & 0xfffc,
 	.map_io         = pxa_map_io,
 	.init_irq       = pxa3xx_init_irq,
 	.timer          = &pxa_timer,
diff --git a/arch/arm/mach-pxa/tosa.c b/arch/arm/mach-pxa/tosa.c
index 7512b82..4c28f31 100644
--- a/arch/arm/mach-pxa/tosa.c
+++ b/arch/arm/mach-pxa/tosa.c
@@ -953,8 +953,6 @@ static void __init fixup_tosa(struct machine_desc *desc,
 }
 
 MACHINE_START(TOSA, "SHARP Tosa")
-	.phys_io	= 0x40000000,
-	.io_pg_offst	= (io_p2v(0x40000000) >> 18) & 0xfffc,
 	.fixup          = fixup_tosa,
 	.map_io         = pxa_map_io,
 	.init_irq       = pxa25x_init_irq,
diff --git a/arch/arm/mach-pxa/trizeps4.c b/arch/arm/mach-pxa/trizeps4.c
index 6968911..dc82fba 100644
--- a/arch/arm/mach-pxa/trizeps4.c
+++ b/arch/arm/mach-pxa/trizeps4.c
@@ -559,8 +559,6 @@ static void __init trizeps4_map_io(void)
 
 MACHINE_START(TRIZEPS4, "Keith und Koep Trizeps IV module")
 	/* MAINTAINER("J??rgen Schindele") */
-	.phys_io	= 0x40000000,
-	.io_pg_offst	= (io_p2v(0x40000000) >> 18) & 0xfffc,
 	.boot_params	= TRIZEPS4_SDRAM_BASE + 0x100,
 	.init_machine	= trizeps4_init,
 	.map_io		= trizeps4_map_io,
@@ -570,8 +568,6 @@ MACHINE_END
 
 MACHINE_START(TRIZEPS4WL, "Keith und Koep Trizeps IV-WL module")
 	/* MAINTAINER("J??rgen Schindele") */
-	.phys_io	= 0x40000000,
-	.io_pg_offst	= (io_p2v(0x40000000) >> 18) & 0xfffc,
 	.boot_params	= TRIZEPS4_SDRAM_BASE + 0x100,
 	.init_machine	= trizeps4_init,
 	.map_io		= trizeps4_map_io,
diff --git a/arch/arm/mach-pxa/viper.c b/arch/arm/mach-pxa/viper.c
index e90114a..438fc9a 100644
--- a/arch/arm/mach-pxa/viper.c
+++ b/arch/arm/mach-pxa/viper.c
@@ -992,8 +992,6 @@ static void __init viper_map_io(void)
 
 MACHINE_START(VIPER, "Arcom/Eurotech VIPER SBC")
 	/* Maintainer: Marc Zyngier <maz@misterjones.org> */
-	.phys_io	= 0x40000000,
-	.io_pg_offst	= (io_p2v(0x40000000) >> 18) & 0xfffc,
 	.boot_params	= 0xa0000100,
 	.map_io		= viper_map_io,
 	.init_irq	= viper_init_irq,
diff --git a/arch/arm/mach-pxa/vpac270.c b/arch/arm/mach-pxa/vpac270.c
index 9884fa9..3b99198 100644
--- a/arch/arm/mach-pxa/vpac270.c
+++ b/arch/arm/mach-pxa/vpac270.c
@@ -605,8 +605,6 @@ static void __init vpac270_init(void)
 }
 
 MACHINE_START(VPAC270, "Voipac PXA270")
-	.phys_io	= 0x40000000,
-	.io_pg_offst	= (io_p2v(0x40000000) >> 18) & 0xfffc,
 	.boot_params	= 0xa0000100,
 	.map_io		= pxa_map_io,
 	.init_irq	= pxa27x_init_irq,
diff --git a/arch/arm/mach-pxa/xcep.c b/arch/arm/mach-pxa/xcep.c
index d3b4e3f..3260ce7 100644
--- a/arch/arm/mach-pxa/xcep.c
+++ b/arch/arm/mach-pxa/xcep.c
@@ -181,8 +181,6 @@ static void __init xcep_init(void)
 }
 
 MACHINE_START(XCEP, "Iskratel XCEP")
-	.phys_io	= 0x40000000,
-	.io_pg_offst	= (io_p2v(0x40000000) >> 18) & 0xfffc,
 	.boot_params	= 0xa0000100,
 	.init_machine	= xcep_init,
 	.map_io		= pxa_map_io,
diff --git a/arch/arm/mach-pxa/z2.c b/arch/arm/mach-pxa/z2.c
index d303c69..2ab690f 100644
--- a/arch/arm/mach-pxa/z2.c
+++ b/arch/arm/mach-pxa/z2.c
@@ -593,9 +593,7 @@ static void __init z2_init(void)
 }
 
 MACHINE_START(ZIPIT2, "Zipit Z2")
-	.phys_io	= 0x40000000,
 	.boot_params	= 0xa0000100,
-	.io_pg_offst	= (io_p2v(0x40000000) >> 18) & 0xfffc,
 	.map_io		= pxa_map_io,
 	.init_irq	= pxa27x_init_irq,
 	.timer		= &pxa_timer,
diff --git a/arch/arm/mach-pxa/zeus.c b/arch/arm/mach-pxa/zeus.c
index 03b9cb9..f77fb8d 100644
--- a/arch/arm/mach-pxa/zeus.c
+++ b/arch/arm/mach-pxa/zeus.c
@@ -900,8 +900,6 @@ static void __init zeus_map_io(void)
 
 MACHINE_START(ARCOM_ZEUS, "Arcom/Eurotech ZEUS")
 	/* Maintainer: Marc Zyngier <maz@misterjones.org> */
-	.phys_io	= 0x40000000,
-	.io_pg_offst	= ((io_p2v(0x40000000) >> 18) & 0xfffc),
 	.boot_params	= 0xa0000100,
 	.map_io		= zeus_map_io,
 	.init_irq	= zeus_init_irq,
diff --git a/arch/arm/mach-pxa/zylonite.c b/arch/arm/mach-pxa/zylonite.c
index c479cbe..06e0e83 100644
--- a/arch/arm/mach-pxa/zylonite.c
+++ b/arch/arm/mach-pxa/zylonite.c
@@ -411,9 +411,7 @@ static void __init zylonite_init(void)
 }
 
 MACHINE_START(ZYLONITE, "PXA3xx Platform Development Kit (aka Zylonite)")
-	.phys_io	= 0x40000000,
 	.boot_params	= 0xa0000100,
-	.io_pg_offst	= (io_p2v(0x40000000) >> 18) & 0xfffc,
 	.map_io		= pxa_map_io,
 	.init_irq	= pxa3xx_init_irq,
 	.timer		= &pxa_timer,
diff --git a/arch/arm/mach-realview/realview_eb.c b/arch/arm/mach-realview/realview_eb.c
index 4425018..c978f56 100644
--- a/arch/arm/mach-realview/realview_eb.c
+++ b/arch/arm/mach-realview/realview_eb.c
@@ -458,8 +458,6 @@ static void __init realview_eb_init(void)
 
 MACHINE_START(REALVIEW_EB, "ARM-RealView EB")
 	/* Maintainer: ARM Ltd/Deep Blue Solutions Ltd */
-	.phys_io	= REALVIEW_EB_UART0_BASE & SECTION_MASK,
-	.io_pg_offst	= (IO_ADDRESS(REALVIEW_EB_UART0_BASE) >> 18) & 0xfffc,
 	.boot_params	= PHYS_OFFSET + 0x00000100,
 	.fixup		= realview_fixup,
 	.map_io		= realview_eb_map_io,
diff --git a/arch/arm/mach-realview/realview_pb1176.c b/arch/arm/mach-realview/realview_pb1176.c
index 099a1f1..fc7e100 100644
--- a/arch/arm/mach-realview/realview_pb1176.c
+++ b/arch/arm/mach-realview/realview_pb1176.c
@@ -352,8 +352,6 @@ static void __init realview_pb1176_init(void)
 
 MACHINE_START(REALVIEW_PB1176, "ARM-RealView PB1176")
 	/* Maintainer: ARM Ltd/Deep Blue Solutions Ltd */
-	.phys_io	= REALVIEW_PB1176_UART0_BASE & SECTION_MASK,
-	.io_pg_offst	= (IO_ADDRESS(REALVIEW_PB1176_UART0_BASE) >> 18) & 0xfffc,
 	.boot_params	= PHYS_OFFSET + 0x00000100,
 	.fixup		= realview_pb1176_fixup,
 	.map_io		= realview_pb1176_map_io,
diff --git a/arch/arm/mach-realview/realview_pb11mp.c b/arch/arm/mach-realview/realview_pb11mp.c
index 0e07a5c..ab0cf55 100644
--- a/arch/arm/mach-realview/realview_pb11mp.c
+++ b/arch/arm/mach-realview/realview_pb11mp.c
@@ -374,8 +374,6 @@ static void __init realview_pb11mp_init(void)
 
 MACHINE_START(REALVIEW_PB11MP, "ARM-RealView PB11MPCore")
 	/* Maintainer: ARM Ltd/Deep Blue Solutions Ltd */
-	.phys_io	= REALVIEW_PB11MP_UART0_BASE & SECTION_MASK,
-	.io_pg_offst	= (IO_ADDRESS(REALVIEW_PB11MP_UART0_BASE) >> 18) & 0xfffc,
 	.boot_params	= PHYS_OFFSET + 0x00000100,
 	.fixup		= realview_fixup,
 	.map_io		= realview_pb11mp_map_io,
diff --git a/arch/arm/mach-realview/realview_pba8.c b/arch/arm/mach-realview/realview_pba8.c
index ac2f06f..ab57756 100644
--- a/arch/arm/mach-realview/realview_pba8.c
+++ b/arch/arm/mach-realview/realview_pba8.c
@@ -324,8 +324,6 @@ static void __init realview_pba8_init(void)
 
 MACHINE_START(REALVIEW_PBA8, "ARM-RealView PB-A8")
 	/* Maintainer: ARM Ltd/Deep Blue Solutions Ltd */
-	.phys_io	= REALVIEW_PBA8_UART0_BASE & SECTION_MASK,
-	.io_pg_offst	= (IO_ADDRESS(REALVIEW_PBA8_UART0_BASE) >> 18) & 0xfffc,
 	.boot_params	= PHYS_OFFSET + 0x00000100,
 	.fixup		= realview_fixup,
 	.map_io		= realview_pba8_map_io,
diff --git a/arch/arm/mach-realview/realview_pbx.c b/arch/arm/mach-realview/realview_pbx.c
index 08fd683..fc5b1e6 100644
--- a/arch/arm/mach-realview/realview_pbx.c
+++ b/arch/arm/mach-realview/realview_pbx.c
@@ -410,8 +410,6 @@ static void __init realview_pbx_init(void)
 
 MACHINE_START(REALVIEW_PBX, "ARM-RealView PBX")
 	/* Maintainer: ARM Ltd/Deep Blue Solutions Ltd */
-	.phys_io	= REALVIEW_PBX_UART0_BASE & SECTION_MASK,
-	.io_pg_offst	= (IO_ADDRESS(REALVIEW_PBX_UART0_BASE) >> 18) & 0xfffc,
 	.boot_params	= PHYS_OFFSET + 0x00000100,
 	.fixup		= realview_pbx_fixup,
 	.map_io		= realview_pbx_map_io,
diff --git a/arch/arm/mach-rpc/riscpc.c b/arch/arm/mach-rpc/riscpc.c
index c7fc01e..580b3c7 100644
--- a/arch/arm/mach-rpc/riscpc.c
+++ b/arch/arm/mach-rpc/riscpc.c
@@ -218,8 +218,6 @@ extern struct sys_timer ioc_timer;
 
 MACHINE_START(RISCPC, "Acorn-RiscPC")
 	/* Maintainer: Russell King */
-	.phys_io	= 0x03000000,
-	.io_pg_offst	= ((0xe0000000) >> 18) & 0xfffc,
 	.boot_params	= 0x10000100,
 	.reserve_lp0	= 1,
 	.reserve_lp1	= 1,
diff --git a/arch/arm/mach-s3c2410/mach-amlm5900.c b/arch/arm/mach-s3c2410/mach-amlm5900.c
index 34fc05a..44440cb 100644
--- a/arch/arm/mach-s3c2410/mach-amlm5900.c
+++ b/arch/arm/mach-s3c2410/mach-amlm5900.c
@@ -241,8 +241,6 @@ static void __init amlm5900_init(void)
 }
 
 MACHINE_START(AML_M5900, "AML_M5900")
-	.phys_io	= S3C2410_PA_UART,
-	.io_pg_offst	= (((u32)S3C24XX_VA_UART) >> 18) & 0xfffc,
 	.boot_params	= S3C2410_SDRAM_PA + 0x100,
 	.map_io		= amlm5900_map_io,
 	.init_irq	= s3c24xx_init_irq,
diff --git a/arch/arm/mach-s3c2410/mach-bast.c b/arch/arm/mach-s3c2410/mach-bast.c
index c1f90f6..2970ea9 100644
--- a/arch/arm/mach-s3c2410/mach-bast.c
+++ b/arch/arm/mach-s3c2410/mach-bast.c
@@ -664,8 +664,6 @@ static void __init bast_init(void)
 
 MACHINE_START(BAST, "Simtec-BAST")
 	/* Maintainer: Ben Dooks <ben@simtec.co.uk> */
-	.phys_io	= S3C2410_PA_UART,
-	.io_pg_offst	= (((u32)S3C24XX_VA_UART) >> 18) & 0xfffc,
 	.boot_params	= S3C2410_SDRAM_PA + 0x100,
 	.map_io		= bast_map_io,
 	.init_irq	= s3c24xx_init_irq,
diff --git a/arch/arm/mach-s3c2410/mach-h1940.c b/arch/arm/mach-s3c2410/mach-h1940.c
index 779b45b..a7ff116 100644
--- a/arch/arm/mach-s3c2410/mach-h1940.c
+++ b/arch/arm/mach-s3c2410/mach-h1940.c
@@ -342,8 +342,6 @@ static void __init h1940_init(void)
 
 MACHINE_START(H1940, "IPAQ-H1940")
 	/* Maintainer: Ben Dooks <ben-linux@fluff.org> */
-	.phys_io	= S3C2410_PA_UART,
-	.io_pg_offst	= (((u32)S3C24XX_VA_UART) >> 18) & 0xfffc,
 	.boot_params	= S3C2410_SDRAM_PA + 0x100,
 	.map_io		= h1940_map_io,
 	.init_irq	= h1940_init_irq,
diff --git a/arch/arm/mach-s3c2410/mach-n30.c b/arch/arm/mach-s3c2410/mach-n30.c
index 41f299d..271b9aa 100644
--- a/arch/arm/mach-s3c2410/mach-n30.c
+++ b/arch/arm/mach-s3c2410/mach-n30.c
@@ -605,8 +605,6 @@ MACHINE_START(N30, "Acer-N30")
 	/* Maintainer: Christer Weinigel <christer@weinigel.se>,
 				Ben Dooks <ben-linux@fluff.org>
 	*/
-	.phys_io	= S3C2410_PA_UART,
-	.io_pg_offst	= (((u32)S3C24XX_VA_UART) >> 18) & 0xfffc,
 	.boot_params	= S3C2410_SDRAM_PA + 0x100,
 	.timer		= &s3c24xx_timer,
 	.init_machine	= n30_init,
@@ -617,8 +615,6 @@ MACHINE_END
 MACHINE_START(N35, "Acer-N35")
 	/* Maintainer: Christer Weinigel <christer@weinigel.se>
 	*/
-	.phys_io	= S3C2410_PA_UART,
-	.io_pg_offst	= (((u32)S3C24XX_VA_UART) >> 18) & 0xfffc,
 	.boot_params	= S3C2410_SDRAM_PA + 0x100,
 	.timer		= &s3c24xx_timer,
 	.init_machine	= n30_init,
diff --git a/arch/arm/mach-s3c2410/mach-otom.c b/arch/arm/mach-s3c2410/mach-otom.c
index d8c7f2e..0aa16cd 100644
--- a/arch/arm/mach-s3c2410/mach-otom.c
+++ b/arch/arm/mach-s3c2410/mach-otom.c
@@ -116,8 +116,6 @@ static void __init otom11_init(void)
 
 MACHINE_START(OTOM, "Nex Vision - Otom 1.1")
 	/* Maintainer: Guillaume GOURAT <guillaume.gourat@nexvision.tv> */
-	.phys_io	= S3C2410_PA_UART,
-	.io_pg_offst	= (((u32)S3C24XX_VA_UART) >> 18) & 0xfffc,
 	.boot_params	= S3C2410_SDRAM_PA + 0x100,
 	.map_io		= otom11_map_io,
 	.init_machine	= otom11_init,
diff --git a/arch/arm/mach-s3c2410/mach-qt2410.c b/arch/arm/mach-s3c2410/mach-qt2410.c
index d0e87b6..e8f49fe 100644
--- a/arch/arm/mach-s3c2410/mach-qt2410.c
+++ b/arch/arm/mach-s3c2410/mach-qt2410.c
@@ -362,8 +362,6 @@ static void __init qt2410_machine_init(void)
 }
 
 MACHINE_START(QT2410, "QT2410")
-	.phys_io	= S3C2410_PA_UART,
-	.io_pg_offst	= (((u32)S3C24XX_VA_UART) >> 18) & 0xfffc,
 	.boot_params	= S3C2410_SDRAM_PA + 0x100,
 	.map_io		= qt2410_map_io,
 	.init_irq	= s3c24xx_init_irq,
diff --git a/arch/arm/mach-s3c2410/mach-smdk2410.c b/arch/arm/mach-s3c2410/mach-smdk2410.c
index 4522230..e17f033 100644
--- a/arch/arm/mach-s3c2410/mach-smdk2410.c
+++ b/arch/arm/mach-s3c2410/mach-smdk2410.c
@@ -111,8 +111,6 @@ static void __init smdk2410_init(void)
 MACHINE_START(SMDK2410, "SMDK2410") /* @TODO: request a new identifier and switch
 				    * to SMDK2410 */
 	/* Maintainer: Jonas Dietsche */
-	.phys_io	= S3C2410_PA_UART,
-	.io_pg_offst	= (((u32)S3C24XX_VA_UART) >> 18) & 0xfffc,
 	.boot_params	= S3C2410_SDRAM_PA + 0x100,
 	.map_io		= smdk2410_map_io,
 	.init_irq	= s3c24xx_init_irq,
diff --git a/arch/arm/mach-s3c2410/mach-tct_hammer.c b/arch/arm/mach-s3c2410/mach-tct_hammer.c
index 929164a..a15d062 100644
--- a/arch/arm/mach-s3c2410/mach-tct_hammer.c
+++ b/arch/arm/mach-s3c2410/mach-tct_hammer.c
@@ -152,8 +152,6 @@ static void __init tct_hammer_init(void)
 }
 
 MACHINE_START(TCT_HAMMER, "TCT_HAMMER")
-	.phys_io	= S3C2410_PA_UART,
-	.io_pg_offst	= (((u32)S3C24XX_VA_UART) >> 18) & 0xfffc,
 	.boot_params	= S3C2410_SDRAM_PA + 0x100,
 	.map_io		= tct_hammer_map_io,
 	.init_irq	= s3c24xx_init_irq,
diff --git a/arch/arm/mach-s3c2410/mach-vr1000.c b/arch/arm/mach-s3c2410/mach-vr1000.c
index d540d79..6ccce5a 100644
--- a/arch/arm/mach-s3c2410/mach-vr1000.c
+++ b/arch/arm/mach-s3c2410/mach-vr1000.c
@@ -400,8 +400,6 @@ static void __init vr1000_init(void)
 
 MACHINE_START(VR1000, "Thorcom-VR1000")
 	/* Maintainer: Ben Dooks <ben@simtec.co.uk> */
-	.phys_io	= S3C2410_PA_UART,
-	.io_pg_offst	= (((u32)S3C24XX_VA_UART) >> 18) & 0xfffc,
 	.boot_params	= S3C2410_SDRAM_PA + 0x100,
 	.map_io		= vr1000_map_io,
 	.init_machine	= vr1000_init,
diff --git a/arch/arm/mach-s3c2412/mach-jive.c b/arch/arm/mach-s3c2412/mach-jive.c
index 478f4b4..923e01b 100644
--- a/arch/arm/mach-s3c2412/mach-jive.c
+++ b/arch/arm/mach-s3c2412/mach-jive.c
@@ -675,8 +675,6 @@ static void __init jive_machine_init(void)
 
 MACHINE_START(JIVE, "JIVE")
 	/* Maintainer: Ben Dooks <ben-linux@fluff.org> */
-	.phys_io	= S3C2410_PA_UART,
-	.io_pg_offst	= (((u32)S3C24XX_VA_UART) >> 18) & 0xfffc,
 	.boot_params	= S3C2410_SDRAM_PA + 0x100,
 
 	.init_irq	= s3c24xx_init_irq,
diff --git a/arch/arm/mach-s3c2412/mach-smdk2413.c b/arch/arm/mach-s3c2412/mach-smdk2413.c
index ba93a35..7f35f1a 100644
--- a/arch/arm/mach-s3c2412/mach-smdk2413.c
+++ b/arch/arm/mach-s3c2412/mach-smdk2413.c
@@ -151,8 +151,6 @@ static void __init smdk2413_machine_init(void)
 
 MACHINE_START(S3C2413, "S3C2413")
 	/* Maintainer: Ben Dooks <ben-linux@fluff.org> */
-	.phys_io	= S3C2410_PA_UART,
-	.io_pg_offst	= (((u32)S3C24XX_VA_UART) >> 18) & 0xfffc,
 	.boot_params	= S3C2410_SDRAM_PA + 0x100,
 
 	.fixup		= smdk2413_fixup,
@@ -164,8 +162,6 @@ MACHINE_END
 
 MACHINE_START(SMDK2412, "SMDK2412")
 	/* Maintainer: Ben Dooks <ben-linux@fluff.org> */
-	.phys_io	= S3C2410_PA_UART,
-	.io_pg_offst	= (((u32)S3C24XX_VA_UART) >> 18) & 0xfffc,
 	.boot_params	= S3C2410_SDRAM_PA + 0x100,
 
 	.fixup		= smdk2413_fixup,
@@ -177,8 +173,6 @@ MACHINE_END
 
 MACHINE_START(SMDK2413, "SMDK2413")
 	/* Maintainer: Ben Dooks <ben-linux@fluff.org> */
-	.phys_io	= S3C2410_PA_UART,
-	.io_pg_offst	= (((u32)S3C24XX_VA_UART) >> 18) & 0xfffc,
 	.boot_params	= S3C2410_SDRAM_PA + 0x100,
 
 	.fixup		= smdk2413_fixup,
diff --git a/arch/arm/mach-s3c2412/mach-vstms.c b/arch/arm/mach-s3c2412/mach-vstms.c
index 3ca9265..ca1886a 100644
--- a/arch/arm/mach-s3c2412/mach-vstms.c
+++ b/arch/arm/mach-s3c2412/mach-vstms.c
@@ -157,8 +157,6 @@ static void __init vstms_init(void)
 }
 
 MACHINE_START(VSTMS, "VSTMS")
-	.phys_io	= S3C2410_PA_UART,
-	.io_pg_offst	= (((u32)S3C24XX_VA_UART) >> 18) & 0xfffc,
 	.boot_params	= S3C2410_SDRAM_PA + 0x100,
 
 	.fixup		= vstms_fixup,
diff --git a/arch/arm/mach-s3c2416/mach-smdk2416.c b/arch/arm/mach-s3c2416/mach-smdk2416.c
index 5fc3f67..7fc3664 100644
--- a/arch/arm/mach-s3c2416/mach-smdk2416.c
+++ b/arch/arm/mach-s3c2416/mach-smdk2416.c
@@ -195,8 +195,6 @@ static void __init smdk2416_machine_init(void)
 
 MACHINE_START(SMDK2416, "SMDK2416")
 	/* Maintainer: Yauhen Kharuzhy <jekhor@gmail.com> */
-	.phys_io	= S3C2410_PA_UART,
-	.io_pg_offst	= (((u32)S3C24XX_VA_UART) >> 18) & 0xfffc,
 	.boot_params	= S3C2410_SDRAM_PA + 0x100,
 
 	.init_irq	= s3c24xx_init_irq,
diff --git a/arch/arm/mach-s3c2440/mach-anubis.c b/arch/arm/mach-s3c2440/mach-anubis.c
index b73f78a..d708678 100644
--- a/arch/arm/mach-s3c2440/mach-anubis.c
+++ b/arch/arm/mach-s3c2440/mach-anubis.c
@@ -498,8 +498,6 @@ static void __init anubis_init(void)
 
 MACHINE_START(ANUBIS, "Simtec-Anubis")
 	/* Maintainer: Ben Dooks <ben@simtec.co.uk> */
-	.phys_io	= S3C2410_PA_UART,
-	.io_pg_offst	= (((u32)S3C24XX_VA_UART) >> 18) & 0xfffc,
 	.boot_params	= S3C2410_SDRAM_PA + 0x100,
 	.map_io		= anubis_map_io,
 	.init_machine	= anubis_init,
diff --git a/arch/arm/mach-s3c2440/mach-at2440evb.c b/arch/arm/mach-s3c2440/mach-at2440evb.c
index 8472579..e3810c8 100644
--- a/arch/arm/mach-s3c2440/mach-at2440evb.c
+++ b/arch/arm/mach-s3c2440/mach-at2440evb.c
@@ -233,8 +233,6 @@ static void __init at2440evb_init(void)
 
 
 MACHINE_START(AT2440EVB, "AT2440EVB")
-	.phys_io	= S3C2410_PA_UART,
-	.io_pg_offst	= (((u32)S3C24XX_VA_UART) >> 18) & 0xfffc,
 	.boot_params	= S3C2410_SDRAM_PA + 0x100,
 	.map_io		= at2440evb_map_io,
 	.init_machine	= at2440evb_init,
diff --git a/arch/arm/mach-s3c2440/mach-gta02.c b/arch/arm/mach-s3c2440/mach-gta02.c
index 9e39faa..a502f47 100644
--- a/arch/arm/mach-s3c2440/mach-gta02.c
+++ b/arch/arm/mach-s3c2440/mach-gta02.c
@@ -579,8 +579,6 @@ static void __init gta02_machine_init(void)
 
 MACHINE_START(NEO1973_GTA02, "GTA02")
 	/* Maintainer: Nelson Castillo <arhuaco@freaks-unidos.net> */
-	.phys_io	= S3C2410_PA_UART,
-	.io_pg_offst	= (((u32)S3C24XX_VA_UART) >> 18) & 0xfffc,
 	.boot_params	= S3C2410_SDRAM_PA + 0x100,
 	.map_io		= gta02_map_io,
 	.init_irq	= s3c24xx_init_irq,
diff --git a/arch/arm/mach-s3c2440/mach-mini2440.c b/arch/arm/mach-s3c2440/mach-mini2440.c
index a76bcda..f62bb4c 100644
--- a/arch/arm/mach-s3c2440/mach-mini2440.c
+++ b/arch/arm/mach-s3c2440/mach-mini2440.c
@@ -691,8 +691,6 @@ static void __init mini2440_init(void)
 
 MACHINE_START(MINI2440, "MINI2440")
 	/* Maintainer: Michel Pollet <buserror@gmail.com> */
-	.phys_io	= S3C2410_PA_UART,
-	.io_pg_offst	= (((u32)S3C24XX_VA_UART) >> 18) & 0xfffc,
 	.boot_params	= S3C2410_SDRAM_PA + 0x100,
 	.map_io		= mini2440_map_io,
 	.init_machine	= mini2440_init,
diff --git a/arch/arm/mach-s3c2440/mach-nexcoder.c b/arch/arm/mach-s3c2440/mach-nexcoder.c
index 3ff62de..37dd306 100644
--- a/arch/arm/mach-s3c2440/mach-nexcoder.c
+++ b/arch/arm/mach-s3c2440/mach-nexcoder.c
@@ -151,8 +151,6 @@ static void __init nexcoder_init(void)
 
 MACHINE_START(NEXCODER_2440, "NexVision - Nexcoder 2440")
 	/* Maintainer: Guillaume GOURAT <guillaume.gourat@nexvision.tv> */
-	.phys_io	= S3C2410_PA_UART,
-	.io_pg_offst	= (((u32)S3C24XX_VA_UART) >> 18) & 0xfffc,
 	.boot_params	= S3C2410_SDRAM_PA + 0x100,
 	.map_io		= nexcoder_map_io,
 	.init_machine	= nexcoder_init,
diff --git a/arch/arm/mach-s3c2440/mach-osiris.c b/arch/arm/mach-s3c2440/mach-osiris.c
index 319458d..14dc678 100644
--- a/arch/arm/mach-s3c2440/mach-osiris.c
+++ b/arch/arm/mach-s3c2440/mach-osiris.c
@@ -455,8 +455,6 @@ static void __init osiris_init(void)
 
 MACHINE_START(OSIRIS, "Simtec-OSIRIS")
 	/* Maintainer: Ben Dooks <ben@simtec.co.uk> */
-	.phys_io	= S3C2410_PA_UART,
-	.io_pg_offst	= (((u32)S3C24XX_VA_UART) >> 18) & 0xfffc,
 	.boot_params	= S3C2410_SDRAM_PA + 0x100,
 	.map_io		= osiris_map_io,
 	.init_irq	= s3c24xx_init_irq,
diff --git a/arch/arm/mach-s3c2440/mach-rx1950.c b/arch/arm/mach-s3c2440/mach-rx1950.c
index 8603b57..14739ee 100644
--- a/arch/arm/mach-s3c2440/mach-rx1950.c
+++ b/arch/arm/mach-s3c2440/mach-rx1950.c
@@ -572,8 +572,6 @@ static void __init rx1950_init_machine(void)
 
 MACHINE_START(RX1950, "HP iPAQ RX1950")
     /* Maintainers: Vasily Khoruzhick */
-    .phys_io = S3C2410_PA_UART,
-	.io_pg_offst = (((u32) S3C24XX_VA_UART) >> 18) & 0xfffc,
 	.boot_params = S3C2410_SDRAM_PA + 0x100,
 	.map_io = rx1950_map_io,
 	.init_irq = s3c24xx_init_irq,
diff --git a/arch/arm/mach-s3c2440/mach-rx3715.c b/arch/arm/mach-s3c2440/mach-rx3715.c
index d2946de..0b1f936 100644
--- a/arch/arm/mach-s3c2440/mach-rx3715.c
+++ b/arch/arm/mach-s3c2440/mach-rx3715.c
@@ -210,8 +210,6 @@ static void __init rx3715_init_machine(void)
 
 MACHINE_START(RX3715, "IPAQ-RX3715")
 	/* Maintainer: Ben Dooks <ben-linux@fluff.org> */
-	.phys_io	= S3C2410_PA_UART,
-	.io_pg_offst	= (((u32)S3C24XX_VA_UART) >> 18) & 0xfffc,
 	.boot_params	= S3C2410_SDRAM_PA + 0x100,
 	.map_io		= rx3715_map_io,
 	.init_irq	= rx3715_init_irq,
diff --git a/arch/arm/mach-s3c2440/mach-smdk2440.c b/arch/arm/mach-s3c2440/mach-smdk2440.c
index df83276..eedfe0f 100644
--- a/arch/arm/mach-s3c2440/mach-smdk2440.c
+++ b/arch/arm/mach-s3c2440/mach-smdk2440.c
@@ -175,8 +175,6 @@ static void __init smdk2440_machine_init(void)
 
 MACHINE_START(S3C2440, "SMDK2440")
 	/* Maintainer: Ben Dooks <ben-linux@fluff.org> */
-	.phys_io	= S3C2410_PA_UART,
-	.io_pg_offst	= (((u32)S3C24XX_VA_UART) >> 18) & 0xfffc,
 	.boot_params	= S3C2410_SDRAM_PA + 0x100,
 
 	.init_irq	= s3c24xx_init_irq,
diff --git a/arch/arm/mach-s3c2443/mach-smdk2443.c b/arch/arm/mach-s3c2443/mach-smdk2443.c
index 4c863d3..4337f0a 100644
--- a/arch/arm/mach-s3c2443/mach-smdk2443.c
+++ b/arch/arm/mach-s3c2443/mach-smdk2443.c
@@ -132,8 +132,6 @@ static void __init smdk2443_machine_init(void)
 
 MACHINE_START(SMDK2443, "SMDK2443")
 	/* Maintainer: Ben Dooks <ben-linux@fluff.org> */
-	.phys_io	= S3C2410_PA_UART,
-	.io_pg_offst	= (((u32)S3C24XX_VA_UART) >> 18) & 0xfffc,
 	.boot_params	= S3C2410_SDRAM_PA + 0x100,
 
 	.init_irq	= s3c24xx_init_irq,
diff --git a/arch/arm/mach-s3c64xx/mach-anw6410.c b/arch/arm/mach-s3c64xx/mach-anw6410.c
index 4a0bb24..88ed6bc 100644
--- a/arch/arm/mach-s3c64xx/mach-anw6410.c
+++ b/arch/arm/mach-s3c64xx/mach-anw6410.c
@@ -234,8 +234,6 @@ static void __init anw6410_machine_init(void)
 
 MACHINE_START(ANW6410, "A&W6410")
 	/* Maintainer: Kwangwoo Lee <kwangwoo.lee@gmail.com> */
-	.phys_io	= S3C_PA_UART & 0xfff00000,
-	.io_pg_offst	= (((u32)S3C_VA_UART) >> 18) & 0xfffc,
 	.boot_params	= S3C64XX_PA_SDRAM + 0x100,
 
 	.init_irq	= s3c6410_init_irq,
diff --git a/arch/arm/mach-s3c64xx/mach-hmt.c b/arch/arm/mach-s3c64xx/mach-hmt.c
index 187441a..762f0fe 100644
--- a/arch/arm/mach-s3c64xx/mach-hmt.c
+++ b/arch/arm/mach-s3c64xx/mach-hmt.c
@@ -266,8 +266,6 @@ static void __init hmt_machine_init(void)
 
 MACHINE_START(HMT, "Airgoo-HMT")
 	/* Maintainer: Peter Korsgaard <jacmet@sunsite.dk> */
-	.phys_io	= S3C_PA_UART & 0xfff00000,
-	.io_pg_offst	= (((u32)S3C_VA_UART) >> 18) & 0xfffc,
 	.boot_params	= S3C64XX_PA_SDRAM + 0x100,
 	.init_irq	= s3c6410_init_irq,
 	.map_io		= hmt_map_io,
diff --git a/arch/arm/mach-s3c64xx/mach-ncp.c b/arch/arm/mach-s3c64xx/mach-ncp.c
index bf65747..c498649 100644
--- a/arch/arm/mach-s3c64xx/mach-ncp.c
+++ b/arch/arm/mach-s3c64xx/mach-ncp.c
@@ -97,8 +97,6 @@ static void __init ncp_machine_init(void)
 
 MACHINE_START(NCP, "NCP")
 	/* Maintainer: Samsung Electronics */
-	.phys_io	= S3C_PA_UART & 0xfff00000,
-	.io_pg_offst	= (((u32)S3C_VA_UART) >> 18) & 0xfffc,
 	.boot_params	= S3C64XX_PA_SDRAM + 0x100,
 	.init_irq	= s3c6410_init_irq,
 	.map_io		= ncp_map_io,
diff --git a/arch/arm/mach-s3c64xx/mach-smartq5.c b/arch/arm/mach-s3c64xx/mach-smartq5.c
index 1d0326e..c38d04b 100644
--- a/arch/arm/mach-s3c64xx/mach-smartq5.c
+++ b/arch/arm/mach-s3c64xx/mach-smartq5.c
@@ -175,8 +175,6 @@ static void __init smartq5_machine_init(void)
 
 MACHINE_START(SMARTQ5, "SmartQ 5")
 	/* Maintainer: Maurus Cuelenaere <mcuelenaere AT gmail DOT com> */
-	.phys_io	= S3C_PA_UART & 0xfff00000,
-	.io_pg_offst	= (((u32)S3C_VA_UART) >> 18) & 0xfffc,
 	.boot_params	= S3C64XX_PA_SDRAM + 0x100,
 	.init_irq	= s3c6410_init_irq,
 	.map_io		= smartq_map_io,
diff --git a/arch/arm/mach-s3c64xx/mach-smartq7.c b/arch/arm/mach-s3c64xx/mach-smartq7.c
index e0bc78e..6e1bb0a 100644
--- a/arch/arm/mach-s3c64xx/mach-smartq7.c
+++ b/arch/arm/mach-s3c64xx/mach-smartq7.c
@@ -191,8 +191,6 @@ static void __init smartq7_machine_init(void)
 
 MACHINE_START(SMARTQ7, "SmartQ 7")
 	/* Maintainer: Maurus Cuelenaere <mcuelenaere AT gmail DOT com> */
-	.phys_io	= S3C_PA_UART & 0xfff00000,
-	.io_pg_offst	= (((u32)S3C_VA_UART) >> 18) & 0xfffc,
 	.boot_params	= S3C64XX_PA_SDRAM + 0x100,
 	.init_irq	= s3c6410_init_irq,
 	.map_io		= smartq_map_io,
diff --git a/arch/arm/mach-s3c64xx/mach-smdk6400.c b/arch/arm/mach-s3c64xx/mach-smdk6400.c
index 5991667..3cca642 100644
--- a/arch/arm/mach-s3c64xx/mach-smdk6400.c
+++ b/arch/arm/mach-s3c64xx/mach-smdk6400.c
@@ -85,8 +85,6 @@ static void __init smdk6400_machine_init(void)
 
 MACHINE_START(SMDK6400, "SMDK6400")
 	/* Maintainer: Ben Dooks <ben-linux@fluff.org> */
-	.phys_io	= S3C_PA_UART & 0xfff00000,
-	.io_pg_offst	= (((u32)S3C_VA_UART) >> 18) & 0xfffc,
 	.boot_params	= S3C64XX_PA_SDRAM + 0x100,
 
 	.init_irq	= s3c6400_init_irq,
diff --git a/arch/arm/mach-s3c64xx/mach-smdk6410.c b/arch/arm/mach-s3c64xx/mach-smdk6410.c
index d9a0355..1bfa3d8 100644
--- a/arch/arm/mach-s3c64xx/mach-smdk6410.c
+++ b/arch/arm/mach-s3c64xx/mach-smdk6410.c
@@ -670,8 +670,6 @@ static void __init smdk6410_machine_init(void)
 
 MACHINE_START(SMDK6410, "SMDK6410")
 	/* Maintainer: Ben Dooks <ben-linux@fluff.org> */
-	.phys_io	= S3C_PA_UART & 0xfff00000,
-	.io_pg_offst	= (((u32)S3C_VA_UART) >> 18) & 0xfffc,
 	.boot_params	= S3C64XX_PA_SDRAM + 0x100,
 
 	.init_irq	= s3c6410_init_irq,
diff --git a/arch/arm/mach-s5p6440/mach-smdk6440.c b/arch/arm/mach-s5p6440/mach-smdk6440.c
index 8291fec..40a2615 100644
--- a/arch/arm/mach-s5p6440/mach-smdk6440.c
+++ b/arch/arm/mach-s5p6440/mach-smdk6440.c
@@ -114,8 +114,6 @@ static void __init smdk6440_machine_init(void)
 
 MACHINE_START(SMDK6440, "SMDK6440")
 	/* Maintainer: Kukjin Kim <kgene.kim@samsung.com> */
-	.phys_io	= S3C_PA_UART & 0xfff00000,
-	.io_pg_offst	= (((u32)S3C_VA_UART) >> 18) & 0xfffc,
 	.boot_params	= S5P_PA_SDRAM + 0x100,
 
 	.init_irq	= s5p6440_init_irq,
diff --git a/arch/arm/mach-s5p6442/mach-smdk6442.c b/arch/arm/mach-s5p6442/mach-smdk6442.c
index ebcf997..b9d6855 100644
--- a/arch/arm/mach-s5p6442/mach-smdk6442.c
+++ b/arch/arm/mach-s5p6442/mach-smdk6442.c
@@ -82,8 +82,6 @@ static void __init smdk6442_machine_init(void)
 
 MACHINE_START(SMDK6442, "SMDK6442")
 	/* Maintainer: Kukjin Kim <kgene.kim@samsung.com> */
-	.phys_io	= S3C_PA_UART & 0xfff00000,
-	.io_pg_offst	= (((u32)S3C_VA_UART) >> 18) & 0xfffc,
 	.boot_params	= S5P_PA_SDRAM + 0x100,
 	.init_irq	= s5p6442_init_irq,
 	.map_io		= smdk6442_map_io,
diff --git a/arch/arm/mach-s5pc100/mach-smdkc100.c b/arch/arm/mach-s5pc100/mach-smdkc100.c
index af22f82..40cd712 100644
--- a/arch/arm/mach-s5pc100/mach-smdkc100.c
+++ b/arch/arm/mach-s5pc100/mach-smdkc100.c
@@ -187,8 +187,6 @@ static void __init smdkc100_machine_init(void)
 
 MACHINE_START(SMDKC100, "SMDKC100")
 	/* Maintainer: Byungho Min <bhmin@samsung.com> */
-	.phys_io	= S3C_PA_UART & 0xfff00000,
-	.io_pg_offst	= (((u32)S3C_VA_UART) >> 18) & 0xfffc,
 	.boot_params	= S5P_PA_SDRAM + 0x100,
 	.init_irq	= s5pc100_init_irq,
 	.map_io		= smdkc100_map_io,
diff --git a/arch/arm/mach-s5pv210/mach-aquila.c b/arch/arm/mach-s5pv210/mach-aquila.c
index 10bc76e..2f9e5a3 100644
--- a/arch/arm/mach-s5pv210/mach-aquila.c
+++ b/arch/arm/mach-s5pv210/mach-aquila.c
@@ -139,8 +139,6 @@ MACHINE_START(AQUILA, "Aquila")
 	/* Maintainers:
 	   Marek Szyprowski <m.szyprowski@samsung.com>
 	   Kyungmin Park <kyungmin.park@samsung.com> */
-	.phys_io	= S3C_PA_UART & 0xfff00000,
-	.io_pg_offst	= (((u32)S3C_VA_UART) >> 18) & 0xfffc,
 	.boot_params	= S5P_PA_SDRAM + 0x100,
 	.init_irq	= s5pv210_init_irq,
 	.map_io		= aquila_map_io,
diff --git a/arch/arm/mach-s5pv210/mach-goni.c b/arch/arm/mach-s5pv210/mach-goni.c
index 4863b13..f535349 100644
--- a/arch/arm/mach-s5pv210/mach-goni.c
+++ b/arch/arm/mach-s5pv210/mach-goni.c
@@ -88,8 +88,6 @@ static void __init goni_machine_init(void)
 
 MACHINE_START(GONI, "GONI")
 	/* Maintainers: Kyungmin Park <kyungmin.park@samsung.com> */
-	.phys_io	= S3C_PA_UART & 0xfff00000,
-	.io_pg_offst	= (((u32)S3C_VA_UART) >> 18) & 0xfffc,
 	.boot_params	= S5P_PA_SDRAM + 0x100,
 	.init_irq	= s5pv210_init_irq,
 	.map_io		= goni_map_io,
diff --git a/arch/arm/mach-s5pv210/mach-smdkc110.c b/arch/arm/mach-s5pv210/mach-smdkc110.c
index 4c8903c..9fb6488 100644
--- a/arch/arm/mach-s5pv210/mach-smdkc110.c
+++ b/arch/arm/mach-s5pv210/mach-smdkc110.c
@@ -91,8 +91,6 @@ static void __init smdkc110_machine_init(void)
 
 MACHINE_START(SMDKC110, "SMDKC110")
 	/* Maintainer: Kukjin Kim <kgene.kim@samsung.com> */
-	.phys_io	= S3C_PA_UART & 0xfff00000,
-	.io_pg_offst	= (((u32)S3C_VA_UART) >> 18) & 0xfffc,
 	.boot_params	= S5P_PA_SDRAM + 0x100,
 	.init_irq	= s5pv210_init_irq,
 	.map_io		= smdkc110_map_io,
diff --git a/arch/arm/mach-s5pv210/mach-smdkv210.c b/arch/arm/mach-s5pv210/mach-smdkv210.c
index 0d46279..c5133ae 100644
--- a/arch/arm/mach-s5pv210/mach-smdkv210.c
+++ b/arch/arm/mach-s5pv210/mach-smdkv210.c
@@ -102,8 +102,6 @@ static void __init smdkv210_machine_init(void)
 
 MACHINE_START(SMDKV210, "SMDKV210")
 	/* Maintainer: Kukjin Kim <kgene.kim@samsung.com> */
-	.phys_io	= S3C_PA_UART & 0xfff00000,
-	.io_pg_offst	= (((u32)S3C_VA_UART) >> 18) & 0xfffc,
 	.boot_params	= S5P_PA_SDRAM + 0x100,
 	.init_irq	= s5pv210_init_irq,
 	.map_io		= smdkv210_map_io,
diff --git a/arch/arm/mach-sa1100/assabet.c b/arch/arm/mach-sa1100/assabet.c
index 169e5b8..5778274 100644
--- a/arch/arm/mach-sa1100/assabet.c
+++ b/arch/arm/mach-sa1100/assabet.c
@@ -447,8 +447,6 @@ static void __init assabet_map_io(void)
 
 
 MACHINE_START(ASSABET, "Intel-Assabet")
-	.phys_io	= 0x80000000,
-	.io_pg_offst	= ((0xf8000000) >> 18) & 0xfffc,
 	.boot_params	= 0xc0000100,
 	.fixup		= fixup_assabet,
 	.map_io		= assabet_map_io,
diff --git a/arch/arm/mach-sa1100/badge4.c b/arch/arm/mach-sa1100/badge4.c
index 259cb2c..4f19ff8 100644
--- a/arch/arm/mach-sa1100/badge4.c
+++ b/arch/arm/mach-sa1100/badge4.c
@@ -302,8 +302,6 @@ static void __init badge4_map_io(void)
 }
 
 MACHINE_START(BADGE4, "Hewlett-Packard Laboratories BadgePAD 4")
-	.phys_io	= 0x80000000,
-	.io_pg_offst	= ((0xf8000000) >> 18) & 0xfffc,
 	.boot_params	= 0xc0000100,
 	.map_io		= badge4_map_io,
 	.init_irq	= sa1100_init_irq,
diff --git a/arch/arm/mach-sa1100/cerf.c b/arch/arm/mach-sa1100/cerf.c
index bc950ef..98d7806 100644
--- a/arch/arm/mach-sa1100/cerf.c
+++ b/arch/arm/mach-sa1100/cerf.c
@@ -135,8 +135,6 @@ static void __init cerf_init(void)
 
 MACHINE_START(CERF, "Intrinsyc CerfBoard/CerfCube")
 	/* Maintainer: support at intrinsyc.com */
-	.phys_io	= 0x80000000,
-	.io_pg_offst	= ((0xf8000000) >> 18) & 0xfffc,
 	.map_io		= cerf_map_io,
 	.init_irq	= cerf_init_irq,
 	.timer		= &sa1100_timer,
diff --git a/arch/arm/mach-sa1100/collie.c b/arch/arm/mach-sa1100/collie.c
index 5d5f330..79ee3ea 100644
--- a/arch/arm/mach-sa1100/collie.c
+++ b/arch/arm/mach-sa1100/collie.c
@@ -379,8 +379,6 @@ static void __init collie_map_io(void)
 }
 
 MACHINE_START(COLLIE, "Sharp-Collie")
-	.phys_io	= 0x80000000,
-	.io_pg_offst	= ((0xf8000000) >> 18) & 0xfffc,
 	.map_io		= collie_map_io,
 	.init_irq	= sa1100_init_irq,
 	.timer		= &sa1100_timer,
diff --git a/arch/arm/mach-sa1100/h3100.c b/arch/arm/mach-sa1100/h3100.c
index 0c7cea0..03d7376 100644
--- a/arch/arm/mach-sa1100/h3100.c
+++ b/arch/arm/mach-sa1100/h3100.c
@@ -84,8 +84,6 @@ static void __init h3100_mach_init(void)
 }
 
 MACHINE_START(H3100, "Compaq iPAQ H3100")
-	.phys_io	= 0x80000000,
-	.io_pg_offst	= ((0xf8000000) >> 18) & 0xfffc,
 	.boot_params	= 0xc0000100,
 	.map_io		= h3100_map_io,
 	.init_irq	= sa1100_init_irq,
diff --git a/arch/arm/mach-sa1100/h3600.c b/arch/arm/mach-sa1100/h3600.c
index af3b714..965f64a 100644
--- a/arch/arm/mach-sa1100/h3600.c
+++ b/arch/arm/mach-sa1100/h3600.c
@@ -125,8 +125,6 @@ static void __init h3600_mach_init(void)
 }
 
 MACHINE_START(H3600, "Compaq iPAQ H3600")
-	.phys_io	= 0x80000000,
-	.io_pg_offst	= ((0xf8000000) >> 18) & 0xfffc,
 	.boot_params	= 0xc0000100,
 	.map_io		= h3600_map_io,
 	.init_irq	= sa1100_init_irq,
diff --git a/arch/arm/mach-sa1100/hackkit.c b/arch/arm/mach-sa1100/hackkit.c
index 51568df..db5e434 100644
--- a/arch/arm/mach-sa1100/hackkit.c
+++ b/arch/arm/mach-sa1100/hackkit.c
@@ -195,8 +195,6 @@ static void __init hackkit_init(void)
  */
 
 MACHINE_START(HACKKIT, "HackKit Cpu Board")
-	.phys_io	= 0x80000000,
-	.io_pg_offst	= ((0xf8000000) >> 18) & 0xfffc,
 	.boot_params	= 0xc0000100,
 	.map_io		= hackkit_map_io,
 	.init_irq	= sa1100_init_irq,
diff --git a/arch/arm/mach-sa1100/jornada720.c b/arch/arm/mach-sa1100/jornada720.c
index d3ec620..491ac9f 100644
--- a/arch/arm/mach-sa1100/jornada720.c
+++ b/arch/arm/mach-sa1100/jornada720.c
@@ -364,8 +364,6 @@ static void __init jornada720_mach_init(void)
 
 MACHINE_START(JORNADA720, "HP Jornada 720")
 	/* Maintainer: Kristoffer Ericson <Kristoffer.Ericson@gmail.com> */
-	.phys_io	= 0x80000000,
-	.io_pg_offst	= ((0xf8000000) >> 18) & 0xfffc,
 	.boot_params	= 0xc0000100,
 	.map_io		= jornada720_map_io,
 	.init_irq	= sa1100_init_irq,
diff --git a/arch/arm/mach-sa1100/lart.c b/arch/arm/mach-sa1100/lart.c
index 68069d6..7b9556b 100644
--- a/arch/arm/mach-sa1100/lart.c
+++ b/arch/arm/mach-sa1100/lart.c
@@ -61,8 +61,6 @@ static void __init lart_map_io(void)
 }
 
 MACHINE_START(LART, "LART")
-	.phys_io	= 0x80000000,
-	.io_pg_offst	= ((0xf8000000) >> 18) & 0xfffc,
 	.boot_params	= 0xc0000100,
 	.map_io		= lart_map_io,
 	.init_irq	= sa1100_init_irq,
diff --git a/arch/arm/mach-sa1100/pleb.c b/arch/arm/mach-sa1100/pleb.c
index 1ccd601..42b8040 100644
--- a/arch/arm/mach-sa1100/pleb.c
+++ b/arch/arm/mach-sa1100/pleb.c
@@ -146,8 +146,6 @@ static void __init pleb_map_io(void)
 }
 
 MACHINE_START(PLEB, "PLEB")
-	.phys_io	= 0x80000000,
-	.io_pg_offst	= ((0xf8000000) >> 18) & 0xfffc,
 	.map_io		= pleb_map_io,
 	.init_irq	= sa1100_init_irq,
 	.timer		= &sa1100_timer,
diff --git a/arch/arm/mach-sa1100/shannon.c b/arch/arm/mach-sa1100/shannon.c
index 85e82bb..7917b24 100644
--- a/arch/arm/mach-sa1100/shannon.c
+++ b/arch/arm/mach-sa1100/shannon.c
@@ -82,8 +82,6 @@ static void __init shannon_map_io(void)
 }
 
 MACHINE_START(SHANNON, "Shannon (AKA: Tuxscreen)")
-	.phys_io	= 0x80000000,
-	.io_pg_offst	= ((0xf8000000) >> 18) & 0xfffc,
 	.boot_params	= 0xc0000100,
 	.map_io		= shannon_map_io,
 	.init_irq	= sa1100_init_irq,
diff --git a/arch/arm/mach-sa1100/simpad.c b/arch/arm/mach-sa1100/simpad.c
index 49cfd64..27692d0 100644
--- a/arch/arm/mach-sa1100/simpad.c
+++ b/arch/arm/mach-sa1100/simpad.c
@@ -228,8 +228,6 @@ arch_initcall(simpad_init);
 
 MACHINE_START(SIMPAD, "Simpad")
 	/* Maintainer: Holger Freyther */
-	.phys_io	= 0x80000000,
-	.io_pg_offst	= ((0xf8000000) >> 18) & 0xfffc,
 	.boot_params	= 0xc0000100,
 	.map_io		= simpad_map_io,
 	.init_irq	= sa1100_init_irq,
diff --git a/arch/arm/mach-shark/core.c b/arch/arm/mach-shark/core.c
index 358d875..5cf7f94 100644
--- a/arch/arm/mach-shark/core.c
+++ b/arch/arm/mach-shark/core.c
@@ -152,8 +152,6 @@ static struct sys_timer shark_timer = {
 
 MACHINE_START(SHARK, "Shark")
 	/* Maintainer: Alexander Schulz */
-	.phys_io	= 0x40000000,
-	.io_pg_offst	= ((0xe0000000) >> 18) & 0xfffc,
 	.boot_params	= 0x08003000,
 	.map_io		= shark_map_io,
 	.init_irq	= shark_init_irq,
diff --git a/arch/arm/mach-shmobile/board-ap4evb.c b/arch/arm/mach-shmobile/board-ap4evb.c
index 1c2ec96..bd09a46 100644
--- a/arch/arm/mach-shmobile/board-ap4evb.c
+++ b/arch/arm/mach-shmobile/board-ap4evb.c
@@ -324,8 +324,6 @@ static void __init ap4evb_init(void)
 }
 
 MACHINE_START(AP4EVB, "ap4evb")
-	.phys_io	= 0xe6000000,
-	.io_pg_offst	= ((0xe6000000) >> 18) & 0xfffc,
 	.map_io		= ap4evb_map_io,
 	.init_irq	= sh7372_init_irq,
 	.init_machine	= ap4evb_init,
diff --git a/arch/arm/mach-shmobile/board-g3evm.c b/arch/arm/mach-shmobile/board-g3evm.c
index 9247503..8b99a63 100644
--- a/arch/arm/mach-shmobile/board-g3evm.c
+++ b/arch/arm/mach-shmobile/board-g3evm.c
@@ -324,8 +324,6 @@ static void __init g3evm_init(void)
 }
 
 MACHINE_START(G3EVM, "g3evm")
-	.phys_io	= 0xe6000000,
-	.io_pg_offst	= ((0xe6000000) >> 18) & 0xfffc,
 	.map_io		= g3evm_map_io,
 	.init_irq	= sh7367_init_irq,
 	.init_machine	= g3evm_init,
diff --git a/arch/arm/mach-shmobile/board-g4evm.c b/arch/arm/mach-shmobile/board-g4evm.c
index 10673a9..527c4a9 100644
--- a/arch/arm/mach-shmobile/board-g4evm.c
+++ b/arch/arm/mach-shmobile/board-g4evm.c
@@ -259,8 +259,6 @@ static void __init g4evm_init(void)
 }
 
 MACHINE_START(G4EVM, "g4evm")
-	.phys_io	= 0xe6000000,
-	.io_pg_offst	= ((0xe6000000) >> 18) & 0xfffc,
 	.map_io		= g4evm_map_io,
 	.init_irq	= sh7377_init_irq,
 	.init_machine	= g4evm_init,
diff --git a/arch/arm/mach-stmp378x/stmp378x_devb.c b/arch/arm/mach-stmp378x/stmp378x_devb.c
index 90d8fe6..0615884 100644
--- a/arch/arm/mach-stmp378x/stmp378x_devb.c
+++ b/arch/arm/mach-stmp378x/stmp378x_devb.c
@@ -324,8 +324,6 @@ static void __init stmp378x_devb_init(void)
 }
 
 MACHINE_START(STMP378X, "STMP378X")
-	.phys_io	= 0x80000000,
-	.io_pg_offst	= ((0xf0000000) >> 18) & 0xfffc,
 	.boot_params	= 0x40000100,
 	.map_io		= stmp378x_map_io,
 	.init_irq	= stmp378x_init_irq,
diff --git a/arch/arm/mach-stmp37xx/stmp37xx_devb.c b/arch/arm/mach-stmp37xx/stmp37xx_devb.c
index 394f21a..311d855 100644
--- a/arch/arm/mach-stmp37xx/stmp37xx_devb.c
+++ b/arch/arm/mach-stmp37xx/stmp37xx_devb.c
@@ -91,8 +91,6 @@ static void __init stmp37xx_devb_init(void)
 }
 
 MACHINE_START(STMP37XX, "STMP37XX")
-	.phys_io	= 0x80000000,
-	.io_pg_offst	= ((0xf0000000) >> 18) & 0xfffc,
 	.boot_params	= 0x40000100,
 	.map_io		= stmp37xx_map_io,
 	.init_irq	= stmp37xx_init_irq,
diff --git a/arch/arm/mach-u300/u300.c b/arch/arm/mach-u300/u300.c
index d2a0b88..0bcec41 100644
--- a/arch/arm/mach-u300/u300.c
+++ b/arch/arm/mach-u300/u300.c
@@ -45,8 +45,6 @@ static void __init u300_init_machine(void)
 
 MACHINE_START(U300, MACH_U300_STRING)
 	/* Maintainer: Linus Walleij <linus.walleij@stericsson.com> */
-	.phys_io	= U300_AHB_PER_PHYS_BASE,
-	.io_pg_offst	= ((U300_AHB_PER_VIRT_BASE) >> 18) & 0xfffc,
 	.boot_params	= BOOT_PARAMS_OFFSET,
 	.map_io		= u300_map_io,
 	.init_irq	= u300_init_irq,
diff --git a/arch/arm/mach-ux500/board-mop500.c b/arch/arm/mach-ux500/board-mop500.c
index bb8d7b7..742742f 100644
--- a/arch/arm/mach-ux500/board-mop500.c
+++ b/arch/arm/mach-ux500/board-mop500.c
@@ -139,8 +139,6 @@ static void __init u8500_init_machine(void)
 
 MACHINE_START(U8500, "ST-Ericsson MOP500 platform")
 	/* Maintainer: Srinidhi Kasagar <srinidhi.kasagar@stericsson.com> */
-	.phys_io	= U8500_UART2_BASE,
-	.io_pg_offst	= (IO_ADDRESS(U8500_UART2_BASE) >> 18) & 0xfffc,
 	.boot_params	= 0x100,
 	.map_io		= u8500_map_io,
 	.init_irq	= ux500_init_irq,
diff --git a/arch/arm/mach-ux500/board-u5500.c b/arch/arm/mach-ux500/board-u5500.c
index 4430e69..1ca094a 100644
--- a/arch/arm/mach-ux500/board-u5500.c
+++ b/arch/arm/mach-ux500/board-u5500.c
@@ -31,8 +31,6 @@ static void __init u5500_init_machine(void)
 }
 
 MACHINE_START(U8500, "ST-Ericsson U5500 Platform")
-	.phys_io	= UX500_UART0_BASE,
-	.io_pg_offst	= (IO_ADDRESS(UX500_UART0_BASE) >> 18) & 0xfffc,
 	.boot_params	= 0x00000100,
 	.map_io		= u5500_map_io,
 	.init_irq	= ux500_init_irq,
diff --git a/arch/arm/mach-versatile/versatile_ab.c b/arch/arm/mach-versatile/versatile_ab.c
index bb8ec77..aa9730f 100644
--- a/arch/arm/mach-versatile/versatile_ab.c
+++ b/arch/arm/mach-versatile/versatile_ab.c
@@ -35,8 +35,6 @@
 
 MACHINE_START(VERSATILE_AB, "ARM-Versatile AB")
 	/* Maintainer: ARM Ltd/Deep Blue Solutions Ltd */
-	.phys_io	= 0x101f1000,
-	.io_pg_offst	= ((0xf11f1000) >> 18) & 0xfffc,
 	.boot_params	= 0x00000100,
 	.map_io		= versatile_map_io,
 	.init_irq	= versatile_init_irq,
diff --git a/arch/arm/mach-versatile/versatile_pb.c b/arch/arm/mach-versatile/versatile_pb.c
index 239cd30..bf46964 100644
--- a/arch/arm/mach-versatile/versatile_pb.c
+++ b/arch/arm/mach-versatile/versatile_pb.c
@@ -108,8 +108,6 @@ static void __init versatile_pb_init(void)
 
 MACHINE_START(VERSATILE_PB, "ARM-Versatile PB")
 	/* Maintainer: ARM Ltd/Deep Blue Solutions Ltd */
-	.phys_io	= 0x101f1000,
-	.io_pg_offst	= ((0xf11f1000) >> 18) & 0xfffc,
 	.boot_params	= 0x00000100,
 	.map_io		= versatile_map_io,
 	.init_irq	= versatile_init_irq,
diff --git a/arch/arm/mach-vexpress/ct-ca9x4.c b/arch/arm/mach-vexpress/ct-ca9x4.c
index 6353459..840b6c3 100644
--- a/arch/arm/mach-vexpress/ct-ca9x4.c
+++ b/arch/arm/mach-vexpress/ct-ca9x4.c
@@ -237,8 +237,6 @@ static void ct_ca9x4_init(void)
 }
 
 MACHINE_START(VEXPRESS, "ARM-Versatile Express CA9x4")
-	.phys_io	= V2M_UART0 & SECTION_MASK,
-	.io_pg_offst	= (__MMIO_P2V(V2M_UART0) >> 18) & 0xfffc,
 	.boot_params	= PHYS_OFFSET + 0x00000100,
 	.map_io		= ct_ca9x4_map_io,
 	.init_irq	= ct_ca9x4_init_irq,
diff --git a/arch/arm/mach-w90x900/mach-nuc910evb.c b/arch/arm/mach-w90x900/mach-nuc910evb.c
index ec05bda..30fccde 100644
--- a/arch/arm/mach-w90x900/mach-nuc910evb.c
+++ b/arch/arm/mach-w90x900/mach-nuc910evb.c
@@ -34,8 +34,6 @@ static void __init nuc910evb_init(void)
 
 MACHINE_START(W90P910EVB, "W90P910EVB")
 	/* Maintainer: Wan ZongShun */
-	.phys_io	= W90X900_PA_UART,
-	.io_pg_offst	= (((u32)W90X900_VA_UART) >> 18) & 0xfffc,
 	.boot_params	= 0,
 	.map_io		= nuc910evb_map_io,
 	.init_irq	= nuc900_init_irq,
diff --git a/arch/arm/mach-w90x900/mach-nuc950evb.c b/arch/arm/mach-w90x900/mach-nuc950evb.c
index b3edc3c..a1355b2 100644
--- a/arch/arm/mach-w90x900/mach-nuc950evb.c
+++ b/arch/arm/mach-w90x900/mach-nuc950evb.c
@@ -81,8 +81,6 @@ static void __init nuc950evb_init(void)
 
 MACHINE_START(W90P950EVB, "W90P950EVB")
 	/* Maintainer: Wan ZongShun */
-	.phys_io	= W90X900_PA_UART,
-	.io_pg_offst	= (((u32)W90X900_VA_UART) >> 18) & 0xfffc,
 	.boot_params	= 0,
 	.map_io		= nuc950evb_map_io,
 	.init_irq	= nuc900_init_irq,
diff --git a/arch/arm/mach-w90x900/mach-nuc960evb.c b/arch/arm/mach-w90x900/mach-nuc960evb.c
index e3a46f1..e09c645 100644
--- a/arch/arm/mach-w90x900/mach-nuc960evb.c
+++ b/arch/arm/mach-w90x900/mach-nuc960evb.c
@@ -34,8 +34,6 @@ static void __init nuc960evb_init(void)
 
 MACHINE_START(W90N960EVB, "W90N960EVB")
 	/* Maintainer: Wan ZongShun */
-	.phys_io	= W90X900_PA_UART,
-	.io_pg_offst	= (((u32)W90X900_VA_UART) >> 18) & 0xfffc,
 	.boot_params	= 0,
 	.map_io		= nuc960evb_map_io,
 	.init_irq	= nuc900_init_irq,
