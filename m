From: linus.walleij@linaro.org (Linus Walleij)
Date: Tue, 20 Aug 2013 11:11:19 +0200
Subject: [PATCH 09/33] ARM: ux500: Supply the I2C clocks lookup to the
 DBX500 DT
In-Reply-To: <1370521041-32318-10-git-send-email-lee.jones@linaro.org>
References: <1370521041-32318-1-git-send-email-lee.jones@linaro.org>
 <1370521041-32318-10-git-send-email-lee.jones@linaro.org>
Message-ID: <CACRpkdbE86HgPr+7LZD9BFU_OsDFFFWTaFHW_i2fNXivKZ-3Dw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Jun 6, 2013 at 2:16 PM, Lee Jones <lee.jones@linaro.org> wrote:

> +++ b/arch/arm/boot/dts/dbx5x0.dtsi
> @@ -572,6 +572,8 @@
>                         v-i2c-supply = <&db8500_vape_reg>;
>
>                         clock-frequency = <400000>;
> +                       clocks = <&prcc_kclk 3 3>, <&prcc_pclk 3 3>;
> +                       clock-names = "nmk-i2c.0", "apb_pclk";

To avoid confusing the clock name "nmk-i2c.0" with the device
name in Linux of that device instance, can we use a name such
that it is clear that this is not a dev_name match?

"i2c0" works just fine as name I think?

Linus
