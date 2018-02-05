From: robh@kernel.org (Rob Herring)
Date: Mon, 5 Feb 2018 00:07:40 -0600
Subject: [RFC PATCH] mmc: sdhci-of-arasan: Add auto tuning support for
 ZynqMP Platform
In-Reply-To: <1517336073-18142-1-git-send-email-mnarani@xilinx.com>
References: <1517336073-18142-1-git-send-email-mnarani@xilinx.com>
Message-ID: <20180205024420.iagez2mue2skrngq@rob-hp-laptop>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jan 30, 2018 at 11:44:33PM +0530, Manish Narani wrote:
> This patch adds support of SD auto tuning for ZynqMP platform. Auto
> tuning sequence sends tuning block to card when operating in UHS-1
> modes. This resets the DLL and sends CMD19/CMD21 as a part of the auto
> tuning process. Once the auto tuning process gets completed, reset the
> DLL to load the newly obtained SDHC tuned tap value.
> 
> Signed-off-by: Manish Narani <mnarani@xilinx.com>
> ---
>  .../devicetree/bindings/mmc/arasan,sdhci.txt       |   1 +
>  drivers/mmc/host/sdhci-of-arasan.c                 | 219 ++++++++++++++++++++-
>  2 files changed, 219 insertions(+), 1 deletion(-)
> 
> diff --git a/Documentation/devicetree/bindings/mmc/arasan,sdhci.txt b/Documentation/devicetree/bindings/mmc/arasan,sdhci.txt
> index 60481bf..7d29751 100644
> --- a/Documentation/devicetree/bindings/mmc/arasan,sdhci.txt
> +++ b/Documentation/devicetree/bindings/mmc/arasan,sdhci.txt
> @@ -14,6 +14,7 @@ Required Properties:
>      - "arasan,sdhci-4.9a": generic Arasan SDHCI 4.9a PHY
>      - "arasan,sdhci-5.1": generic Arasan SDHCI 5.1 PHY
>      - "rockchip,rk3399-sdhci-5.1", "arasan,sdhci-5.1": rk3399 eMMC PHY
> +    - "xlnx,zynqmp-8.9a": Xilinx ZynqMP 8.9a PHY

This should be a separate patch.

>        For this device it is strongly suggested to include arasan,soc-ctl-syscon.
>    - reg: From mmc bindings: Register location and length.
>    - clocks: From clock bindings: Handles to clock inputs.
