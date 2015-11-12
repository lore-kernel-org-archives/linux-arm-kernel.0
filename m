From: sergei.shtylyov@cogentembedded.com (Sergei Shtylyov)
Date: Thu, 12 Nov 2015 14:51:37 +0300
Subject: [PATCH v2 3/3] ARM: shmobile: gose: Add QSPI device to DT
In-Reply-To: <1447291763-27527-4-git-send-email-horms+renesas@verge.net.au>
References: <1447291763-27527-1-git-send-email-horms+renesas@verge.net.au>
 <1447291763-27527-4-git-send-email-horms+renesas@verge.net.au>
Message-ID: <56447D49.6060907@cogentembedded.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 11/12/2015 4:29 AM, Simon Horman wrote:

> Enable the QSPI controller in the gose device tree.
>
> Based similar work for the silk board by by Vladimir Barinov and
> Sergei Shtylyov.
>
> Cc: Vladimir Barinov <vladimir.barinov@cogentembedded.com>
> Cc: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
> Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
>
> ---
> Tested: Read /dev/mtd0 with 512K blocks at 1.7MB/s
>
> v2
> * Move partitions into partitions subnode
>    as suggested by Geert Uytterhoeven.
> ---
>   arch/arm/boot/dts/r8a7793-gose.dts | 43 ++++++++++++++++++++++++++++++++++++++
>   1 file changed, 43 insertions(+)
>
> diff --git a/arch/arm/boot/dts/r8a7793-gose.dts b/arch/arm/boot/dts/r8a7793-gose.dts
> index 1575ef759047..79be514d3a1c 100644
> --- a/arch/arm/boot/dts/r8a7793-gose.dts
> +++ b/arch/arm/boot/dts/r8a7793-gose.dts
[...]
> @@ -92,3 +97,41 @@
>
>   	status = "okay";
>   };
> +
> +&qspi {
> +	pinctrl-0 = <&qspi_pins>;
> +	pinctrl-names = "default";
> +
> +	status = "okay";
> +
> +	flash at 0 {
> +		compatible = "spansion,s25fl512s", "jedec,spi-nor";
> +		reg = <0>;
> +		spi-max-frequency = <30000000>;
> +		spi-tx-bus-width = <4>;
> +		spi-rx-bus-width = <4>;
> +		spi-cpol;
> +		spi-cpha;
> +		m25p,fast-read;
> +
> +		partitions{

    Need space before {.

[...]

MBR, Sergei
