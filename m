From: sshtylyov@mvista.com (Sergei Shtylyov)
Date: Wed, 17 Nov 2010 16:13:56 +0300
Subject: [PATCH 5/9] ARM: mmp: select CPU_PJ4
In-Reply-To: <1289991823-24677-5-git-send-email-haojian.zhuang@marvell.com>
References: <1289991823-24677-1-git-send-email-haojian.zhuang@marvell.com>	<1289991823-24677-2-git-send-email-haojian.zhuang@marvell.com>	<1289991823-24677-3-git-send-email-haojian.zhuang@marvell.com>	<1289991823-24677-4-git-send-email-haojian.zhuang@marvell.com>
	<1289991823-24677-5-git-send-email-haojian.zhuang@marvell.com>
Message-ID: <4CE3D514.8080404@ru.mvista.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello.

On 17-11-2010 14:03, Haojian Zhuang wrote:

> Since CPU_PJ4 is shared between PXA95x and MMP2, select CPU_PJ4 in MMP2
> configuration.

> Signed-off-by: Haojian Zhuang<haojian.zhuang@marvell.com>
> Cc: Eric Miao<eric.y.miao@gmail.com>
[...]

> diff --git a/arch/arm/mach-mmp/Kconfig b/arch/arm/mach-mmp/Kconfig
> index 0711d3b..ab39b1e 100644
> --- a/arch/arm/mach-mmp/Kconfig
> +++ b/arch/arm/mach-mmp/Kconfig
> @@ -39,6 +39,7 @@ config MACH_TTC_DKB
>
>   config MACH_FLINT
>   	bool "Marvell's Flint Development Platform"
> +	depends on !(CPU_MOHAWK)

    () not needed.

>   	select CPU_MMP2
>   	help
>   	  Say 'Y' here if you want to support the Marvell MMP2-based
> @@ -49,6 +50,7 @@ config MACH_FLINT
>
>   config MACH_MARVELL_JASPER
>   	bool "Marvell's Jasper Development Platform"
> +	depends on !(CPU_MOHAWK)

    Likewise...

WBR, Sergei
