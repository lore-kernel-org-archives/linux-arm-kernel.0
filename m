From: wens@csie.org (Chen-Yu Tsai)
Date: Fri, 14 Sep 2018 17:00:04 +0800
Subject: [PATCH] ARM: dts: sun9i: Fix I2C bus warnings
In-Reply-To: <20180913181245.25484-14-robh@kernel.org>
References: <20180913181245.25484-14-robh@kernel.org>
Message-ID: <CAGb2v66L9EGHBiJqPbK_YEEgmoFncgbQDzHMq4GuatnzxuLOgA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Sep 14, 2018 at 2:13 AM Rob Herring <robh@kernel.org> wrote:
>
> dtc has new checks for I2C buses. The sun9i-a80 dts file has a node named
> 'i2c' which causes a false positive warning. As the node is a RSB bus,
> correct the node name to be 'rsb' to fix the warnings.
>
> arch/arm/boot/dts/sun9i-a80-cubieboard4.dtb: Warning (i2c_bus_reg): /soc/i2c at 8003400/codec at e89:reg: I2C address must be less than 10-bits, got "0xe89"
> arch/arm/boot/dts/sun9i-a80-cubieboard4.dtb: Warning (i2c_bus_reg): /soc/i2c at 8003400/pmic at 745:reg: I2C address must be less than 10-bits, got "0x745"
> arch/arm/boot/dts/sun9i-a80-optimus.dtb: Warning (i2c_bus_reg): /soc/i2c at 8003400/codec at e89:reg: I2C address must be less than 10-bits, got "0xe89"
> arch/arm/boot/dts/sun9i-a80-optimus.dtb: Warning (i2c_bus_reg): /soc/i2c at 8003400/pmic at 745:reg: I2C address must be less than 10-bits, got "0x745"
>
> Cc: Maxime Ripard <maxime.ripard@bootlin.com>
> Cc: Chen-Yu Tsai <wens@csie.org>
> Signed-off-by: Rob Herring <robh@kernel.org>
> ---
> Please apply to the sub-arch tree. The dtc changes haven't landed, but
> will for 4.20.

Applied for 4.20. Thanks!
