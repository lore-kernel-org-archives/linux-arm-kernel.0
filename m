From: gregory.clement@bootlin.com (Gregory CLEMENT)
Date: Fri, 21 Sep 2018 16:15:27 +0200
Subject: [RESEND PATCH 3/4] arm64: dts: marvell: add macro to make
 distinction between node names
In-Reply-To: <20180830081501.11569-3-miquel.raynal@bootlin.com> (Miquel
 Raynal's message of "Thu, 30 Aug 2018 10:15:00 +0200")
References: <20180830081501.11569-1-miquel.raynal@bootlin.com>
 <20180830081501.11569-3-miquel.raynal@bootlin.com>
Message-ID: <87fty3gcn4.fsf@bootlin.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Miquel,
 
 On jeu., ao?t 30 2018, Miquel Raynal <miquel.raynal@bootlin.com> wrote:

> Because the label is different between CPs, the full path of a node is
> unique. However, when referring to the end of the path only (the node
> name), this name is not unique anymore.
>
> The *thermal_zone_of_sensor_register() functions of the thermal core
> present this limitation and prevent having a thermal-zone per CP.
>
> Add a macro to make the distinction between node names to solve this
> situation.
>
> Signed-off-by: Miquel Raynal <miquel.raynal@bootlin.com>

Applied on mvebu/dt64

Thanks,

Gregory

> ---
>  arch/arm64/boot/dts/marvell/armada-common.dtsi | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/arch/arm64/boot/dts/marvell/armada-common.dtsi b/arch/arm64/boot/dts/marvell/armada-common.dtsi
> index d5e8aedec188..b29c6405d214 100644
> --- a/arch/arm64/boot/dts/marvell/armada-common.dtsi
> +++ b/arch/arm64/boot/dts/marvell/armada-common.dtsi
> @@ -7,4 +7,5 @@
>  #define PASTER(x, y) x ## y
>  #define EVALUATOR(x, y) PASTER(x, y)
>  #define CP110_LABEL(name) EVALUATOR(CP110_NAME, EVALUATOR(_, name))
> +#define CP110_NODE_NAME(name) EVALUATOR(CP110_NAME, EVALUATOR(-, name))
>  #define ADDRESSIFY(addr) EVALUATOR(0x, addr)
> -- 
> 2.17.1
>

-- 
Gregory Clement, Bootlin
Embedded Linux and Kernel engineering
http://bootlin.com
