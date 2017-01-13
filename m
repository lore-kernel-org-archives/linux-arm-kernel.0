From: sebastian.hesselbarth@gmail.com (Sebastian Hesselbarth)
Date: Fri, 13 Jan 2017 10:54:17 +0100
Subject: [PATCHv4 3/5] pinctrl: mvebu: pinctrl driver for 98DX3236 SoC
In-Reply-To: <20170113091222.7132-4-chris.packham@alliedtelesis.co.nz>
References: <20170113091222.7132-1-chris.packham@alliedtelesis.co.nz>
 <20170113091222.7132-4-chris.packham@alliedtelesis.co.nz>
Message-ID: <2fca7ac2-9a88-19b1-28c5-5192b9c4a2bc@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 13.01.2017 10:12, Chris Packham wrote:
> From: Kalyan Kinthada <kalyan.kinthada@alliedtelesis.co.nz>
>
> This pinctrl driver supports the 98DX3236, 98DX3336 and 98DX4251 SoCs
> from Marvell.
>
> Signed-off-by: Kalyan Kinthada <kalyan.kinthada@alliedtelesis.co.nz>
> Signed-off-by: Chris Packham <chris.packham@alliedtelesis.co.nz>
> Acked-by: Rob Herring <robh@kernel.org>
> Acked-by: Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>
> ---
>
> Notes:
>     Changes in v2:
>     - include sdio support for the 98DX4251
>     Changes in v3:
>     - None
>     Changes in v4:
>     - Correct some discrepencies between binding and driver.

Well, unfortunately I still see differences between the "gpio" in
the binding and "gpo" in the driver.

Please go back to that list I sent you yesterday and fix them all.

[...]
> diff --git a/Documentation/devicetree/bindings/pinctrl/marvell,armada-98dx3236-pinctrl.txt b/Documentation/devicetree/bindings/pinctrl/marvell,armada-98dx3236-pinctrl.txt
> new file mode 100644
> index 000000000000..b5bd23992fdf
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/pinctrl/marvell,armada-98dx3236-pinctrl.txt
> @@ -0,0 +1,46 @@
[...]
> +mpp6          6        gpio, sd0(clk), dev(a2)

e.g. this is "gpio" ...

[...]
> diff --git a/drivers/pinctrl/mvebu/pinctrl-armada-xp.c b/drivers/pinctrl/mvebu/pinctrl-armada-xp.c
> index e4ea71a9d985..9601d662c7f5 100644
> --- a/drivers/pinctrl/mvebu/pinctrl-armada-xp.c
> +++ b/drivers/pinctrl/mvebu/pinctrl-armada-xp.c
> @@ -49,6 +49,10 @@ enum armada_xp_variant {
[...]
> +	MPP_MODE(6,
> +		 MPP_VAR_FUNCTION(0x0, "gpo", NULL,          V_98DX3236_PLUS),

... but here it is "gpo".

Sebastian
