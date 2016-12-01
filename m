From: mw@semihalf.com (Marcin Wojtas)
Date: Thu, 1 Dec 2016 17:05:28 +0100
Subject: [PATCH v5 net-next 7/7] ARM64: dts: marvell: Add network support
 for Armada 3700
In-Reply-To: <f205231e640a2324b8f007073cf54b166a263ed4.1480542157.git-series.gregory.clement@free-electrons.com>
References: <cover.0270f6d2413a709521fe2c8c17fbebea6f2e78d1.1480542157.git-series.gregory.clement@free-electrons.com>
 <f205231e640a2324b8f007073cf54b166a263ed4.1480542157.git-series.gregory.clement@free-electrons.com>
Message-ID: <CAPv3WKfZ=v7CG+tb504bt4=afdy4q8gFW3db10ORq=K+OYQbZg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Gregory,

2016-11-30 22:42 GMT+01:00 Gregory CLEMENT <gregory.clement@free-electrons.com>:
> Add neta nodes for network support both in device tree for the SoC and
> the board.
>
> Signed-off-by: Gregory CLEMENT <gregory.clement@free-electrons.com>
> ---
>  arch/arm64/boot/dts/marvell/armada-3720-db.dts | 23 +++++++++++++++++++-
>  arch/arm64/boot/dts/marvell/armada-37xx.dtsi   | 23 +++++++++++++++++++-
>  2 files changed, 46 insertions(+), 0 deletions(-)
>
> diff --git a/arch/arm64/boot/dts/marvell/armada-3720-db.dts b/arch/arm64/boot/dts/marvell/armada-3720-db.dts
> index 1372e9a6aaa4..c8b82e4145de 100644
> --- a/arch/arm64/boot/dts/marvell/armada-3720-db.dts
> +++ b/arch/arm64/boot/dts/marvell/armada-3720-db.dts
> @@ -81,3 +81,26 @@
>  &pcie0 {
>         status = "okay";
>  };
> +
> +&mdio {
> +       status = "okay";
> +       phy0: ethernet-phy at 0 {
> +               reg = <0>;
> +       };
> +
> +       phy1: ethernet-phy at 1 {
> +               reg = <1>;
> +       };
> +};
> +
> +&eth0 {
> +       phy-mode = "rgmii-id";
> +       phy = <&phy0>;
> +       status = "okay";
> +};
> +
> +&eth1 {
> +       phy-mode = "rgmii-id";

Should be "sgmii".

Best regards,
Marcin
