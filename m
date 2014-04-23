From: sebastian.hesselbarth@gmail.com (Sebastian Hesselbarth)
Date: Wed, 23 Apr 2014 13:23:38 +0200
Subject: [PATCH v2 17/38] ARM: orion5x: use node labels for UART and SATA
 on edmini_v2
In-Reply-To: <1398202002-28530-18-git-send-email-thomas.petazzoni@free-electrons.com>
References: <1398202002-28530-1-git-send-email-thomas.petazzoni@free-electrons.com>
 <1398202002-28530-18-git-send-email-thomas.petazzoni@free-electrons.com>
Message-ID: <5357A2BA.1050900@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 04/22/2014 11:26 PM, Thomas Petazzoni wrote:
> This commit converts the existing devices described in the edmini_v2
> Device Tree to use node labels: the UART and SATA device. Also, it
> reorders the eth and mdio node label references to be sorted
> alphabetically.
>
> Signed-off-by: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>

Does this also mean, we agree on the "using node label references" topic
for Kirkwood?

Acked-by: Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>

> ---
>   .../dts/orion5x-lacie-ethernet-disk-mini-v2.dts    | 30 ++++++++++------------
>   1 file changed, 14 insertions(+), 16 deletions(-)
>
> diff --git a/arch/arm/boot/dts/orion5x-lacie-ethernet-disk-mini-v2.dts b/arch/arm/boot/dts/orion5x-lacie-ethernet-disk-mini-v2.dts
> index df53d256..83f45a7 100644
> --- a/arch/arm/boot/dts/orion5x-lacie-ethernet-disk-mini-v2.dts
> +++ b/arch/arm/boot/dts/orion5x-lacie-ethernet-disk-mini-v2.dts
> @@ -28,18 +28,6 @@
>   	soc {
>   		ranges = <MBUS_ID(0xf0, 0x01) 0 0xf1000000 0x100000>,
>   			 <MBUS_ID(0x09, 0x00) 0 0xf2200000 0x800>;
> -
> -		internal-regs {
> -			serial at 12000 {
> -				clock-frequency = <166666667>;
> -				status = "okay";
> -			};
> -
> -			sata at 80000 {
> -				status = "okay";
> -				nr-ports = <2>;
> -			};
> -		};
>   	};
>
>   	gpio-keys {
> @@ -63,6 +51,14 @@
>   	};
>   };
>
> +&eth {
> +	status = "okay";
> +
> +	ethernet-port at 0 {
> +		phy-handle = <&ethphy>;
> +	};
> +};
> +
>   &mdio {
>   	status = "okay";
>
> @@ -71,10 +67,12 @@
>   	};
>   };
>
> -&eth {
> +&sata {
>   	status = "okay";
> +	nr-ports = <2>;
> +};
>
> -	ethernet-port at 0 {
> -		phy-handle = <&ethphy>;
> -	};
> +&uart0 {
> +	clock-frequency = <166666667>;
> +	status = "okay";
>   };
>
