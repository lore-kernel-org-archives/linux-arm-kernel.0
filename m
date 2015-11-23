From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Mon, 23 Nov 2015 13:43:56 +0100
Subject: [PATCH v2 1/5] ARM: dts: sun8i: Add SID node
In-Reply-To: <b897b1c8741c8a871163b84d01b480f99329536d.1448263428.git.atx@atx.name>
References: <cover.1448263428.git.atx@atx.name>
 <b897b1c8741c8a871163b84d01b480f99329536d.1448263428.git.atx@atx.name>
Message-ID: <20151123124356.GW32142@lukather>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On Mon, Nov 23, 2015 at 09:02:48AM +0100, Josef Gajdusek wrote:
> Add a node describing the Security ID memory to the
> Allwinner H3 .dtsi file.
> 
> Signed-off-by: Josef Gajdusek <atx@atx.name>
> ---
>  arch/arm/boot/dts/sun8i-h3.dtsi | 7 +++++++
>  1 file changed, 7 insertions(+)
> 
> diff --git a/arch/arm/boot/dts/sun8i-h3.dtsi b/arch/arm/boot/dts/sun8i-h3.dtsi
> index 0faa38a..58de718 100644
> --- a/arch/arm/boot/dts/sun8i-h3.dtsi
> +++ b/arch/arm/boot/dts/sun8i-h3.dtsi
> @@ -359,6 +359,13 @@
>  			#size-cells = <0>;
>  		};
>  
> +		sid: eeprom at 01c14000 {
> +			compatible = "allwinner,sun4i-a10-sid";
> +			reg = <0x01c14000 0x400>;

The datasheet says it's 256 bytes wide, while the size here is of 1kB,
is it intentional?

Thanks,
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
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20151123/ae9b68e7/attachment.sig>
