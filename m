From: arnd@arndb.de (Arnd Bergmann)
Date: Tue, 30 Sep 2014 11:02:34 +0200
Subject: [PATCH v2 3/3] ARM: dts: hix5hd2: add i2c node
In-Reply-To: <1411878129-19743-4-git-send-email-zhangfei.gao@linaro.org>
References: <1411878129-19743-1-git-send-email-zhangfei.gao@linaro.org>
 <1411878129-19743-4-git-send-email-zhangfei.gao@linaro.org>
Message-ID: <2637538.ufF2KQPbi9@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sunday 28 September 2014 12:22:09 Zhangfei Gao wrote:
> +
> +               i2c0: i2c at b10000 {
> +                       compatible = "hisilicon,hix5hd2-i2c";
> +                       reg = <0xb10000 0x1000>;
> +                       interrupts = <0 38 4>;
> +                       clocks = <&clock HIX5HD2_I2C0_RST>;
> +                       #address-cells = <1>;
> +                       #size-cells = <0>;
> +                       status = "disabled";
> +               };
> 

HIX5HD2_I2C0_RST is not defined anywhere, so this will result in the
same build error that has required reverting a lot of patches for the
3.18 merge window.

How do you plan to deal with the dependency in the future?

	Arnd
