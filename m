From: nico@fluxnic.net (Nicolas Pitre)
Date: Tue, 19 Jul 2011 00:55:46 -0400 (EDT)
Subject: Git pull request: boot_params to atag_offset conversion
Message-ID: <alpine.LFD.2.00.1107190042280.21187@xanadu.home>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Russell, could you please pull:

	git://git.linaro.org/people/nico/linux atag_offset

This contains the previously posted patches, plus the collected 
Acked-by/Tested-by tags so far.  Since the discussion has died down, I 
don't expect further changes.

Alternatively, this can go via the linux-arm-soc tree if you prefer 
that.

Nicolas Pitre (52):
      ARM: introduce atag_offset to replace boot_params
      ARM: mach-clps711x: convert boot_params to atag_offset
      ARM: mach-cns3xxx: convert boot_params to atag_offset
      ARM: mach-davinci: convert boot_params to atag_offset
      ARM: mach-dove: convert boot-params to atag_offset
      ARM: mach-ebsa110: convert boot_params to atag_offset
      ARM: mach-ep93xx: convert boot_params to atag_offset
      ARM: mach-exynos4: convert boot_params to atag_offset
      ARM: mach-footbridge: convert boot_params to atag_offset
      ARM: mach-gemini: convert boot_params to atag_offset
      ARM: mach-h720x: convert boot_params to atag_offset
      ARM: mach-imx: convert boot_params to atag_offset
      ARM: mach-integrator: convert boot_params to atag_offset
      ARM: mach-iop13xx: convert boot_params to atag_offset
      ARM: mach-iop32x: convert boot_params to atag_offset
      ARM: mach-iop33x: convert boot_params to atag_offset
      ARM: mach-ixp2000: convert boot_params to atag_offset
      ARM: mach-ixp23xx: convert boot_params to atag_offset
      ARM: mach-ixp4xx: convert boot_params to atag_offset
      ARM: mach-kirkwood: convert boot_params to atag_offset
      ARM: mach-ks8695: convert boot_params to atag_offset
      ARM: mach-loki: convert boot_params to atag_offset
      ARM: mach-lpc32xx: convert boot_params to atag_offset
      ARM: mach-msm: convert boot_params to atag_offset
      ARM: mach-mv78xx0: convert boot_params to atag_offset
      ARM: mach-mx5: convert boot_params to atag_offset
      ARM: mach-netx: convert boot_params to atag_offset
      ARM: mach-nomadik: convert boot_params to atag_offset
      ARM: mach-nuc93x: convert boot_params to atag_offset
      ARM: mach-omap1: convert boot_params to atag_offset
      ARM: mach-omap2: convert boot_params to atag_offset
      ARM: mach-orion5x: convert boot_params to atag_offset
      ARM: mach-pnx4008: convert boot_params to atag_offset
      ARM: mach-pxa: convert boot_params to atag_offset
      ARM: mach-realview: convert boot_params to atag_offset
      ARM: mach-rpc: convert boot_params to atag_offset
      ARM: mach-s3c24*: convert boot_params to atag_offset
      ARM: mach-s5p64x0: convert boot_params to atag_offset
      ARM: mach-s3c64xx: convert boot_params to atag_offset
      ARM: mach-s5pc100, mach-s5pv210: convert boot_params to atag_offset
      ARM: mach-sa1100: convert boot_params to atag_offset
      ARM: mach-shark: convert boot_params to atag_offset
      ARM: mach-spear*: convert boot_params to atag_offset
      ARM: mach-tcc8k: convert boot_params to atag_offset
      ARM: mach-tegra: convert boot_params to atag_offset
      ARM: mach-u300: convert boot_params to atag_offset
      ARM: mach-ux500: convert boot-params to atag_offset
      ARM: mach-versatile: convert boot-params to atag_offset
      ARM: vexpress: convert boot_params to atag_offset
      ARM: mach-vt8500: convert boot_params to atag_offset
      ARM: mach-w90x900: remove useless boot_params entries
      ARM: remove boot_params from struct machine_desc

 arch/arm/include/asm/mach/arch.h               |    2 +-
 arch/arm/kernel/setup.c                        |   21 +----------------
 arch/arm/mach-clps711x/autcpu12.c              |    2 +-
 arch/arm/mach-clps711x/cdb89712.c              |    2 +-
 arch/arm/mach-clps711x/ceiva.c                 |    2 +-
 arch/arm/mach-clps711x/clep7312.c              |    2 +-
 arch/arm/mach-clps711x/edb7211-arch.c          |    2 +-
 arch/arm/mach-clps711x/fortunet.c              |    1 -
 arch/arm/mach-clps711x/p720t.c                 |    2 +-
 arch/arm/mach-cns3xxx/cns3420vb.c              |    2 +-
 arch/arm/mach-davinci/board-da830-evm.c        |    2 +-
 arch/arm/mach-davinci/board-da850-evm.c        |    2 +-
 arch/arm/mach-davinci/board-dm355-evm.c        |    2 +-
 arch/arm/mach-davinci/board-dm355-leopard.c    |    2 +-
 arch/arm/mach-davinci/board-dm365-evm.c        |    2 +-
 arch/arm/mach-davinci/board-dm644x-evm.c       |    2 +-
 arch/arm/mach-davinci/board-dm646x-evm.c       |    4 +-
 arch/arm/mach-davinci/board-mityomapl138.c     |    2 +-
 arch/arm/mach-davinci/board-neuros-osd2.c      |    2 +-
 arch/arm/mach-davinci/board-omapl138-hawk.c    |    2 +-
 arch/arm/mach-davinci/board-sffsdr.c           |    2 +-
 arch/arm/mach-davinci/board-tnetv107x-evm.c    |    2 +-
 arch/arm/mach-dove/cm-a510.c                   |    2 +-
 arch/arm/mach-dove/dove-db-setup.c             |    2 +-
 arch/arm/mach-ebsa110/core.c                   |    2 +-
 arch/arm/mach-ep93xx/adssphere.c               |    2 +-
 arch/arm/mach-ep93xx/edb93xx.c                 |   16 ++++++------
 arch/arm/mach-ep93xx/gesbc9312.c               |    2 +-
 arch/arm/mach-ep93xx/micro9.c                  |    8 +++---
 arch/arm/mach-ep93xx/simone.c                  |    2 +-
 arch/arm/mach-ep93xx/snappercl15.c             |    2 +-
 arch/arm/mach-ep93xx/ts72xx.c                  |    2 +-
 arch/arm/mach-exynos4/mach-armlex4210.c        |    2 +-
 arch/arm/mach-exynos4/mach-nuri.c              |    2 +-
 arch/arm/mach-exynos4/mach-smdkc210.c          |    2 +-
 arch/arm/mach-exynos4/mach-smdkv310.c          |    2 +-
 arch/arm/mach-exynos4/mach-universal_c210.c    |    2 +-
 arch/arm/mach-footbridge/cats-hw.c             |    2 +-
 arch/arm/mach-footbridge/ebsa285.c             |    2 +-
 arch/arm/mach-footbridge/netwinder-hw.c        |    2 +-
 arch/arm/mach-footbridge/personal.c            |    2 +-
 arch/arm/mach-gemini/board-nas4220b.c          |    2 +-
 arch/arm/mach-gemini/board-rut1xx.c            |    2 +-
 arch/arm/mach-gemini/board-wbd111.c            |    2 +-
 arch/arm/mach-gemini/board-wbd222.c            |    2 +-
 arch/arm/mach-h720x/h7202-eval.c               |    2 +-
 arch/arm/mach-imx/mach-armadillo5x0.c          |    2 +-
 arch/arm/mach-imx/mach-cpuimx27.c              |    2 +-
 arch/arm/mach-imx/mach-cpuimx35.c              |    2 +-
 arch/arm/mach-imx/mach-eukrea_cpuimx25.c       |    2 +-
 arch/arm/mach-imx/mach-imx27_visstrim_m10.c    |    2 +-
 arch/arm/mach-imx/mach-imx27ipcam.c            |    2 +-
 arch/arm/mach-imx/mach-imx27lite.c             |    2 +-
 arch/arm/mach-imx/mach-kzm_arm11_01.c          |    2 +-
 arch/arm/mach-imx/mach-mx1ads.c                |    4 +-
 arch/arm/mach-imx/mach-mx21ads.c               |    2 +-
 arch/arm/mach-imx/mach-mx25_3ds.c              |    2 +-
 arch/arm/mach-imx/mach-mx27_3ds.c              |    2 +-
 arch/arm/mach-imx/mach-mx27ads.c               |    2 +-
 arch/arm/mach-imx/mach-mx31_3ds.c              |    2 +-
 arch/arm/mach-imx/mach-mx31ads.c               |    2 +-
 arch/arm/mach-imx/mach-mx31lilly.c             |    2 +-
 arch/arm/mach-imx/mach-mx31lite.c              |    2 +-
 arch/arm/mach-imx/mach-mx31moboard.c           |    2 +-
 arch/arm/mach-imx/mach-mx35_3ds.c              |    2 +-
 arch/arm/mach-imx/mach-mxt_td60.c              |    2 +-
 arch/arm/mach-imx/mach-pca100.c                |    2 +-
 arch/arm/mach-imx/mach-pcm037.c                |    2 +-
 arch/arm/mach-imx/mach-pcm038.c                |    2 +-
 arch/arm/mach-imx/mach-pcm043.c                |    2 +-
 arch/arm/mach-imx/mach-qong.c                  |    2 +-
 arch/arm/mach-imx/mach-scb9328.c               |    2 +-
 arch/arm/mach-integrator/integrator_ap.c       |    2 +-
 arch/arm/mach-integrator/integrator_cp.c       |    2 +-
 arch/arm/mach-iop13xx/iq81340mc.c              |    2 +-
 arch/arm/mach-iop13xx/iq81340sc.c              |    2 +-
 arch/arm/mach-iop32x/em7210.c                  |    2 +-
 arch/arm/mach-iop32x/glantank.c                |    2 +-
 arch/arm/mach-iop32x/iq31244.c                 |    4 +-
 arch/arm/mach-iop32x/iq80321.c                 |    2 +-
 arch/arm/mach-iop32x/n2100.c                   |    2 +-
 arch/arm/mach-iop33x/iq80331.c                 |    2 +-
 arch/arm/mach-iop33x/iq80332.c                 |    2 +-
 arch/arm/mach-ixp2000/enp2611.c                |    2 +-
 arch/arm/mach-ixp2000/ixdp2400.c               |    2 +-
 arch/arm/mach-ixp2000/ixdp2800.c               |    2 +-
 arch/arm/mach-ixp2000/ixdp2x01.c               |    6 ++--
 arch/arm/mach-ixp23xx/espresso.c               |    2 +-
 arch/arm/mach-ixp23xx/ixdp2351.c               |    2 +-
 arch/arm/mach-ixp23xx/roadrunner.c             |    2 +-
 arch/arm/mach-ixp4xx/avila-setup.c             |    4 +-
 arch/arm/mach-ixp4xx/coyote-setup.c            |    4 +-
 arch/arm/mach-ixp4xx/dsmg600-setup.c           |    2 +-
 arch/arm/mach-ixp4xx/fsg-setup.c               |    2 +-
 arch/arm/mach-ixp4xx/gateway7001-setup.c       |    2 +-
 arch/arm/mach-ixp4xx/goramo_mlr.c              |    2 +-
 arch/arm/mach-ixp4xx/gtwx5715-setup.c          |    2 +-
 arch/arm/mach-ixp4xx/ixdp425-setup.c           |    8 +++---
 arch/arm/mach-ixp4xx/nas100d-setup.c           |    2 +-
 arch/arm/mach-ixp4xx/nslu2-setup.c             |    2 +-
 arch/arm/mach-ixp4xx/vulcan-setup.c            |    2 +-
 arch/arm/mach-ixp4xx/wg302v2-setup.c           |    2 +-
 arch/arm/mach-kirkwood/d2net_v2-setup.c        |    2 +-
 arch/arm/mach-kirkwood/db88f6281-bp-setup.c    |    2 +-
 arch/arm/mach-kirkwood/dockstar-setup.c        |    2 +-
 arch/arm/mach-kirkwood/guruplug-setup.c        |    2 +-
 arch/arm/mach-kirkwood/mv88f6281gtw_ge-setup.c |    2 +-
 arch/arm/mach-kirkwood/netspace_v2-setup.c     |    6 ++--
 arch/arm/mach-kirkwood/netxbig_v2-setup.c      |    4 +-
 arch/arm/mach-kirkwood/openrd-setup.c          |    6 ++--
 arch/arm/mach-kirkwood/rd88f6192-nas-setup.c   |    2 +-
 arch/arm/mach-kirkwood/rd88f6281-setup.c       |    2 +-
 arch/arm/mach-kirkwood/sheevaplug-setup.c      |    4 +-
 arch/arm/mach-kirkwood/t5325-setup.c           |    2 +-
 arch/arm/mach-kirkwood/ts219-setup.c           |    2 +-
 arch/arm/mach-kirkwood/ts41x-setup.c           |    2 +-
 arch/arm/mach-ks8695/board-acs5k.c             |    2 +-
 arch/arm/mach-ks8695/board-dsm320.c            |    2 +-
 arch/arm/mach-ks8695/board-micrel.c            |    2 +-
 arch/arm/mach-loki/lb88rc8480-setup.c          |    2 +-
 arch/arm/mach-lpc32xx/phy3250.c                |    2 +-
 arch/arm/mach-msm/board-halibut.c              |    2 +-
 arch/arm/mach-msm/board-mahimahi.c             |    2 +-
 arch/arm/mach-msm/board-msm7x27.c              |    8 +++---
 arch/arm/mach-msm/board-msm7x30.c              |    6 ++--
 arch/arm/mach-msm/board-qsd8x50.c              |    4 +-
 arch/arm/mach-msm/board-sapphire.c             |    2 +-
 arch/arm/mach-msm/board-trout.c                |    2 +-
 arch/arm/mach-mv78xx0/buffalo-wxl-setup.c      |    2 +-
 arch/arm/mach-mv78xx0/db78x00-bp-setup.c       |    2 +-
 arch/arm/mach-mv78xx0/rd78x00-masa-setup.c     |    2 +-
 arch/arm/mach-mx5/board-cpuimx51.c             |    2 +-
 arch/arm/mach-mx5/board-cpuimx51sd.c           |    2 +-
 arch/arm/mach-mx5/board-mx51_3ds.c             |    2 +-
 arch/arm/mach-mx5/board-mx51_babbage.c         |    2 +-
 arch/arm/mach-mx5/board-mx51_efikamx.c         |    2 +-
 arch/arm/mach-mx5/board-mx51_efikasb.c         |    2 +-
 arch/arm/mach-netx/nxdb500.c                   |    2 +-
 arch/arm/mach-netx/nxdkn.c                     |    2 +-
 arch/arm/mach-netx/nxeb500hmi.c                |    2 +-
 arch/arm/mach-nomadik/board-nhk8815.c          |    2 +-
 arch/arm/mach-nuc93x/mach-nuc932evb.c          |    1 -
 arch/arm/mach-omap1/board-ams-delta.c          |    2 +-
 arch/arm/mach-omap1/board-fsample.c            |    2 +-
 arch/arm/mach-omap1/board-generic.c            |    2 +-
 arch/arm/mach-omap1/board-h2.c                 |    2 +-
 arch/arm/mach-omap1/board-h3.c                 |    2 +-
 arch/arm/mach-omap1/board-htcherald.c          |    2 +-
 arch/arm/mach-omap1/board-innovator.c          |    2 +-
 arch/arm/mach-omap1/board-nokia770.c           |    2 +-
 arch/arm/mach-omap1/board-osk.c                |    2 +-
 arch/arm/mach-omap1/board-palmte.c             |    2 +-
 arch/arm/mach-omap1/board-palmtt.c             |    2 +-
 arch/arm/mach-omap1/board-palmz71.c            |    2 +-
 arch/arm/mach-omap1/board-perseus2.c           |    2 +-
 arch/arm/mach-omap1/board-sx1.c                |    2 +-
 arch/arm/mach-omap1/board-voiceblue.c          |    2 +-
 arch/arm/mach-omap2/board-2430sdp.c            |    2 +-
 arch/arm/mach-omap2/board-3430sdp.c            |    2 +-
 arch/arm/mach-omap2/board-3630sdp.c            |    2 +-
 arch/arm/mach-omap2/board-4430sdp.c            |    2 +-
 arch/arm/mach-omap2/board-am3517crane.c        |    2 +-
 arch/arm/mach-omap2/board-am3517evm.c          |    2 +-
 arch/arm/mach-omap2/board-apollon.c            |    2 +-
 arch/arm/mach-omap2/board-cm-t35.c             |    2 +-
 arch/arm/mach-omap2/board-cm-t3517.c           |    2 +-
 arch/arm/mach-omap2/board-devkit8000.c         |    2 +-
 arch/arm/mach-omap2/board-generic.c            |    2 +-
 arch/arm/mach-omap2/board-h4.c                 |    2 +-
 arch/arm/mach-omap2/board-igep0020.c           |    4 +-
 arch/arm/mach-omap2/board-ldp.c                |    2 +-
 arch/arm/mach-omap2/board-n8x0.c               |    6 ++--
 arch/arm/mach-omap2/board-omap3beagle.c        |    2 +-
 arch/arm/mach-omap2/board-omap3evm.c           |    2 +-
 arch/arm/mach-omap2/board-omap3logic.c         |    4 +-
 arch/arm/mach-omap2/board-omap3pandora.c       |    2 +-
 arch/arm/mach-omap2/board-omap3stalker.c       |    2 +-
 arch/arm/mach-omap2/board-omap3touchbook.c     |    2 +-
 arch/arm/mach-omap2/board-omap4panda.c         |    2 +-
 arch/arm/mach-omap2/board-overo.c              |    2 +-
 arch/arm/mach-omap2/board-rm680.c              |    2 +-
 arch/arm/mach-omap2/board-rx51.c               |    2 +-
 arch/arm/mach-omap2/board-ti8168evm.c          |    2 +-
 arch/arm/mach-omap2/board-zoom.c               |    4 +-
 arch/arm/mach-orion5x/d2net-setup.c            |    4 +-
 arch/arm/mach-orion5x/db88f5281-setup.c        |    2 +-
 arch/arm/mach-orion5x/dns323-setup.c           |    2 +-
 arch/arm/mach-orion5x/edmini_v2-setup.c        |    2 +-
 arch/arm/mach-orion5x/kurobox_pro-setup.c      |    4 +-
 arch/arm/mach-orion5x/ls-chl-setup.c           |    2 +-
 arch/arm/mach-orion5x/ls_hgl-setup.c           |    2 +-
 arch/arm/mach-orion5x/lsmini-setup.c           |    2 +-
 arch/arm/mach-orion5x/mss2-setup.c             |    2 +-
 arch/arm/mach-orion5x/mv2120-setup.c           |    2 +-
 arch/arm/mach-orion5x/net2big-setup.c          |    2 +-
 arch/arm/mach-orion5x/rd88f5181l-fxo-setup.c   |    2 +-
 arch/arm/mach-orion5x/rd88f5181l-ge-setup.c    |    2 +-
 arch/arm/mach-orion5x/rd88f5182-setup.c        |    2 +-
 arch/arm/mach-orion5x/rd88f6183ap-ge-setup.c   |    2 +-
 arch/arm/mach-orion5x/terastation_pro2-setup.c |    2 +-
 arch/arm/mach-orion5x/ts209-setup.c            |    2 +-
 arch/arm/mach-orion5x/ts409-setup.c            |    2 +-
 arch/arm/mach-orion5x/ts78xx-setup.c           |    2 +-
 arch/arm/mach-orion5x/wnr854t-setup.c          |    2 +-
 arch/arm/mach-orion5x/wrt350n-v2-setup.c       |    2 +-
 arch/arm/mach-pnx4008/core.c                   |    2 +-
 arch/arm/mach-pxa/balloon3.c                   |    2 +-
 arch/arm/mach-pxa/capc7117.c                   |    2 +-
 arch/arm/mach-pxa/cm-x2xx.c                    |    2 +-
 arch/arm/mach-pxa/cm-x300.c                    |    2 +-
 arch/arm/mach-pxa/colibri-pxa270.c             |    4 +-
 arch/arm/mach-pxa/colibri-pxa300.c             |    2 +-
 arch/arm/mach-pxa/colibri-pxa320.c             |    2 +-
 arch/arm/mach-pxa/csb726.c                     |    2 +-
 arch/arm/mach-pxa/em-x270.c                    |    4 +-
 arch/arm/mach-pxa/eseries.c                    |   12 +++++-----
 arch/arm/mach-pxa/ezx.c                        |   12 +++++-----
 arch/arm/mach-pxa/gumstix.c                    |    2 +-
 arch/arm/mach-pxa/h5000.c                      |    2 +-
 arch/arm/mach-pxa/himalaya.c                   |    2 +-
 arch/arm/mach-pxa/hx4700.c                     |    2 +-
 arch/arm/mach-pxa/icontrol.c                   |    2 +-
 arch/arm/mach-pxa/littleton.c                  |    2 +-
 arch/arm/mach-pxa/lpd270.c                     |    2 +-
 arch/arm/mach-pxa/magician.c                   |    2 +-
 arch/arm/mach-pxa/mainstone.c                  |    2 +-
 arch/arm/mach-pxa/mioa701.c                    |    2 +-
 arch/arm/mach-pxa/mp900.c                      |    2 +-
 arch/arm/mach-pxa/palmld.c                     |    2 +-
 arch/arm/mach-pxa/palmt5.c                     |    2 +-
 arch/arm/mach-pxa/palmtc.c                     |    2 +-
 arch/arm/mach-pxa/palmte2.c                    |    2 +-
 arch/arm/mach-pxa/palmtreo.c                   |    4 +-
 arch/arm/mach-pxa/palmtx.c                     |    2 +-
 arch/arm/mach-pxa/palmz72.c                    |    2 +-
 arch/arm/mach-pxa/pcm027.c                     |    2 +-
 arch/arm/mach-pxa/raumfeld.c                   |    6 ++--
 arch/arm/mach-pxa/saar.c                       |    2 +-
 arch/arm/mach-pxa/saarb.c                      |    2 +-
 arch/arm/mach-pxa/stargate2.c                  |    4 +-
 arch/arm/mach-pxa/tavorevb.c                   |    2 +-
 arch/arm/mach-pxa/tavorevb3.c                  |    2 +-
 arch/arm/mach-pxa/trizeps4.c                   |    4 +-
 arch/arm/mach-pxa/viper.c                      |    2 +-
 arch/arm/mach-pxa/vpac270.c                    |    2 +-
 arch/arm/mach-pxa/xcep.c                       |    2 +-
 arch/arm/mach-pxa/z2.c                         |    2 +-
 arch/arm/mach-pxa/zeus.c                       |    2 +-
 arch/arm/mach-pxa/zylonite.c                   |    2 +-
 arch/arm/mach-realview/realview_eb.c           |    2 +-
 arch/arm/mach-realview/realview_pb1176.c       |    2 +-
 arch/arm/mach-realview/realview_pb11mp.c       |    2 +-
 arch/arm/mach-realview/realview_pba8.c         |    2 +-
 arch/arm/mach-realview/realview_pbx.c          |    2 +-
 arch/arm/mach-rpc/riscpc.c                     |    2 +-
 arch/arm/mach-s3c2410/mach-amlm5900.c          |    2 +-
 arch/arm/mach-s3c2410/mach-bast.c              |    2 +-
 arch/arm/mach-s3c2410/mach-h1940.c             |    2 +-
 arch/arm/mach-s3c2410/mach-n30.c               |    4 +-
 arch/arm/mach-s3c2410/mach-otom.c              |    2 +-
 arch/arm/mach-s3c2410/mach-qt2410.c            |    2 +-
 arch/arm/mach-s3c2410/mach-smdk2410.c          |    2 +-
 arch/arm/mach-s3c2410/mach-tct_hammer.c        |    2 +-
 arch/arm/mach-s3c2410/mach-vr1000.c            |    2 +-
 arch/arm/mach-s3c2412/mach-jive.c              |    2 +-
 arch/arm/mach-s3c2412/mach-smdk2413.c          |    6 ++--
 arch/arm/mach-s3c2412/mach-vstms.c             |    2 +-
 arch/arm/mach-s3c2416/mach-smdk2416.c          |    2 +-
 arch/arm/mach-s3c2440/mach-anubis.c            |    2 +-
 arch/arm/mach-s3c2440/mach-at2440evb.c         |    2 +-
 arch/arm/mach-s3c2440/mach-gta02.c             |    2 +-
 arch/arm/mach-s3c2440/mach-mini2440.c          |    2 +-
 arch/arm/mach-s3c2440/mach-nexcoder.c          |    2 +-
 arch/arm/mach-s3c2440/mach-osiris.c            |    2 +-
 arch/arm/mach-s3c2440/mach-rx1950.c            |    2 +-
 arch/arm/mach-s3c2440/mach-rx3715.c            |    2 +-
 arch/arm/mach-s3c2440/mach-smdk2440.c          |    2 +-
 arch/arm/mach-s3c2443/mach-smdk2443.c          |    2 +-
 arch/arm/mach-s3c64xx/mach-anw6410.c           |    2 +-
 arch/arm/mach-s3c64xx/mach-hmt.c               |    2 +-
 arch/arm/mach-s3c64xx/mach-mini6410.c          |    2 +-
 arch/arm/mach-s3c64xx/mach-ncp.c               |    2 +-
 arch/arm/mach-s3c64xx/mach-real6410.c          |    2 +-
 arch/arm/mach-s3c64xx/mach-smartq5.c           |    2 +-
 arch/arm/mach-s3c64xx/mach-smartq7.c           |    2 +-
 arch/arm/mach-s3c64xx/mach-smdk6400.c          |    2 +-
 arch/arm/mach-s3c64xx/mach-smdk6410.c          |    2 +-
 arch/arm/mach-s5p64x0/mach-smdk6440.c          |    2 +-
 arch/arm/mach-s5p64x0/mach-smdk6450.c          |    2 +-
 arch/arm/mach-s5pc100/mach-smdkc100.c          |    2 +-
 arch/arm/mach-s5pv210/mach-aquila.c            |    2 +-
 arch/arm/mach-s5pv210/mach-goni.c              |    2 +-
 arch/arm/mach-s5pv210/mach-smdkc110.c          |    2 +-
 arch/arm/mach-s5pv210/mach-smdkv210.c          |    2 +-
 arch/arm/mach-s5pv210/mach-torbreck.c          |    2 +-
 arch/arm/mach-sa1100/assabet.c                 |    2 +-
 arch/arm/mach-sa1100/badge4.c                  |    2 +-
 arch/arm/mach-sa1100/h3100.c                   |    2 +-
 arch/arm/mach-sa1100/h3600.c                   |    2 +-
 arch/arm/mach-sa1100/hackkit.c                 |    2 +-
 arch/arm/mach-sa1100/jornada720.c              |    2 +-
 arch/arm/mach-sa1100/lart.c                    |    2 +-
 arch/arm/mach-sa1100/nanoengine.c              |    2 +-
 arch/arm/mach-sa1100/shannon.c                 |    2 +-
 arch/arm/mach-sa1100/simpad.c                  |    2 +-
 arch/arm/mach-shark/core.c                     |    2 +-
 arch/arm/mach-spear3xx/spear300_evb.c          |    2 +-
 arch/arm/mach-spear3xx/spear310_evb.c          |    2 +-
 arch/arm/mach-spear3xx/spear320_evb.c          |    2 +-
 arch/arm/mach-spear6xx/spear600_evb.c          |    2 +-
 arch/arm/mach-tcc8k/board-tcc8000-sdk.c        |    2 +-
 arch/arm/mach-tegra/board-harmony.c            |    2 +-
 arch/arm/mach-tegra/board-paz00.c              |    2 +-
 arch/arm/mach-tegra/board-seaboard.c           |    6 ++--
 arch/arm/mach-tegra/board-trimslice.c          |    2 +-
 arch/arm/mach-u300/include/mach/memory.h       |    8 +++---
 arch/arm/mach-u300/u300.c                      |    2 +-
 arch/arm/mach-ux500/board-mop500.c             |    4 +-
 arch/arm/mach-ux500/board-u5500.c              |    2 +-
 arch/arm/mach-versatile/versatile_ab.c         |    2 +-
 arch/arm/mach-versatile/versatile_pb.c         |    2 +-
 arch/arm/mach-vexpress/v2m.c                   |    2 +-
 arch/arm/mach-vt8500/bv07.c                    |    2 +-
 arch/arm/mach-vt8500/wm8505_7in.c              |    2 +-
 arch/arm/mach-w90x900/mach-nuc910evb.c         |    1 -
 arch/arm/mach-w90x900/mach-nuc950evb.c         |    1 -
 arch/arm/mach-w90x900/mach-nuc960evb.c         |    1 -
 327 files changed, 388 insertions(+), 410 deletions(-)
