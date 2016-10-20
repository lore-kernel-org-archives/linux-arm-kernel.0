From: alexandre.belloni@free-electrons.com (Alexandre Belloni)
Date: Thu, 20 Oct 2016 17:35:35 +0200
Subject: [PATCH v2] ARM: at91/dt: fixes dbgu pinctrl, set pullup on rx,
 clear pullup on tx
In-Reply-To: <20161016162145.26193-2-sylvain.rochet@finsecur.com>
References: <20161016162145.26193-1-sylvain.rochet@finsecur.com>
 <20161016162145.26193-2-sylvain.rochet@finsecur.com>
Message-ID: <20161020153535.7e2b4frcukk2ce2i@piout.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 16/10/2016 at 18:21:45 +0200, Sylvain Rochet wrote :
> Remove pullup on dbgu DTXD signal, it is a push-pull output thus the
> pullup is pointless.
> 
> Add pullup on dbgu DRXD signal, it prevents the DRXD signal to be left
> floating and so consuming a useless extra amount of power in crowbarred
> state if nothing is externally connected to dbgu.
> 
> Signed-off-by: Sylvain Rochet <sylvain.rochet@finsecur.com>
> ---
>  arch/arm/boot/dts/at91rm9200.dtsi  | 4 ++--
>  arch/arm/boot/dts/at91sam9260.dtsi | 4 ++--
>  arch/arm/boot/dts/at91sam9261.dtsi | 4 ++--
>  arch/arm/boot/dts/at91sam9263.dtsi | 4 ++--
>  arch/arm/boot/dts/at91sam9g45.dtsi | 4 ++--
>  arch/arm/boot/dts/at91sam9n12.dtsi | 4 ++--
>  arch/arm/boot/dts/at91sam9rl.dtsi  | 4 ++--
>  arch/arm/boot/dts/at91sam9x5.dtsi  | 4 ++--
>  arch/arm/boot/dts/sama5d3.dtsi     | 4 ++--
>  arch/arm/boot/dts/sama5d4.dtsi     | 4 ++--
>  10 files changed, 20 insertions(+), 20 deletions(-)
> 
Applied, thanks.

-- 
Alexandre Belloni, Free Electrons
Embedded Linux and Kernel engineering
http://free-electrons.com
