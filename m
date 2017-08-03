From: robh@kernel.org (Rob Herring)
Date: Thu, 3 Aug 2017 13:54:28 -0500
Subject: [PATCH v2 1/4] dt-bindings: phy-hisi-inno-usb2: add support for
 hisi-inno-usb2 phy
In-Reply-To: <1501049163-18892-2-git-send-email-xuejiancheng@hisilicon.com>
References: <1501049163-18892-1-git-send-email-xuejiancheng@hisilicon.com>
 <1501049163-18892-2-git-send-email-xuejiancheng@hisilicon.com>
Message-ID: <20170803185428.a7h2k5u5ux6rebvc@rob-hp-laptop>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jul 26, 2017 at 02:06:00PM +0800, Jiancheng Xue wrote:
> Add support for hisi-inno-usb2 phy.
> 
> Signed-off-by: Jiancheng Xue <xuejiancheng@hisilicon.com>
> ---
>  .../devicetree/bindings/phy/phy-hisi-inno-usb2.txt | 31 ++++++++++++++++++++++
>  1 file changed, 31 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/phy/phy-hisi-inno-usb2.txt
> 
> diff --git a/Documentation/devicetree/bindings/phy/phy-hisi-inno-usb2.txt b/Documentation/devicetree/bindings/phy/phy-hisi-inno-usb2.txt
> new file mode 100644
> index 0000000..417eeaa
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/phy/phy-hisi-inno-usb2.txt
> @@ -0,0 +1,31 @@
> +HiSilicon INNO USB2 PHY
> +-----------------------
> +Required properties:
> +- compatible: Should be one of the following strings:
> +		"hisilicon,inno-usb2-phy",
> +		"hisilicon,hi3798cv200-usb2-phy",
> +- #phy-cells: Shall be 0.
> +- hisilicon,peripheral-syscon: Phandle of syscon used to control phy.
> +- hisilicon,phycon-reg: Offset of the phy control register in the syscon.

Just make this a cell of hisilicon,peripheral-syscon: <&syscon 0x120>

With that,

Acked-by: Rob Herring <robh@kernel.org>
