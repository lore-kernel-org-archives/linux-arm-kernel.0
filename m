From: frieder.schrempf@kontron.de (Schrempf Frieder)
Date: Tue, 27 Nov 2018 14:51:07 +0000
Subject: [PATCH v6 1/9] ARM: dts: Reflect change of FSL QSPI driver and
 remove unused properties
In-Reply-To: <20181127110134.7xdwo7ird44qj2ih@pengutronix.de>
References: <1543314174-28580-1-git-send-email-frieder.schrempf@kontron.de>
 <1543314174-28580-2-git-send-email-frieder.schrempf@kontron.de>
 <20181127110134.7xdwo7ird44qj2ih@pengutronix.de>
Message-ID: <145763f0-1e5c-3886-a11f-b37677715989@kontron.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Uwe,

I accidentally replied to the MTD list only, missing the other 
recipients, earlier today. So here comes the reply again.

On 27.11.18 12:01, Uwe Kleine-K?nig wrote:
> Hello,
> 
> On Tue, Nov 27, 2018 at 10:24:19AM +0000, Schrempf Frieder wrote:
>> The FSL QSPI driver will be moved to the SPI framework and it then
>> acts as a SPI controller. Therefore the subnodes need to set
>> spi-[rx/tx]-bus-width = <4>, so quad mode is used just as before.
>>
>> Also the properties 'bus-num', 'fsl,spi-num-chipselects' and
>> 'fsl,spi-flash-chipselects' were never read by the driver and
>> can be removed.
>>
>> The 'reg' properties are adjusted to reflect what bus and
>> chipselect the flash is connected to, as the new driver needs
>> this information.
>>
>> The property 'fsl,qspi-has-second-chip' is not needed anymore
>> and will be removed after the old driver was disabled to avoid
>> breaking ls1021a-moxa-uc-8410a.dts.
>>
>> Signed-off-by: Frieder Schrempf <frieder.schrempf@kontron.de>
> 
> do we need to change the binding document accordingly?

Bindings are changed here: https://patchwork.ozlabs.org/patch/1003761/

Thanks,
Frieder
