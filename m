From: u.kleine-koenig@pengutronix.de (Uwe =?iso-8859-1?Q?Kleine-K=F6nig?=)
Date: Tue, 27 Nov 2018 12:01:34 +0100
Subject: [PATCH v6 1/9] ARM: dts: Reflect change of FSL QSPI driver and
 remove unused properties
In-Reply-To: <1543314174-28580-2-git-send-email-frieder.schrempf@kontron.de>
References: <1543314174-28580-1-git-send-email-frieder.schrempf@kontron.de>
 <1543314174-28580-2-git-send-email-frieder.schrempf@kontron.de>
Message-ID: <20181127110134.7xdwo7ird44qj2ih@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello,

On Tue, Nov 27, 2018 at 10:24:19AM +0000, Schrempf Frieder wrote:
> The FSL QSPI driver will be moved to the SPI framework and it then
> acts as a SPI controller. Therefore the subnodes need to set
> spi-[rx/tx]-bus-width = <4>, so quad mode is used just as before.
> 
> Also the properties 'bus-num', 'fsl,spi-num-chipselects' and
> 'fsl,spi-flash-chipselects' were never read by the driver and
> can be removed.
> 
> The 'reg' properties are adjusted to reflect what bus and
> chipselect the flash is connected to, as the new driver needs
> this information.
> 
> The property 'fsl,qspi-has-second-chip' is not needed anymore
> and will be removed after the old driver was disabled to avoid
> breaking ls1021a-moxa-uc-8410a.dts.
> 
> Signed-off-by: Frieder Schrempf <frieder.schrempf@kontron.de>

do we need to change the binding document accordingly?

Best regards
Uwe

-- 
Pengutronix e.K.                           | Uwe Kleine-K?nig            |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
