From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Fri, 25 Sep 2015 08:36:11 +0200
Subject: [PATCH v2 4/4] ARM: dts: sun4i: gemei-g9: Enable sun4i audio
 codec support
In-Reply-To: <1442993914-20295-5-git-send-email-plaes@plaes.org>
References: <1442993914-20295-1-git-send-email-plaes@plaes.org>
 <1442993914-20295-5-git-send-email-plaes@plaes.org>
Message-ID: <20150925063611.GZ4684@lukather>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Sep 23, 2015 at 10:38:34AM +0300, Priit Laes wrote:
> Gemei G9 has internal speakers and headphone jack. Audio switching
> from internal speakers to headphones is automatically handled by
> extra FT2012Q audio amplifier chip that works out of the box.
> 
> Signed-off-by: Priit Laes <plaes@plaes.org>
> ---
>  arch/arm/boot/dts/sun4i-a10-gemei-g9.dts | 9 ++++++++-
>  1 file changed, 8 insertions(+), 1 deletion(-)
> 
> diff --git a/arch/arm/boot/dts/sun4i-a10-gemei-g9.dts b/arch/arm/boot/dts/sun4i-a10-gemei-g9.dts
> index b7cab72..2db75c4 100644
> --- a/arch/arm/boot/dts/sun4i-a10-gemei-g9.dts
> +++ b/arch/arm/boot/dts/sun4i-a10-gemei-g9.dts
> @@ -65,12 +65,19 @@
>  /*
>   * TODO:
>   *   2x cameras via CSI
> - *   audio
> + *   audio input
>   *   AXP battery management
>   *   NAND
>   *   OTG
>   *   Touchscreen - gt801_2plus1 @ i2c adapter 2 @ 0x48
>   */
> +&codec {
> +	routing =
> +		"Headphone Jack", "HP Left",
> +		"Headphone Jack", "HP Right";
> +		/* TODO: input configuration */
> +	status = "okay";
> +};

This doesn't compile, the codec node doesn't exist.

Please always base your patches on top of sunxi/for-next, linux-next
or some earlier rc, or mention the dependency in your cover letter.

Thanks!
Maxime

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
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20150925/061988d9/attachment.sig>
