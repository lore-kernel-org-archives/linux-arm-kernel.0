From: sergei.shtylyov@cogentembedded.com (Sergei Shtylyov)
Date: Tue, 16 Dec 2014 16:46:32 +0300
Subject: [PATCH 1/2] ARM: dts: kirkwood: enable phy driver for SATA
 controller on 88f6192
In-Reply-To: <20141215203724.GA22936@anne>
References: <20141215203724.GA22936@anne>
Message-ID: <549037B8.6060803@cogentembedded.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello.

On 12/15/2014 11:37 PM, Evgeni Dobrev wrote:

> This patch enables the phy drivers for the SATA controller on Marvell's 88f6192. Without them it is not possible to use SATA drives attached to this processor.

    Please wrap the change log likes at 80 characters or less.

> Signed-off-by: Evgeni Dobrev <evgeni@studio-punkt.com>
> ---
>   arch/arm/boot/dts/kirkwood-6192.dtsi |    2 ++
>   1 file changed, 2 insertions(+)

> diff --git a/arch/arm/boot/dts/kirkwood-6192.dtsi b/arch/arm/boot/dts/kirkwood-6192.dtsi
> index dd81508..bed2dec 100644
> --- a/arch/arm/boot/dts/kirkwood-6192.dtsi
> +++ b/arch/arm/boot/dts/kirkwood-6192.dtsi
> @@ -66,6 +66,8 @@
>   			interrupts = <21>;
>   			clocks = <&gate_clk 14>, <&gate_clk 15>;
>   			clock-names = "0", "1";
> +                        phys = <&sata_phy0>, <&sata_phy1>;
> +                        phy-names = "port0", "port1";

    Please indent with tabs,  not spaces.

[...]

WBR, Sergei
