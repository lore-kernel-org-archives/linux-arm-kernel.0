From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Mon, 17 Nov 2014 16:59:25 +0100
Subject: [PATCH] ARM: dts: sunxi: Update simplfb nodes so that u-boot can
 find them
In-Reply-To: <1416238816-29627-1-git-send-email-hdegoede@redhat.com>
References: <1416238816-29627-1-git-send-email-hdegoede@redhat.com>
Message-ID: <20141117155925.GV6414@lukather>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On Mon, Nov 17, 2014 at 04:40:16PM +0100, Hans de Goede wrote:
> Review of the u-boot sunxi simplefb patches has led to the decision that
> u-boot should not use a specific path to find the nodes as this goes contrary
> to how devicetree usually works.
> 
> Instead a platform specific compatible + properties should be used for this.
> 
> The simplefb bindings have already been updated to reflect this, this patch
> brings the sunxi devicetree files in line with the new binding, and the
> actual u-boot implementation as it is going upstream.
> 
> Signed-off-by: Hans de Goede <hdegoede@redhat.com>
> ---
>  arch/arm/boot/dts/sun4i-a10.dtsi  | 5 +++--
>  arch/arm/boot/dts/sun5i-a10s.dtsi | 5 +++--
>  arch/arm/boot/dts/sun6i-a31.dtsi  | 5 +++--
>  arch/arm/boot/dts/sun7i-a20.dtsi  | 5 +++--
>  4 files changed, 12 insertions(+), 8 deletions(-)
> 
> diff --git a/arch/arm/boot/dts/sun4i-a10.dtsi b/arch/arm/boot/dts/sun4i-a10.dtsi
> index 92d8aa6..bbc366f 100644
> --- a/arch/arm/boot/dts/sun4i-a10.dtsi
> +++ b/arch/arm/boot/dts/sun4i-a10.dtsi
> @@ -32,8 +32,9 @@
>  		#size-cells = <1>;
>  		ranges;
>  
> -		framebuffer0-hdmi {
> -			compatible = "simple-framebuffer";
> +		framebuffer at 0 {
> +			compatible = "sunxi,framebuffer", "simple-framebuffer";

This compatible isn't following the
standard. allwinner,sunxi-framebuffer would be more appropriate.

I must say I'm also a bit concerned that this whole binding thing is
not stabilizing while we are quite close from the end of the ARM merge
window.

I wouldn't be very pleased to merge any more patch modifying again
this binding.

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
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20141117/c5cf1920/attachment.sig>
