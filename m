From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Mon, 27 Feb 2017 09:25:14 +0100
Subject: [PATCH v5 1/7] arm64: allwinner: Kconfig: add essential pinctrl
 driver for H5
In-Reply-To: <20170226011956.53581-2-icenowy@aosc.xyz>
References: <20170226011956.53581-1-icenowy@aosc.xyz>
 <20170226011956.53581-2-icenowy@aosc.xyz>
Message-ID: <20170227082514.54umfltn5xmdcpv3@lukather>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, Feb 26, 2017 at 09:19:50AM +0800, Icenowy Zheng wrote:
> H5 SoC has two pin controllers, one (in user manual called "CPUx") needs
> a slightly advanced driver, and the other (called "CPUs") is just equal
> to the on in H3, and the H3 driver can be just reused.
> 
> Select the two necessary pinctrl drivers when building kernel for
> Allwinner SoCs.
> 
> Also add H5 in the option's description.
> 
> Signed-off-by: Icenowy Zheng <icenowy@aosc.xyz>
> ---
>  arch/arm64/Kconfig.platforms | 5 ++++-
>  1 file changed, 4 insertions(+), 1 deletion(-)
> 
> diff --git a/arch/arm64/Kconfig.platforms b/arch/arm64/Kconfig.platforms
> index 129cc5ae4091..81f0d6149c2e 100644
> --- a/arch/arm64/Kconfig.platforms
> +++ b/arch/arm64/Kconfig.platforms
> @@ -5,8 +5,11 @@ config ARCH_SUNXI
>  	select GENERIC_IRQ_CHIP
>  	select PINCTRL
>  	select PINCTRL_SUN50I_A64
> +	select PINCTRL_SUN50I_H5
> +	select PINCTRL_SUN8I_H3_R

Why not add those options as def_bool instead?

Being able to remove them certainly have values if you want to strip
them down.

>  	help
> -	  This enables support for Allwinner sunxi based SoCs like the A64.
> +	  This enables support for Allwinner sunxi based SoCs like the A64
> +	  and H5.

There's no point in having an ever growing list of SoCs here. You can
just remove the mention of the A64.

Maxime

-- 
Maxime Ripard, Free Electrons
Embedded Linux and Kernel engineering
http://free-electrons.com
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 801 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20170227/eb496976/attachment.sig>
