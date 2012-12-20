From: shawn.guo@linaro.org (Shawn Guo)
Date: Thu, 20 Dec 2012 10:30:40 +0800
Subject: [PATCH/RFC] mxs: mach-mxs: Setup mac address prefix from dt
In-Reply-To: <C97C836E-18D1-41C5-8DC3-E82BC2019018@turczak.de>
References: <C97C836E-18D1-41C5-8DC3-E82BC2019018@turczak.de>
Message-ID: <20121220023037.GA24069@S2101-09.ap.freescale.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Dec 17, 2012 at 03:26:02PM +0100, Peter Turczak wrote:
> This patch enables setting the the fec ethernet mac address either completely
> from dt, take only the prefix from dt and use the remaining device unique bytes 
> from the OTP or use OTP uniq bytes and the hardcoded values as before when no
> mac address is specified in the dt. So compatibility should be maintained to
> devices already shipped.
> 
> Currently only Denx or Freescale manufacturer prefixes are guessed from the
> selected hardware platform. The suggested patch provides a more elegant
> solution because other vendors to just need to adapt their device tree 
> description file.
> 
> Example:
> mac0: ethernet at 800f0000 {
>              phy-mode = "rmii";
>              pinctrl-names = "default";
>              pinctrl-0 = <&mac0_pins_a>;
>              phy-supply = <&reg_fec_3v3>;
>              phy-reset-gpios = <&gpio2 5 3>;
>              phy-reset-duration = <100>;
>              local-mac-address = [00 04 1E 5E 1B B9];
>              status = "okay";
>          };
> or
> mac0: ethernet at 800f0000 {
>              phy-mode = "rmii";
>              pinctrl-names = "default";
>              pinctrl-0 = <&mac0_pins_a>;
>              phy-supply = <&reg_fec_3v3>;
>              phy-reset-gpios = <&gpio2 5 3>;
>              phy-reset-duration = <100>;
>              local-mac-address = [00 04 1E];
>              status = "okay";
>          };

Property "local-mac-address" is defined by a common bindings, we do not
want to get a different meaning on mach-mxs.

Shawn
