From: shubhrajyoti.datta@gmail.com (Shubhrajyoti Datta)
Date: Mon, 27 Jul 2015 15:31:02 +0530
Subject: [PATCH 7/7] ARM64: zynqmp: Add eeprom memories on i2c bus
In-Reply-To: <84f7d2137afdc5581c1d5d9b27feb2c5e5592308.1437990464.git.michal.simek@xilinx.com>
References: <48a75b64b05dc094e34fe27e5d03552dbfe77fe2.1437990464.git.michal.simek@xilinx.com>
 <84f7d2137afdc5581c1d5d9b27feb2c5e5592308.1437990464.git.michal.simek@xilinx.com>
Message-ID: <CAKfKVtG-Uq0aJYnLqACO30mNj=D7+7y5skhf8JSqnWAgoJNk7w@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On Mon, Jul 27, 2015 at 3:18 PM, Michal Simek <michal.simek@xilinx.com> wrote:
> Add i2c eeprom memories on i2c bus.
>
> Signed-off-by: Michal Simek <michal.simek@xilinx.com>
> ---
>
>  arch/arm64/boot/dts/xilinx/zynqmp-ep108.dts | 18 ++++++++++++++++++
>  1 file changed, 18 insertions(+)
>
> diff --git a/arch/arm64/boot/dts/xilinx/zynqmp-ep108.dts b/arch/arm64/boot/dts/xilinx/zynqmp-ep108.dts
> index 206e18eca2fb..47debdcbefbf 100644
> --- a/arch/arm64/boot/dts/xilinx/zynqmp-ep108.dts
> +++ b/arch/arm64/boot/dts/xilinx/zynqmp-ep108.dts
> @@ -36,6 +36,24 @@
>         status = "okay";
>  };
>
> +&i2c0 {
> +       status = "okay";
> +       clock-frequency = <100000>;
If I am not wrong eeprom could work at 400k Could we make that as the speed.

> +       eeprom at 54 {
> +               compatible = "at,24c64";
> +               reg = <0x54>;
> +       };
> +};
> +
> +&i2c1 {
> +       status = "okay";
> +       clock-frequency = <100000>;
> +       eeprom at 55 {
> +               compatible = "at,24c64";
> +               reg = <0x55>;
> +       };
> +};
> +
>  &gem0 {
>         status = "okay";
>         phy-handle = <&phy0>;
> --
> 2.3.5
>
>
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel at lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
