From: maxime.ripard@bootlin.com (Maxime Ripard)
Date: Mon, 19 Mar 2018 22:27:42 +0100
Subject: [PATCHv2 5/5] arm64: allwinner: a64: Add support for TERES-I
 laptop
In-Reply-To: <20180319071723.GA854@afzalpc>
References: <20180315162510.11669-1-harald@ccbib.org>
 <20180315162510.11669-6-harald@ccbib.org>
 <20180318202251.5gpv6sblfr4edxmj@flea>
 <20180319071723.GA854@afzalpc>
Message-ID: <20180319212742.wttebbgoh2la63o5@flea>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

hi,

On Mon, Mar 19, 2018 at 12:47:23PM +0530, afzal mohammed wrote:
> On Sun, Mar 18, 2018 at 09:22:51PM +0100, Maxime Ripard wrote:
> > The first part is supposed to be the name of the boards. I did sed
> > s/leds/teres-i/, and applied, together with all the patches but the
> > PWM (so I had to drop the backlight node as well).
> > 
> > Please coordinate with Andre about who should send the PWM support.
> 
> Assuming that these patches were applied to your sunxi/dt64-for-4.17
> branch, since PWM support patch is missing, there is a build error,
> 
> arch/arm64/boot/dts/allwinner/sun50i-a64-teres-i.dts:129.1-5 Label or path pwm not found
> 
> Diff at the end cures it.
> 
> (there is another H6 pine 64 DT build error related to header file
> missing)
> 
> afzal
> 
> 
> --->8---
> diff --git a/arch/arm64/boot/dts/allwinner/sun50i-a64-teres-i.dts
> b/arch/arm64/boot/dts/allwinner/sun50i-a64-teres-i.dts
> index b3c7ef6b6fe5..d9baab3dc96b 100644
> --- a/arch/arm64/boot/dts/allwinner/sun50i-a64-teres-i.dts
> +++ b/arch/arm64/boot/dts/allwinner/sun50i-a64-teres-i.dts
> @@ -126,12 +126,6 @@
>         status = "okay";
>  };
>  
> -&pwm {
> -       pinctrl-names = "default";
> -       pinctrl-0 = <&pwm_pin>;
> -       status = "okay";
> -};
> -
>  &ohci1 {
>         status = "okay";
>  };
> 

Thanks for noticing and sending a patch. I've fixed the original
commit.

Maxime

-- 
Maxime Ripard, Bootlin (formerly Free Electrons)
Embedded Linux and Kernel engineering
https://bootlin.com
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 833 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20180319/ae8f8c20/attachment.sig>
