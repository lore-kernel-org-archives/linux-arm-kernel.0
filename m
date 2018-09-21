From: gregory.clement@bootlin.com (Gregory CLEMENT)
Date: Fri, 21 Sep 2018 13:07:32 +0200
Subject: [PATCH 1/2] dt-bindings: marvell,
 prestera: Add common compatible string
In-Reply-To: <20180907005926.27134-2-chris.packham@alliedtelesis.co.nz> (Chris
 Packham's message of "Fri, 7 Sep 2018 12:59:25 +1200")
References: <20180907005926.27134-1-chris.packham@alliedtelesis.co.nz>
 <20180907005926.27134-2-chris.packham@alliedtelesis.co.nz>
Message-ID: <87a7obhzwr.fsf@bootlin.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Chris,
 
 On ven., sept. 07 2018, Chris Packham <chris.packham@alliedtelesis.co.nz> wrote:

> Add "marvell,prestera" as a compatible string so that drivers can be
> written to account for any prestera variant without needing to
> specialise to the more specific values.
>
> Signed-off-by: Chris Packham <chris.packham@alliedtelesis.co.nz>


Applied on mvebu/soc with Rob reviewed-by tag

Thanks,

Gregory

> ---
>  Documentation/devicetree/bindings/net/marvell,prestera.txt | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/Documentation/devicetree/bindings/net/marvell,prestera.txt b/Documentation/devicetree/bindings/net/marvell,prestera.txt
> index c329608fa887..83370ebf5b89 100644
> --- a/Documentation/devicetree/bindings/net/marvell,prestera.txt
> +++ b/Documentation/devicetree/bindings/net/marvell,prestera.txt
> @@ -2,7 +2,7 @@ Marvell Prestera Switch Chip bindings
>  -------------------------------------
>  
>  Required properties:
> -- compatible: one of the following
> +- compatible: must be "marvell,prestera" and one of the following
>  	"marvell,prestera-98dx3236",
>  	"marvell,prestera-98dx3336",
>  	"marvell,prestera-98dx4251",
> @@ -21,7 +21,7 @@ switch {
>  	ranges = <0 MBUS_ID(0x03, 0x00) 0 0x100000>;
>  
>  	packet-processor at 0 {
> -		compatible = "marvell,prestera-98dx3236";
> +		compatible = "marvell,prestera-98dx3236", "marvell,prestera";
>  		reg = <0 0x4000000>;
>  		interrupts = <33>, <34>, <35>;
>  		dfx = <&dfx>;
> -- 
> 2.18.0
>

-- 
Gregory Clement, Bootlin
Embedded Linux and Kernel engineering
http://bootlin.com
