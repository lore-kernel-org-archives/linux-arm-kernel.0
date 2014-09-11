From: khiem.nguyen.xt@renesas.com (Khiem Nguyen)
Date: Thu, 11 Sep 2014 09:59:57 +0900
Subject: [PATCH] ARM: shmobile: Enable r8a7794 SoC in shmobile_defconfig
In-Reply-To: <1410309887-15492-1-git-send-email-horms+renesas@verge.net.au>
References: <1410309887-15492-1-git-send-email-horms+renesas@verge.net.au>
Message-ID: <5410F40D.7090704@renesas.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Simon, 
cc Ulrich,

Thanks for your patch.

I think it's a bit early to enable r8a7794
in shmobile_defconfig.

The accepted part of r8a7794 initial code lacked of
arch. timer initialization code for Cortex-A7 in r8a7794 SoC.
[PATCH 1/3] ARM: shmobile: rcar-gen2: Add CA7 arch_timer initialization for r8a7794
http://www.spinics.net/lists/linux-sh/msg34978.html

I guess (at least) that code should be merged (in current form or another)
before r8a7794 can be enabled in shmobile_defconfig.

On 9/10/2014 9:44 AM, Simon Horman wrote:
> Support for the r8a7794 was recently added.
> Enable it in the shmobile_defconfig to increase build coverage.

IMO, the support is only enabled after the code under that config
run correctly.
Please correct me if I'm wrong.

> Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
> ---
> 
> Based on renesas-devel-20140910v2-v3.17-rc4
>  arch/arm/configs/shmobile_defconfig | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/arch/arm/configs/shmobile_defconfig b/arch/arm/configs/shmobile_defconfig
> index 522275a..d7346ad 100644
> --- a/arch/arm/configs/shmobile_defconfig
> +++ b/arch/arm/configs/shmobile_defconfig
> @@ -16,6 +16,7 @@ CONFIG_ARCH_R8A7740=y
>  CONFIG_ARCH_R8A7779=y
>  CONFIG_ARCH_R8A7790=y
>  CONFIG_ARCH_R8A7791=y
> +CONFIG_ARCH_R8A7794=y
>  CONFIG_MACH_KOELSCH=y
>  CONFIG_MACH_LAGER=y
>  CONFIG_MACH_MARZEN=y
> 

-- 
Best regards,
KHIEM Nguyen
