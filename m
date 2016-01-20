From: robh@kernel.org (Rob Herring)
Date: Wed, 20 Jan 2016 10:32:36 -0600
Subject: [PATCH v4 2/6] dt-bindings: ARM: Mediatek: Document bindings for
 MT2701
In-Reply-To: <1453271747-57397-3-git-send-email-jamesjj.liao@mediatek.com>
References: <1453271747-57397-1-git-send-email-jamesjj.liao@mediatek.com>
 <1453271747-57397-3-git-send-email-jamesjj.liao@mediatek.com>
Message-ID: <20160120163236.GA21035@rob-hp-laptop>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jan 20, 2016 at 02:35:43PM +0800, James Liao wrote:
> This patch adds the binding documentation for apmixedsys, bdpsys,
> ethsys, hifsys, imgsys, infracfg, mmsys, pericfg, topckgen and
> vdecsys for Mediatek MT2701.
> 
> Signed-off-by: James Liao <jamesjj.liao@mediatek.com>
> Tested-by: John Crispin <blogic@openwrt.org>
> ---
>  .../bindings/arm/mediatek/mediatek,apmixedsys.txt  |  1 +
>  .../bindings/arm/mediatek/mediatek,bdpsys.txt      | 22 ++++++++++++++++++++++
>  .../bindings/arm/mediatek/mediatek,ethsys.txt      | 22 ++++++++++++++++++++++
>  .../bindings/arm/mediatek/mediatek,hifsys.txt      | 22 ++++++++++++++++++++++
>  .../bindings/arm/mediatek/mediatek,imgsys.txt      |  1 +
>  .../bindings/arm/mediatek/mediatek,infracfg.txt    |  1 +
>  .../bindings/arm/mediatek/mediatek,mmsys.txt       |  1 +
>  .../bindings/arm/mediatek/mediatek,pericfg.txt     |  1 +
>  .../bindings/arm/mediatek/mediatek,topckgen.txt    |  1 +
>  .../bindings/arm/mediatek/mediatek,vdecsys.txt     |  1 +
>  10 files changed, 73 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/arm/mediatek/mediatek,bdpsys.txt
>  create mode 100644 Documentation/devicetree/bindings/arm/mediatek/mediatek,ethsys.txt
>  create mode 100644 Documentation/devicetree/bindings/arm/mediatek/mediatek,hifsys.txt
> 
> diff --git a/Documentation/devicetree/bindings/arm/mediatek/mediatek,apmixedsys.txt b/Documentation/devicetree/bindings/arm/mediatek/mediatek,apmixedsys.txt
> index 936166f..a701e19 100644
> --- a/Documentation/devicetree/bindings/arm/mediatek/mediatek,apmixedsys.txt
> +++ b/Documentation/devicetree/bindings/arm/mediatek/mediatek,apmixedsys.txt
> @@ -6,6 +6,7 @@ The Mediatek apmixedsys controller provides the PLLs to the system.
>  Required Properties:
>  
>  - compatible: Should be:
> +	- "mediatek,mt2701-apmixedsys"
>  	- "mediatek,mt8135-apmixedsys"
>  	- "mediatek,mt8173-apmixedsys"
>  - #clock-cells: Must be 1
> diff --git a/Documentation/devicetree/bindings/arm/mediatek/mediatek,bdpsys.txt b/Documentation/devicetree/bindings/arm/mediatek/mediatek,bdpsys.txt
> new file mode 100644
> index 0000000..4137196
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/arm/mediatek/mediatek,bdpsys.txt
> @@ -0,0 +1,22 @@
> +Mediatek bdpsys controller
> +============================
> +
> +The Mediatek bdpsys controller provides various clocks to the system.

As you clarified these blocks provide more that just clocks. Please list 
all the functions here and on the others.

> +
> +Required Properties:
> +
> +- compatible: Should be:
> +	- "mediatek,mt2701-bdpsys", "syscon"
> +- #clock-cells: Must be 1
> +
> +The bdpsys controller uses the common clk binding from
> +Documentation/devicetree/bindings/clock/clock-bindings.txt
> +The available clocks are defined in dt-bindings/clock/mt*-clk.h.
> +
