From: shubhrajyoti.datta@gmail.com (Shubhrajyoti Datta)
Date: Wed, 29 Jul 2015 21:07:29 +0530
Subject: [PATCH v2] ARM64: zynqmp: Add eeprom memories on i2c bus
In-Reply-To: <827fe968a448dd25e133ce3509d91fd2482bd850.1438179569.git.michal.simek@xilinx.com>
References: <827fe968a448dd25e133ce3509d91fd2482bd850.1438179569.git.michal.simek@xilinx.com>
Message-ID: <CAKfKVtEpZNoNgRV7cJp+Mjj2Z=U3TWepM_y8goRHDYVPDQ9zqw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jul 29, 2015 at 7:49 PM, Michal Simek <michal.simek@xilinx.com> wrote:
> Add i2c eeprom memories on i2c bus.
>
Thanks for the patch.

Feel free to add
Reviewed-by: Shubhrajyoti Datta <shubhraj@xilinx.com>
> Signed-off-by: Michal Simek <michal.simek@xilinx.com>
> ---
>
> Changes in v2:
> - Change eeprom max freq from 100k to 400k
>
> ---
>  arch/arm64/boot/dts/xilinx/zynqmp-ep108.dts | 18 ++++++++++++++++++
>  1 file changed, 18 insertions(+)
>
> diff --git a/arch/arm64/boot/dts/xilinx/zynqmp-ep108.dts b/arch/arm64/boot/dts/xilinx/zynqmp-ep108.dts
> index c5cc8dbd0968..3b1011169756 100644
> --- a/arch/arm64/boot/dts/xilinx/zynqmp-ep108.dts
> +++ b/arch/arm64/boot/dts/xilinx/zynqmp-ep108.dts
> @@ -50,6 +50,24 @@
>         status = "okay";
>  };
>
> +&i2c0 {
> +       status = "okay";
> +       clock-frequency = <400000>;
> +       eeprom at 54 {
> +               compatible = "at,24c64";
> +               reg = <0x54>;
> +       };
> +};
> +
> +&i2c1 {
> +       status = "okay";
> +       clock-frequency = <400000>;
> +       eeprom at 55 {
> +               compatible = "at,24c64";
> +               reg = <0x55>;
> +       };
> +};
> +
>  &sata {
>         status = "okay";
>         ceva,broken-gen2;
> --
> 2.3.5
>
>
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel at lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
