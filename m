From: baruch@tkos.co.il (Baruch Siach)
Date: Tue, 26 Jun 2018 06:35:56 +0300
Subject: [PATCH v2 14/23] dt-bindings: cp110: prepare the syscon file to
 list other syscons nodes
In-Reply-To: <20180625151239.20976-15-miquel.raynal@bootlin.com>
References: <20180625151239.20976-1-miquel.raynal@bootlin.com>
 <20180625151239.20976-15-miquel.raynal@bootlin.com>
Message-ID: <20180626033556.bsub25ykdseflsta@tarshish>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Miquel,

On Mon, Jun 25, 2018 at 05:12:30PM +0200, Miquel Raynal wrote:
> There are multiple system controllers in CP110. Because all syscon nodes
> use the same compatible, it is pertinent to use this same file to list
> IPs inside it. Thus, change the header to be more generic, and align
> with AP806 file.
> 
> Signed-off-by: Miquel Raynal <miquel.raynal@bootlin.com>

This patch and the file rename in patch #12 should be squashed together, I 
think.

baruch

> ---
>  .../bindings/arm/marvell/cp110-system-controller.txt       | 14 +++++++-------
>  1 file changed, 7 insertions(+), 7 deletions(-)
> 
> diff --git a/Documentation/devicetree/bindings/arm/marvell/cp110-system-controller.txt b/Documentation/devicetree/bindings/arm/marvell/cp110-system-controller.txt
> index 29cdbae6c5ac..56e7fb1153e7 100644
> --- a/Documentation/devicetree/bindings/arm/marvell/cp110-system-controller.txt
> +++ b/Documentation/devicetree/bindings/arm/marvell/cp110-system-controller.txt
> @@ -1,15 +1,15 @@
> -Marvell Armada CP110 System Controller 0
> -========================================
> +Marvell Armada CP110 System Controller
> +======================================
>  
>  The CP110 is one of the two core HW blocks of the Marvell Armada 7K/8K
> -SoCs. It contains two sets of system control registers, System
> -Controller 0 and System Controller 1. This Device Tree binding allows
> -to describe the first system controller, which provides registers to
> -configure various aspects of the SoC.
> +SoCs. It contains system controllers, which provide several registers
> +giving access to numerous features: clocks, pin-muxing and many other
> +SoC configuration items. This DT binding allows to describe these
> +system controllers.
>  
>  For the top level node:
>   - compatible: must be: "syscon", "simple-mfd";
> - - reg: register area of the CP110 system controller 0
> + - reg: register area of the CP110 system controller
>  
>  Clocks:
>  -------

-- 
     http://baruch.siach.name/blog/                  ~. .~   Tk Open Systems
=}------------------------------------------------ooO--U--Ooo------------{=
   - baruch at tkos.co.il - tel: +972.52.368.4656, http://www.tkos.co.il -
