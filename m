From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Wed, 24 Sep 2014 08:39:02 +0200
Subject: [PATCH 2/6] ARM: sunxi: Add debug uart used by sun9i (Allwinner
 A80)
In-Reply-To: <1411311493-24344-3-git-send-email-wens@csie.org>
References: <1411311493-24344-1-git-send-email-wens@csie.org>
 <1411311493-24344-3-git-send-email-wens@csie.org>
Message-ID: <20140924063902.GR15315@lukather>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, Sep 21, 2014 at 10:58:09PM +0800, Chen-Yu Tsai wrote:
> The uarts on sun9i are still compatible with the dw_8250, but are
> located at different addresses.
> 
> Signed-off-by: Chen-Yu Tsai <wens@csie.org>
> ---
>  arch/arm/Kconfig.debug | 10 ++++++++++
>  1 file changed, 10 insertions(+)
> 
> diff --git a/arch/arm/Kconfig.debug b/arch/arm/Kconfig.debug
> index b11ad54..58b5218 100644
> --- a/arch/arm/Kconfig.debug
> +++ b/arch/arm/Kconfig.debug
> @@ -707,6 +707,14 @@ choice
>  		  Say Y here if you want kernel low-level debugging support
>  		  on SOCFPGA based platforms.
>  
> +	config DEBUG_SUN9I_UART0
> +		bool "Kernel low-level debugging messages via sun9i UART0"
> +		depends on ARCH_SUNXI && MACH_SUN9I

Depending on MACH_SUN9I should be enough. It already depends on ARCH_SUNXI.

-- 
Maxime Ripard, Free Electrons
Embedded Linux, Kernel and Android engineering
http://free-electrons.com
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 819 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20140924/1a004d59/attachment-0001.sig>
