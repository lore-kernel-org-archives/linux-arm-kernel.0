From: srinivas.kandagatla@st.com (srinivas kandagatla)
Date: Thu, 14 Nov 2013 10:32:16 +0000
Subject: [PATCH 1/2] ARM: sti: only select errata 764369 if SMP
In-Reply-To: <1384389974-6229-1-git-send-email-olof@lixom.net>
References: <1384389974-6229-1-git-send-email-olof@lixom.net>
Message-ID: <5284A6B0.5060002@st.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Thanks for the patch.

Acked-by: Srinivas Kandagatla <srinivas.kandagatla@st.com>


On 14/11/13 00:46, Olof Johansson wrote:
> 764369 depends on SMP, so don't select it on !SMP configs.
> 
> Signed-off-by: Olof Johansson <olof@lixom.net>
> Cc: Srinivas Kandagatla <srinivas.kandagatla@st.com>
> Cc: Stuart Menefy <stuart.menefy@st.com>
> ---
>  arch/arm/mach-sti/Kconfig | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/arch/arm/mach-sti/Kconfig b/arch/arm/mach-sti/Kconfig
> index 835833e3c4f8..939ddb8f482b 100644
> --- a/arch/arm/mach-sti/Kconfig
> +++ b/arch/arm/mach-sti/Kconfig
> @@ -12,7 +12,7 @@ menuconfig ARCH_STI
>  	select HAVE_ARM_SCU if SMP
>  	select ARCH_REQUIRE_GPIOLIB
>  	select ARM_ERRATA_754322
> -	select ARM_ERRATA_764369
> +	select ARM_ERRATA_764369 if SMP
>  	select ARM_ERRATA_775420
>  	select PL310_ERRATA_753970 if CACHE_PL310
>  	select PL310_ERRATA_769419 if CACHE_PL310
> 
