From: baruch@tkos.co.il (Baruch Siach)
Date: Sun, 16 Apr 2017 07:20:54 +0300
Subject: [PATCH] arm: imx6: zii: Add i210 PCIe interface to the device tree
In-Reply-To: <CAFXsbZreXT_4Xt6Qj5KiWCzwiNosBXsH-Fs7f36OQr2wqQ_idA@mail.gmail.com>
References: <CAFXsbZreXT_4Xt6Qj5KiWCzwiNosBXsH-Fs7f36OQr2wqQ_idA@mail.gmail.com>
Message-ID: <20170416042054.pypkxb27upu3ix2j@tarshish>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Cris,

On Sat, Apr 15, 2017 at 09:02:50PM -0700, Chris Healy wrote:
> The board has an Intel i210 Ethernet controller on its PCIe bus. Add a
> device tree node for this.
> 
> Signed-off-by: Andrew Lunn <andrew@lunn.ch>
> ---
>  arch/arm/boot/dts/imx6qdl-zii-rdu2.dtsi | 12 ++++++++++++
>  1 file changed, 12 insertions(+)
> 
> diff --git a/arch/arm/boot/dts/imx6qdl-zii-rdu2.dtsi
> b/arch/arm/boot/dts/imx6qdl-zii-rdu2.dtsi
> index bcff7876..6f59d53 100644
> --- a/arch/arm/boot/dts/imx6qdl-zii-rdu2.dtsi
> +++ b/arch/arm/boot/dts/imx6qdl-zii-rdu2.dtsi
> @@ -572,6 +572,18 @@
>   pinctrl-0 = <&pinctrl_pcie>;
>   reset-gpio = <&gpio7 12 GPIO_ACTIVE_LOW>;
>   status = "okay";
> +
> + host at 0 {
> + #address-cells = <3>;
> + #size-cells = <2>;
> + reg = <0 0 0 0 0>;
> + device_type = "pci";
> +
> + i210: i210 at 0 {
> + reg = <0 0 0 0 0>;
> + device_type = "pci";
> + };
> +       };
>  };
> 
>  &usdhc2 {

Looks like gmail ate your whitespaces. See 
https://www.kernel.org/doc/html/latest/process/email-clients.html for some 
alternative suggestions.

baruch

-- 
     http://baruch.siach.name/blog/                  ~. .~   Tk Open Systems
=}------------------------------------------------ooO--U--Ooo------------{=
   - baruch at tkos.co.il - tel: +972.52.368.4656, http://www.tkos.co.il -
