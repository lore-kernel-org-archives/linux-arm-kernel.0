From: nicolas.ferre@microchip.com (Nicolas Ferre)
Date: Tue, 12 Jun 2018 12:24:08 +0200
Subject: [PATCH 0/4] Fix suspend resume on at91sam9261 and at91sam9263
In-Reply-To: <20180607084107.4461-1-alexandre.belloni@bootlin.com>
References: <20180607084107.4461-1-alexandre.belloni@bootlin.com>
Message-ID: <fb9ed9bf-52b9-4a46-cd70-469d933deefd@microchip.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 07/06/2018 at 10:41, Alexandre Belloni wrote:
> USB clock detection may not work properly on at91sam9261 and at91sam9263
> because they currently use the same bit mask as at91rm9200 instead of
> the one for at91sam9260.
> 
> Take the opportunity to also change the PMC compatible strings for all
> the other SoCs in preparation for the new clock bindings.
> 
> Alexandre Belloni (4):
>    dt-bindings: arm: remove PMC bindings
>    dt-bindings: clk: at91: Document all the PMC compatibles
>    ARM: at91: fix USB clock detection handling
>    ARM: dts: fix PMC compatible

To the whole series:
Acked-by: Nicolas Ferre <nicolas.ferre@microchip.com>

Thanks, best regards.

>   .../devicetree/bindings/arm/atmel-pmc.txt          | 14 --------------
>   .../devicetree/bindings/clock/at91-clock.txt       |  9 ++++-----
>   arch/arm/boot/dts/at91sam9261.dtsi                 |  2 +-
>   arch/arm/boot/dts/at91sam9263.dtsi                 |  2 +-
>   arch/arm/boot/dts/at91sam9rl.dtsi                  |  2 +-
>   arch/arm/boot/dts/sama5d4.dtsi                     |  2 +-
>   arch/arm/mach-at91/pm.c                            |  5 +++++
>   7 files changed, 13 insertions(+), 23 deletions(-)
>   delete mode 100644 Documentation/devicetree/bindings/arm/atmel-pmc.txt
> 


-- 
Nicolas Ferre
