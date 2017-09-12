From: sergei.shtylyov@cogentembedded.com (Sergei Shtylyov)
Date: Wed, 13 Sep 2017 00:18:08 +0300
Subject: [PATCH 11/11] arm64: dts: renesas: eagle: add EtherAVB support
In-Reply-To: <20170912210547.471712392@cogentembedded.com>
References: <20170912210547.471712392@cogentembedded.com>
Message-ID: <a2e8db4a-bcc7-edd0-7abc-37a74922a624@cogentembedded.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 09/12/2017 11:37 PM, Sergei Shtylyov wrote:

> Define the Eagle board  dependent part of the EtherAVB device node.
> Enable DHCP  and NFS root for the kernel booting.
> 
> Based  on the original (and large) patch by Vladimir Barinov.
> 
> Signed-off-by: Vladimir Barinov <vladimir.barinov@cogentembedded.com>
> Signed-off-by: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
> 
> ---
>  arch/arm64/boot/dts/renesas/r8a77970-eagle.dts |   15 ++++++++++++++-
>  1 file changed, 14 insertions(+), 1 deletion(-)
> 
> Index: renesas/arch/arm64/boot/dts/renesas/r8a77970-eagle.dts
> ===================================================================
> --- renesas.orig/arch/arm64/boot/dts/renesas/r8a77970-eagle.dts
> +++ renesas/arch/arm64/boot/dts/renesas/r8a77970-eagle.dts
[...]
> @@ -43,3 +44,15 @@
>  &scif0 {
>  	status = "okay";
>  };
> +
> +&avb {
> +//	renesas,no-ether-link;

    Oops, overlooked it, will fix!

> +	phy-handle = <&phy0>;
> +	status = "okay";
> +
> +	phy0: ethernet-phy at 0 {
> +		rxc-skew-ps = <1500>;
> +		reg = <0>;
> +		max-speed = <1000>;
> +	};
> +};

MNR, Sergei
