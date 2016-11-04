From: sergei.shtylyov@cogentembedded.com (Sergei Shtylyov)
Date: Fri, 4 Nov 2016 16:31:40 +0300
Subject: [PATCH v6 7/7] arm64: dts: NS2: add AMAC ethernet support
In-Reply-To: <1478236262-3351-8-git-send-email-jon.mason@broadcom.com>
References: <1478236262-3351-1-git-send-email-jon.mason@broadcom.com>
 <1478236262-3351-8-git-send-email-jon.mason@broadcom.com>
Message-ID: <69ecd9b9-d495-9dfa-ad26-4fa622d951a0@cogentembedded.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello.

On 11/4/2016 8:11 AM, Jon Mason wrote:

> Add support for the AMAC ethernet to the Broadcom Northstar2 SoC device
> tree
>
> Signed-off-by: Jon Mason <jon.mason@broadcom.com>
> ---
>  arch/arm64/boot/dts/broadcom/ns2-svk.dts |  5 +++++
>  arch/arm64/boot/dts/broadcom/ns2.dtsi    | 12 ++++++++++++
>  2 files changed, 17 insertions(+)
>
> diff --git a/arch/arm64/boot/dts/broadcom/ns2-svk.dts b/arch/arm64/boot/dts/broadcom/ns2-svk.dts
> index b09f3bc..c4d5442 100644
> --- a/arch/arm64/boot/dts/broadcom/ns2-svk.dts
> +++ b/arch/arm64/boot/dts/broadcom/ns2-svk.dts
> @@ -56,6 +56,10 @@
>  	};
>  };
>
> +&enet {
> +	status = "ok";

    The spec dictates it should be "okay" (although "ok" is also recognized).

> +};
> +
>  &pci_phy0 {
>  	status = "ok";
>  };
> @@ -174,6 +178,7 @@
>  &mdio_mux_iproc {
>  	mdio at 10 {
>  		gphy0: eth-phy at 10 {
> +			enet-phy-lane-swap;
>  			reg = <0x10>;
>  		};
>  	};
[...]

MBR, Sergei
