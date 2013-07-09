From: sergei.shtylyov@cogentembedded.com (Sergei Shtylyov)
Date: Tue, 09 Jul 2013 15:45:17 +0400
Subject: [PATCH] ARM: shmobile: Add SMSC ethernet chip to KZM9D DT
 reference
In-Reply-To: <20130709042654.13658.20164.sendpatchset@w520>
References: <20130709042654.13658.20164.sendpatchset@w520>
Message-ID: <51DBF7CD.8040009@cogentembedded.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello.

On 09-07-2013 8:26, Magnus Damm wrote:

> From: Magnus Damm <damm@opensource.se>

> Add support for the SMSC ethernet controller found
> on the KZM9D board to the KZM9D DT Reference code.

> Signed-off-by: Magnus Damm <damm@opensource.se>
> ---

>   Built on top of renesas-next-20130704v2 and
>   [PATCH] ARM: shmobile: KZM9D DT reference implementation

>   arch/arm/boot/dts/emev2-kzm9d-reference.dts |   31 +++++++++++++++++++++++++++
>   1 file changed, 31 insertions(+)

> --- 0002/arch/arm/boot/dts/emev2-kzm9d-reference.dts
> +++ work/arch/arm/boot/dts/emev2-kzm9d-reference.dts	2013-07-09 13:06:47.000000000 +0900
> @@ -23,4 +23,35 @@
[...]
> +	lan9220 at 20000000 {

    Shouldn't all the Ethernet nodes be called "ethernet"?

> +		compatible = "smsc,lan9220", "smsc,lan9115";
> +		reg = <0x20000000 0x10000>;
> +		phy-mode = "mii";
> +		interrupt-parent = <&gpio0>;
> +		interrupts = <1 1>;	/* active high */
> +		reg-io-width = <4>;
> +		smsc,irq-active-high;
> +		smsc,irq-push-pull;
> +		vddvario-supply = <&reg_1p8v>;
> +		vdd33a-supply = <&reg_3p3v>;
> +	};
>   };

WBR, Sergei
