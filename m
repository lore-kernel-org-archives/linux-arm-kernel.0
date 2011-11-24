From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Thu, 24 Nov 2011 20:31:49 +0000
Subject: [PATCH 23/41] ARM: restart: mxc: use new restart hook
In-Reply-To: <E1RN6os-0001Y8-8c@rmk-PC.arm.linux.org.uk>
References: <20111106173113.GI12913@n2100.arm.linux.org.uk>
 <E1RN6os-0001Y8-8c@rmk-PC.arm.linux.org.uk>
Message-ID: <20111124203149.GS9581@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Ack?

On Sun, Nov 06, 2011 at 05:47:46PM +0000, Russell King - ARM Linux wrote:
> Hook these platforms restart code into the new restart hook rather
> than using arch_reset().
> 
> Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>
> ---
>  arch/arm/mach-imx/mach-apf9328.c            |    1 +
>  arch/arm/mach-imx/mach-armadillo5x0.c       |    1 +
>  arch/arm/mach-imx/mach-bug.c                |    1 +
>  arch/arm/mach-imx/mach-cpuimx27.c           |    1 +
>  arch/arm/mach-imx/mach-cpuimx35.c           |    1 +
>  arch/arm/mach-imx/mach-eukrea_cpuimx25.c    |    1 +
>  arch/arm/mach-imx/mach-imx27_visstrim_m10.c |    1 +
>  arch/arm/mach-imx/mach-imx27ipcam.c         |    1 +
>  arch/arm/mach-imx/mach-imx27lite.c          |    1 +
>  arch/arm/mach-imx/mach-imx6q.c              |    1 +
>  arch/arm/mach-imx/mach-kzm_arm11_01.c       |    1 +
>  arch/arm/mach-imx/mach-mx1ads.c             |    2 ++
>  arch/arm/mach-imx/mach-mx21ads.c            |    1 +
>  arch/arm/mach-imx/mach-mx25_3ds.c           |    1 +
>  arch/arm/mach-imx/mach-mx27_3ds.c           |    1 +
>  arch/arm/mach-imx/mach-mx27ads.c            |    1 +
>  arch/arm/mach-imx/mach-mx31_3ds.c           |    1 +
>  arch/arm/mach-imx/mach-mx31ads.c            |    1 +
>  arch/arm/mach-imx/mach-mx31lilly.c          |    1 +
>  arch/arm/mach-imx/mach-mx31lite.c           |    1 +
>  arch/arm/mach-imx/mach-mx31moboard.c        |    1 +
>  arch/arm/mach-imx/mach-mx35_3ds.c           |    1 +
>  arch/arm/mach-imx/mach-mxt_td60.c           |    1 +
>  arch/arm/mach-imx/mach-pca100.c             |    1 +
>  arch/arm/mach-imx/mach-pcm037.c             |    1 +
>  arch/arm/mach-imx/mach-pcm038.c             |    1 +
>  arch/arm/mach-imx/mach-pcm043.c             |    1 +
>  arch/arm/mach-imx/mach-qong.c               |    1 +
>  arch/arm/mach-imx/mach-scb9328.c            |    1 +
>  arch/arm/mach-imx/mach-vpr200.c             |    1 +
>  arch/arm/mach-mx5/board-cpuimx51.c          |    1 +
>  arch/arm/mach-mx5/board-cpuimx51sd.c        |    1 +
>  arch/arm/mach-mx5/board-mx50_rdp.c          |    1 +
>  arch/arm/mach-mx5/board-mx51_3ds.c          |    1 +
>  arch/arm/mach-mx5/board-mx51_babbage.c      |    1 +
>  arch/arm/mach-mx5/board-mx51_efikamx.c      |    3 ++-
>  arch/arm/mach-mx5/board-mx51_efikasb.c      |    1 +
>  arch/arm/mach-mx5/board-mx53_ard.c          |    1 +
>  arch/arm/mach-mx5/board-mx53_evk.c          |    1 +
>  arch/arm/mach-mx5/board-mx53_loco.c         |    1 +
>  arch/arm/mach-mx5/board-mx53_smd.c          |    1 +
>  arch/arm/mach-mx5/imx51-dt.c                |    1 +
>  arch/arm/mach-mx5/imx53-dt.c                |    1 +
>  arch/arm/plat-mxc/include/mach/common.h     |    2 +-
>  arch/arm/plat-mxc/include/mach/system.h     |    4 +++-
>  arch/arm/plat-mxc/system.c                  |    9 +--------
>  46 files changed, 50 insertions(+), 11 deletions(-)
> 
> diff --git a/arch/arm/mach-imx/mach-apf9328.c b/arch/arm/mach-imx/mach-apf9328.c
> index 1e486e6..146a4f0 100644
> --- a/arch/arm/mach-imx/mach-apf9328.c
> +++ b/arch/arm/mach-imx/mach-apf9328.c
> @@ -139,4 +139,5 @@ MACHINE_START(APF9328, "Armadeus APF9328")
>  	.handle_irq   = imx1_handle_irq,
>  	.timer        = &apf9328_timer,
>  	.init_machine = apf9328_init,
> +	.restart	= mxc_restart,
>  MACHINE_END
> diff --git a/arch/arm/mach-imx/mach-armadillo5x0.c b/arch/arm/mach-imx/mach-armadillo5x0.c
> index c9a9cf6..e4f426a 100644
> --- a/arch/arm/mach-imx/mach-armadillo5x0.c
> +++ b/arch/arm/mach-imx/mach-armadillo5x0.c
> @@ -561,4 +561,5 @@ MACHINE_START(ARMADILLO5X0, "Armadillo-500")
>  	.handle_irq = imx31_handle_irq,
>  	.timer = &armadillo5x0_timer,
>  	.init_machine = armadillo5x0_init,
> +	.restart	= mxc_restart,
>  MACHINE_END
> diff --git a/arch/arm/mach-imx/mach-bug.c b/arch/arm/mach-imx/mach-bug.c
> index 313f62d..9a98977 100644
> --- a/arch/arm/mach-imx/mach-bug.c
> +++ b/arch/arm/mach-imx/mach-bug.c
> @@ -65,4 +65,5 @@ MACHINE_START(BUG, "BugLabs BUGBase")
>  	.handle_irq = imx31_handle_irq,
>  	.timer = &bug_timer,
>  	.init_machine = bug_board_init,
> +	.restart	= mxc_restart,
>  MACHINE_END
> diff --git a/arch/arm/mach-imx/mach-cpuimx27.c b/arch/arm/mach-imx/mach-cpuimx27.c
> index edb3730..d085aea 100644
> --- a/arch/arm/mach-imx/mach-cpuimx27.c
> +++ b/arch/arm/mach-imx/mach-cpuimx27.c
> @@ -318,4 +318,5 @@ MACHINE_START(EUKREA_CPUIMX27, "EUKREA CPUIMX27")
>  	.handle_irq = imx27_handle_irq,
>  	.timer = &eukrea_cpuimx27_timer,
>  	.init_machine = eukrea_cpuimx27_init,
> +	.restart	= mxc_restart,
>  MACHINE_END
> diff --git a/arch/arm/mach-imx/mach-cpuimx35.c b/arch/arm/mach-imx/mach-cpuimx35.c
> index 66af2e8..012e120 100644
> --- a/arch/arm/mach-imx/mach-cpuimx35.c
> +++ b/arch/arm/mach-imx/mach-cpuimx35.c
> @@ -201,4 +201,5 @@ MACHINE_START(EUKREA_CPUIMX35SD, "Eukrea CPUIMX35")
>  	.handle_irq = imx35_handle_irq,
>  	.timer = &eukrea_cpuimx35_timer,
>  	.init_machine = eukrea_cpuimx35_init,
> +	.restart	= mxc_restart,
>  MACHINE_END
> diff --git a/arch/arm/mach-imx/mach-eukrea_cpuimx25.c b/arch/arm/mach-imx/mach-eukrea_cpuimx25.c
> index ab8fbcc..76a97a5 100644
> --- a/arch/arm/mach-imx/mach-eukrea_cpuimx25.c
> +++ b/arch/arm/mach-imx/mach-eukrea_cpuimx25.c
> @@ -170,4 +170,5 @@ MACHINE_START(EUKREA_CPUIMX25SD, "Eukrea CPUIMX25")
>  	.handle_irq = imx25_handle_irq,
>  	.timer = &eukrea_cpuimx25_timer,
>  	.init_machine = eukrea_cpuimx25_init,
> +	.restart	= mxc_restart,
>  MACHINE_END
> diff --git a/arch/arm/mach-imx/mach-imx27_visstrim_m10.c b/arch/arm/mach-imx/mach-imx27_visstrim_m10.c
> index 38eb9e4..c2766ae 100644
> --- a/arch/arm/mach-imx/mach-imx27_visstrim_m10.c
> +++ b/arch/arm/mach-imx/mach-imx27_visstrim_m10.c
> @@ -282,4 +282,5 @@ MACHINE_START(IMX27_VISSTRIM_M10, "Vista Silicon Visstrim_M10")
>  	.handle_irq = imx27_handle_irq,
>  	.timer = &visstrim_m10_timer,
>  	.init_machine = visstrim_m10_board_init,
> +	.restart	= mxc_restart,
>  MACHINE_END
> diff --git a/arch/arm/mach-imx/mach-imx27ipcam.c b/arch/arm/mach-imx/mach-imx27ipcam.c
> index 7052155..c9d350c 100644
> --- a/arch/arm/mach-imx/mach-imx27ipcam.c
> +++ b/arch/arm/mach-imx/mach-imx27ipcam.c
> @@ -78,4 +78,5 @@ MACHINE_START(IMX27IPCAM, "Freescale IMX27IPCAM")
>  	.handle_irq = imx27_handle_irq,
>  	.timer = &mx27ipcam_timer,
>  	.init_machine = mx27ipcam_init,
> +	.restart	= mxc_restart,
>  MACHINE_END
> diff --git a/arch/arm/mach-imx/mach-imx27lite.c b/arch/arm/mach-imx/mach-imx27lite.c
> index 8d6a635..1f45b91 100644
> --- a/arch/arm/mach-imx/mach-imx27lite.c
> +++ b/arch/arm/mach-imx/mach-imx27lite.c
> @@ -84,4 +84,5 @@ MACHINE_START(IMX27LITE, "LogicPD i.MX27LITE")
>  	.handle_irq = imx27_handle_irq,
>  	.timer = &mx27lite_timer,
>  	.init_machine = mx27lite_init,
> +	.restart	= mxc_restart,
>  MACHINE_END
> diff --git a/arch/arm/mach-imx/mach-imx6q.c b/arch/arm/mach-imx/mach-imx6q.c
> index 8bf5fa3..dc8b6e2 100644
> --- a/arch/arm/mach-imx/mach-imx6q.c
> +++ b/arch/arm/mach-imx/mach-imx6q.c
> @@ -81,4 +81,5 @@ DT_MACHINE_START(IMX6Q, "Freescale i.MX6 Quad (Device Tree)")
>  	.timer		= &imx6q_timer,
>  	.init_machine	= imx6q_init_machine,
>  	.dt_compat	= imx6q_dt_compat,
> +	.restart	= mxc_restart,
>  MACHINE_END
> diff --git a/arch/arm/mach-imx/mach-kzm_arm11_01.c b/arch/arm/mach-imx/mach-kzm_arm11_01.c
> index 5f37f89..fc78e80 100644
> --- a/arch/arm/mach-imx/mach-kzm_arm11_01.c
> +++ b/arch/arm/mach-imx/mach-kzm_arm11_01.c
> @@ -279,4 +279,5 @@ MACHINE_START(KZM_ARM11_01, "Kyoto Microcomputer Co., Ltd. KZM-ARM11-01")
>  	.handle_irq = imx31_handle_irq,
>  	.timer = &kzm_timer,
>  	.init_machine = kzm_board_init,
> +	.restart	= mxc_restart,
>  MACHINE_END
> diff --git a/arch/arm/mach-imx/mach-mx1ads.c b/arch/arm/mach-imx/mach-mx1ads.c
> index fc49785..9704608 100644
> --- a/arch/arm/mach-imx/mach-mx1ads.c
> +++ b/arch/arm/mach-imx/mach-mx1ads.c
> @@ -147,6 +147,7 @@ MACHINE_START(MX1ADS, "Freescale MX1ADS")
>  	.handle_irq = imx1_handle_irq,
>  	.timer = &mx1ads_timer,
>  	.init_machine = mx1ads_init,
> +	.restart	= mxc_restart,
>  MACHINE_END
>  
>  MACHINE_START(MXLADS, "Freescale MXLADS")
> @@ -157,4 +158,5 @@ MACHINE_START(MXLADS, "Freescale MXLADS")
>  	.handle_irq = imx1_handle_irq,
>  	.timer = &mx1ads_timer,
>  	.init_machine = mx1ads_init,
> +	.restart	= mxc_restart,
>  MACHINE_END
> diff --git a/arch/arm/mach-imx/mach-mx21ads.c b/arch/arm/mach-imx/mach-mx21ads.c
> index 25f8402..8d9f955 100644
> --- a/arch/arm/mach-imx/mach-mx21ads.c
> +++ b/arch/arm/mach-imx/mach-mx21ads.c
> @@ -312,4 +312,5 @@ MACHINE_START(MX21ADS, "Freescale i.MX21ADS")
>  	.handle_irq = imx21_handle_irq,
>  	.timer = &mx21ads_timer,
>  	.init_machine = mx21ads_board_init,
> +	.restart	= mxc_restart,
>  MACHINE_END
> diff --git a/arch/arm/mach-imx/mach-mx25_3ds.c b/arch/arm/mach-imx/mach-mx25_3ds.c
> index 88dccf1..f267342 100644
> --- a/arch/arm/mach-imx/mach-mx25_3ds.c
> +++ b/arch/arm/mach-imx/mach-mx25_3ds.c
> @@ -270,4 +270,5 @@ MACHINE_START(MX25_3DS, "Freescale MX25PDK (3DS)")
>  	.handle_irq = imx25_handle_irq,
>  	.timer = &mx25pdk_timer,
>  	.init_machine = mx25pdk_init,
> +	.restart	= mxc_restart,
>  MACHINE_END
> diff --git a/arch/arm/mach-imx/mach-mx27_3ds.c b/arch/arm/mach-imx/mach-mx27_3ds.c
> index ba232d7..18f3581 100644
> --- a/arch/arm/mach-imx/mach-mx27_3ds.c
> +++ b/arch/arm/mach-imx/mach-mx27_3ds.c
> @@ -425,4 +425,5 @@ MACHINE_START(MX27_3DS, "Freescale MX27PDK")
>  	.handle_irq = imx27_handle_irq,
>  	.timer = &mx27pdk_timer,
>  	.init_machine = mx27pdk_init,
> +	.restart	= mxc_restart,
>  MACHINE_END
> diff --git a/arch/arm/mach-imx/mach-mx27ads.c b/arch/arm/mach-imx/mach-mx27ads.c
> index 74dd573..0228d2e 100644
> --- a/arch/arm/mach-imx/mach-mx27ads.c
> +++ b/arch/arm/mach-imx/mach-mx27ads.c
> @@ -351,4 +351,5 @@ MACHINE_START(MX27ADS, "Freescale i.MX27ADS")
>  	.handle_irq = imx27_handle_irq,
>  	.timer = &mx27ads_timer,
>  	.init_machine = mx27ads_board_init,
> +	.restart	= mxc_restart,
>  MACHINE_END
> diff --git a/arch/arm/mach-imx/mach-mx31_3ds.c b/arch/arm/mach-imx/mach-mx31_3ds.c
> index b8c54b8..2b565c3 100644
> --- a/arch/arm/mach-imx/mach-mx31_3ds.c
> +++ b/arch/arm/mach-imx/mach-mx31_3ds.c
> @@ -770,4 +770,5 @@ MACHINE_START(MX31_3DS, "Freescale MX31PDK (3DS)")
>  	.timer = &mx31_3ds_timer,
>  	.init_machine = mx31_3ds_init,
>  	.reserve = mx31_3ds_reserve,
> +	.restart	= mxc_restart,
>  MACHINE_END
> diff --git a/arch/arm/mach-imx/mach-mx31ads.c b/arch/arm/mach-imx/mach-mx31ads.c
> index 9cc1a49..4917aab 100644
> --- a/arch/arm/mach-imx/mach-mx31ads.c
> +++ b/arch/arm/mach-imx/mach-mx31ads.c
> @@ -542,4 +542,5 @@ MACHINE_START(MX31ADS, "Freescale MX31ADS")
>  	.handle_irq = imx31_handle_irq,
>  	.timer = &mx31ads_timer,
>  	.init_machine = mx31ads_init,
> +	.restart	= mxc_restart,
>  MACHINE_END
> diff --git a/arch/arm/mach-imx/mach-mx31lilly.c b/arch/arm/mach-imx/mach-mx31lilly.c
> index 5defd8e..1e0db94 100644
> --- a/arch/arm/mach-imx/mach-mx31lilly.c
> +++ b/arch/arm/mach-imx/mach-mx31lilly.c
> @@ -302,4 +302,5 @@ MACHINE_START(LILLY1131, "INCO startec LILLY-1131")
>  	.handle_irq = imx31_handle_irq,
>  	.timer = &mx31lilly_timer,
>  	.init_machine = mx31lilly_board_init,
> +	.restart	= mxc_restart,
>  MACHINE_END
> diff --git a/arch/arm/mach-imx/mach-mx31lite.c b/arch/arm/mach-imx/mach-mx31lite.c
> index 05f1c71..67e538d 100644
> --- a/arch/arm/mach-imx/mach-mx31lite.c
> +++ b/arch/arm/mach-imx/mach-mx31lite.c
> @@ -286,4 +286,5 @@ MACHINE_START(MX31LITE, "LogicPD i.MX31 SOM")
>  	.handle_irq = imx31_handle_irq,
>  	.timer = &mx31lite_timer,
>  	.init_machine = mx31lite_init,
> +	.restart	= mxc_restart,
>  MACHINE_END
> diff --git a/arch/arm/mach-imx/mach-mx31moboard.c b/arch/arm/mach-imx/mach-mx31moboard.c
> index 07034f4..f1e1b7d 100644
> --- a/arch/arm/mach-imx/mach-mx31moboard.c
> +++ b/arch/arm/mach-imx/mach-mx31moboard.c
> @@ -599,4 +599,5 @@ MACHINE_START(MX31MOBOARD, "EPFL Mobots mx31moboard")
>  	.handle_irq = imx31_handle_irq,
>  	.timer = &mx31moboard_timer,
>  	.init_machine = mx31moboard_init,
> +	.restart	= mxc_restart,
>  MACHINE_END
> diff --git a/arch/arm/mach-imx/mach-mx35_3ds.c b/arch/arm/mach-imx/mach-mx35_3ds.c
> index 7a46202..0af6c9c 100644
> --- a/arch/arm/mach-imx/mach-mx35_3ds.c
> +++ b/arch/arm/mach-imx/mach-mx35_3ds.c
> @@ -224,4 +224,5 @@ MACHINE_START(MX35_3DS, "Freescale MX35PDK")
>  	.handle_irq = imx35_handle_irq,
>  	.timer = &mx35pdk_timer,
>  	.init_machine = mx35_3ds_init,
> +	.restart	= mxc_restart,
>  MACHINE_END
> diff --git a/arch/arm/mach-imx/mach-mxt_td60.c b/arch/arm/mach-imx/mach-mxt_td60.c
> index 125c196..8b3d3f0 100644
> --- a/arch/arm/mach-imx/mach-mxt_td60.c
> +++ b/arch/arm/mach-imx/mach-mxt_td60.c
> @@ -274,4 +274,5 @@ MACHINE_START(MXT_TD60, "Maxtrack i-MXT TD60")
>  	.handle_irq = imx27_handle_irq,
>  	.timer = &mxt_td60_timer,
>  	.init_machine = mxt_td60_board_init,
> +	.restart	= mxc_restart,
>  MACHINE_END
> diff --git a/arch/arm/mach-imx/mach-pca100.c b/arch/arm/mach-imx/mach-pca100.c
> index 26072f4..d3b9c6b 100644
> --- a/arch/arm/mach-imx/mach-pca100.c
> +++ b/arch/arm/mach-imx/mach-pca100.c
> @@ -442,4 +442,5 @@ MACHINE_START(PCA100, "phyCARD-i.MX27")
>  	.handle_irq = imx27_handle_irq,
>  	.init_machine = pca100_init,
>  	.timer = &pca100_timer,
> +	.restart	= mxc_restart,
>  MACHINE_END
> diff --git a/arch/arm/mach-imx/mach-pcm037.c b/arch/arm/mach-imx/mach-pcm037.c
> index efd6b53..d7e1516 100644
> --- a/arch/arm/mach-imx/mach-pcm037.c
> +++ b/arch/arm/mach-imx/mach-pcm037.c
> @@ -696,4 +696,5 @@ MACHINE_START(PCM037, "Phytec Phycore pcm037")
>  	.handle_irq = imx31_handle_irq,
>  	.timer = &pcm037_timer,
>  	.init_machine = pcm037_init,
> +	.restart	= mxc_restart,
>  MACHINE_END
> diff --git a/arch/arm/mach-imx/mach-pcm038.c b/arch/arm/mach-imx/mach-pcm038.c
> index a17e9c7..16f126d 100644
> --- a/arch/arm/mach-imx/mach-pcm038.c
> +++ b/arch/arm/mach-imx/mach-pcm038.c
> @@ -357,4 +357,5 @@ MACHINE_START(PCM038, "phyCORE-i.MX27")
>  	.handle_irq = imx27_handle_irq,
>  	.timer = &pcm038_timer,
>  	.init_machine = pcm038_init,
> +	.restart	= mxc_restart,
>  MACHINE_END
> diff --git a/arch/arm/mach-imx/mach-pcm043.c b/arch/arm/mach-imx/mach-pcm043.c
> index 7366c2a..06dc106 100644
> --- a/arch/arm/mach-imx/mach-pcm043.c
> +++ b/arch/arm/mach-imx/mach-pcm043.c
> @@ -425,4 +425,5 @@ MACHINE_START(PCM043, "Phytec Phycore pcm043")
>  	.handle_irq = imx35_handle_irq,
>  	.timer = &pcm043_timer,
>  	.init_machine = pcm043_init,
> +	.restart	= mxc_restart,
>  MACHINE_END
> diff --git a/arch/arm/mach-imx/mach-qong.c b/arch/arm/mach-imx/mach-qong.c
> index 4ff5faf..2606210 100644
> --- a/arch/arm/mach-imx/mach-qong.c
> +++ b/arch/arm/mach-imx/mach-qong.c
> @@ -273,4 +273,5 @@ MACHINE_START(QONG, "Dave/DENX QongEVB-LITE")
>  	.handle_irq = imx31_handle_irq,
>  	.timer = &qong_timer,
>  	.init_machine = qong_init,
> +	.restart	= mxc_restart,
>  MACHINE_END
> diff --git a/arch/arm/mach-imx/mach-scb9328.c b/arch/arm/mach-imx/mach-scb9328.c
> index bb6e5b2..cb9ceae 100644
> --- a/arch/arm/mach-imx/mach-scb9328.c
> +++ b/arch/arm/mach-imx/mach-scb9328.c
> @@ -144,4 +144,5 @@ MACHINE_START(SCB9328, "Synertronixx scb9328")
>  	.handle_irq = imx1_handle_irq,
>  	.timer = &scb9328_timer,
>  	.init_machine = scb9328_init,
> +	.restart	= mxc_restart,
>  MACHINE_END
> diff --git a/arch/arm/mach-imx/mach-vpr200.c b/arch/arm/mach-imx/mach-vpr200.c
> index 6909245..033257e 100644
> --- a/arch/arm/mach-imx/mach-vpr200.c
> +++ b/arch/arm/mach-imx/mach-vpr200.c
> @@ -322,4 +322,5 @@ MACHINE_START(VPR200, "VPR200")
>  	.handle_irq = imx35_handle_irq,
>  	.timer = &vpr200_timer,
>  	.init_machine = vpr200_board_init,
> +	.restart	= mxc_restart,
>  MACHINE_END
> diff --git a/arch/arm/mach-mx5/board-cpuimx51.c b/arch/arm/mach-mx5/board-cpuimx51.c
> index 1fc1103..944025d 100644
> --- a/arch/arm/mach-mx5/board-cpuimx51.c
> +++ b/arch/arm/mach-mx5/board-cpuimx51.c
> @@ -297,4 +297,5 @@ MACHINE_START(EUKREA_CPUIMX51, "Eukrea CPUIMX51 Module")
>  	.handle_irq = imx51_handle_irq,
>  	.timer = &mxc_timer,
>  	.init_machine = eukrea_cpuimx51_init,
> +	.restart	= mxc_restart,
>  MACHINE_END
> diff --git a/arch/arm/mach-mx5/board-cpuimx51sd.c b/arch/arm/mach-mx5/board-cpuimx51sd.c
> index 52a11c1..9fbe923 100644
> --- a/arch/arm/mach-mx5/board-cpuimx51sd.c
> +++ b/arch/arm/mach-mx5/board-cpuimx51sd.c
> @@ -335,4 +335,5 @@ MACHINE_START(EUKREA_CPUIMX51SD, "Eukrea CPUIMX51SD")
>  	.handle_irq = imx51_handle_irq,
>  	.timer = &mxc_timer,
>  	.init_machine = eukrea_cpuimx51sd_init,
> +	.restart	= mxc_restart,
>  MACHINE_END
> diff --git a/arch/arm/mach-mx5/board-mx50_rdp.c b/arch/arm/mach-mx5/board-mx50_rdp.c
> index fc3621d..42b66e8 100644
> --- a/arch/arm/mach-mx5/board-mx50_rdp.c
> +++ b/arch/arm/mach-mx5/board-mx50_rdp.c
> @@ -222,4 +222,5 @@ MACHINE_START(MX50_RDP, "Freescale MX50 Reference Design Platform")
>  	.handle_irq = imx50_handle_irq,
>  	.timer = &mx50_rdp_timer,
>  	.init_machine = mx50_rdp_board_init,
> +	.restart	= mxc_restart,
>  MACHINE_END
> diff --git a/arch/arm/mach-mx5/board-mx51_3ds.c b/arch/arm/mach-mx5/board-mx51_3ds.c
> index 0578390..83eab41 100644
> --- a/arch/arm/mach-mx5/board-mx51_3ds.c
> +++ b/arch/arm/mach-mx5/board-mx51_3ds.c
> @@ -175,4 +175,5 @@ MACHINE_START(MX51_3DS, "Freescale MX51 3-Stack Board")
>  	.handle_irq = imx51_handle_irq,
>  	.timer = &mx51_3ds_timer,
>  	.init_machine = mx51_3ds_init,
> +	.restart	= mxc_restart,
>  MACHINE_END
> diff --git a/arch/arm/mach-mx5/board-mx51_babbage.c b/arch/arm/mach-mx5/board-mx51_babbage.c
> index 5c83760..68cdfda 100644
> --- a/arch/arm/mach-mx5/board-mx51_babbage.c
> +++ b/arch/arm/mach-mx5/board-mx51_babbage.c
> @@ -426,4 +426,5 @@ MACHINE_START(MX51_BABBAGE, "Freescale MX51 Babbage Board")
>  	.handle_irq = imx51_handle_irq,
>  	.timer = &mx51_babbage_timer,
>  	.init_machine = mx51_babbage_init,
> +	.restart	= mxc_restart,
>  MACHINE_END
> diff --git a/arch/arm/mach-mx5/board-mx51_efikamx.c b/arch/arm/mach-mx5/board-mx51_efikamx.c
> index a9e4866..3a5ed2d 100644
> --- a/arch/arm/mach-mx5/board-mx51_efikamx.c
> +++ b/arch/arm/mach-mx5/board-mx51_efikamx.c
> @@ -182,7 +182,7 @@ static const struct gpio_keys_platform_data mx51_efikamx_powerkey_data __initcon
>  	.nbuttons = ARRAY_SIZE(mx51_efikamx_powerkey),
>  };
>  
> -void mx51_efikamx_reset(void)
> +static void mx51_efikamx_restart(char mode, const char *cmd)
>  {
>  	if (system_rev == 0x11)
>  		gpio_direction_output(EFIKAMX_RESET1_1, 0);
> @@ -292,4 +292,5 @@ MACHINE_START(MX51_EFIKAMX, "Genesi EfikaMX nettop")
>  	.handle_irq = imx51_handle_irq,
>  	.timer = &mx51_efikamx_timer,
>  	.init_machine = mx51_efikamx_init,
> +	.restart = mx51_efikamx_restart,
>  MACHINE_END
> diff --git a/arch/arm/mach-mx5/board-mx51_efikasb.c b/arch/arm/mach-mx5/board-mx51_efikasb.c
> index 38c4a3e..ea5f65b 100644
> --- a/arch/arm/mach-mx5/board-mx51_efikasb.c
> +++ b/arch/arm/mach-mx5/board-mx51_efikasb.c
> @@ -287,4 +287,5 @@ MACHINE_START(MX51_EFIKASB, "Genesi Efika Smartbook")
>  	.handle_irq = imx51_handle_irq,
>  	.init_machine =  efikasb_board_init,
>  	.timer = &mx51_efikasb_timer,
> +	.restart	= mxc_restart,
>  MACHINE_END
> diff --git a/arch/arm/mach-mx5/board-mx53_ard.c b/arch/arm/mach-mx5/board-mx53_ard.c
> index 0d7f0ff..5f224f1 100644
> --- a/arch/arm/mach-mx5/board-mx53_ard.c
> +++ b/arch/arm/mach-mx5/board-mx53_ard.c
> @@ -257,4 +257,5 @@ MACHINE_START(MX53_ARD, "Freescale MX53 ARD Board")
>  	.handle_irq = imx53_handle_irq,
>  	.timer = &mx53_ard_timer,
>  	.init_machine = mx53_ard_board_init,
> +	.restart	= mxc_restart,
>  MACHINE_END
> diff --git a/arch/arm/mach-mx5/board-mx53_evk.c b/arch/arm/mach-mx5/board-mx53_evk.c
> index 6bea31a..c2d27cf 100644
> --- a/arch/arm/mach-mx5/board-mx53_evk.c
> +++ b/arch/arm/mach-mx5/board-mx53_evk.c
> @@ -175,4 +175,5 @@ MACHINE_START(MX53_EVK, "Freescale MX53 EVK Board")
>  	.handle_irq = imx53_handle_irq,
>  	.timer = &mx53_evk_timer,
>  	.init_machine = mx53_evk_board_init,
> +	.restart	= mxc_restart,
>  MACHINE_END
> diff --git a/arch/arm/mach-mx5/board-mx53_loco.c b/arch/arm/mach-mx5/board-mx53_loco.c
> index 7678f77..62f4aa3 100644
> --- a/arch/arm/mach-mx5/board-mx53_loco.c
> +++ b/arch/arm/mach-mx5/board-mx53_loco.c
> @@ -317,4 +317,5 @@ MACHINE_START(MX53_LOCO, "Freescale MX53 LOCO Board")
>  	.handle_irq = imx53_handle_irq,
>  	.timer = &mx53_loco_timer,
>  	.init_machine = mx53_loco_board_init,
> +	.restart	= mxc_restart,
>  MACHINE_END
> diff --git a/arch/arm/mach-mx5/board-mx53_smd.c b/arch/arm/mach-mx5/board-mx53_smd.c
> index 59c0845..2a78e62 100644
> --- a/arch/arm/mach-mx5/board-mx53_smd.c
> +++ b/arch/arm/mach-mx5/board-mx53_smd.c
> @@ -164,4 +164,5 @@ MACHINE_START(MX53_SMD, "Freescale MX53 SMD Board")
>  	.handle_irq = imx53_handle_irq,
>  	.timer = &mx53_smd_timer,
>  	.init_machine = mx53_smd_board_init,
> +	.restart	= mxc_restart,
>  MACHINE_END
> diff --git a/arch/arm/mach-mx5/imx51-dt.c b/arch/arm/mach-mx5/imx51-dt.c
> index ccc6158..edf2c4c 100644
> --- a/arch/arm/mach-mx5/imx51-dt.c
> +++ b/arch/arm/mach-mx5/imx51-dt.c
> @@ -113,4 +113,5 @@ DT_MACHINE_START(IMX51_DT, "Freescale i.MX51 (Device Tree Support)")
>  	.timer		= &imx51_timer,
>  	.init_machine	= imx51_dt_init,
>  	.dt_compat	= imx51_dt_board_compat,
> +	.restart	= mxc_restart,
>  MACHINE_END
> diff --git a/arch/arm/mach-mx5/imx53-dt.c b/arch/arm/mach-mx5/imx53-dt.c
> index ccaa0b8..106070a 100644
> --- a/arch/arm/mach-mx5/imx53-dt.c
> +++ b/arch/arm/mach-mx5/imx53-dt.c
> @@ -123,4 +123,5 @@ DT_MACHINE_START(IMX53_DT, "Freescale i.MX53 (Device Tree Support)")
>  	.timer		= &imx53_timer,
>  	.init_machine	= imx53_dt_init,
>  	.dt_compat	= imx53_dt_board_compat,
> +	.restart	= mxc_restart,
>  MACHINE_END
> diff --git a/arch/arm/plat-mxc/include/mach/common.h b/arch/arm/plat-mxc/include/mach/common.h
> index 83b745a..4ee98d5 100644
> --- a/arch/arm/plat-mxc/include/mach/common.h
> +++ b/arch/arm/plat-mxc/include/mach/common.h
> @@ -71,8 +71,8 @@ extern int mx6q_clocks_init(void);
>  extern struct platform_device *mxc_register_gpio(char *name, int id,
>  	resource_size_t iobase, resource_size_t iosize, int irq, int irq_high);
>  extern void mxc_set_cpu_type(unsigned int type);
> +extern void mxc_restart(char, const char *);
>  extern void mxc_arch_reset_init(void __iomem *);
> -extern void mx51_efikamx_reset(void);
>  extern int mx53_revision(void);
>  extern int mx53_display_revision(void);
>  
> diff --git a/arch/arm/plat-mxc/include/mach/system.h b/arch/arm/plat-mxc/include/mach/system.h
> index cf88b35..22b8911 100644
> --- a/arch/arm/plat-mxc/include/mach/system.h
> +++ b/arch/arm/plat-mxc/include/mach/system.h
> @@ -27,6 +27,8 @@ static inline void arch_idle(void)
>  		cpu_do_idle();
>  }
>  
> -void arch_reset(char mode, const char *cmd);
> +static inline void arch_reset(char mode, const char *cmd)
> +{
> +}
>  
>  #endif /* __ASM_ARCH_MXC_SYSTEM_H__ */
> diff --git a/arch/arm/plat-mxc/system.c b/arch/arm/plat-mxc/system.c
> index b1cfc6a..80de9e2 100644
> --- a/arch/arm/plat-mxc/system.c
> +++ b/arch/arm/plat-mxc/system.c
> @@ -36,17 +36,10 @@ static void __iomem *wdog_base;
>  /*
>   * Reset the system. It is called by machine_restart().
>   */
> -void arch_reset(char mode, const char *cmd)
> +void mxc_restart(char mode, const char *cmd)
>  {
>  	unsigned int wcr_enable;
>  
> -#ifdef CONFIG_MACH_MX51_EFIKAMX
> -	if (machine_is_mx51_efikamx()) {
> -		mx51_efikamx_reset();
> -		return;
> -	}
> -#endif
> -
>  	if (cpu_is_mx1()) {
>  		wcr_enable = (1 << 0);
>  	} else {
> -- 
> 1.7.4.4
> 
> 
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel at lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
