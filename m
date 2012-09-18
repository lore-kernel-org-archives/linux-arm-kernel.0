From: stigge@antcom.de (Roland Stigge)
Date: Tue, 18 Sep 2012 15:52:24 +0200
Subject: [PATCH] spi/pl022: Devicetree support w/o platform data
In-Reply-To: <201209181313.30880.arnd@arndb.de>
References: <1347972540-29667-1-git-send-email-stigge@antcom.de>
 <201209181313.30880.arnd@arndb.de>
Message-ID: <50587C98.7040103@antcom.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi!

On 09/18/2012 03:13 PM, Arnd Bergmann wrote:
> On Tuesday 18 September 2012, Roland Stigge wrote:
>> --- linux-2.6.orig/Documentation/devicetree/bindings/spi/spi_pl022.txt
>> +++ linux-2.6/Documentation/devicetree/bindings/spi/spi_pl022.txt
>> @@ -10,6 +10,15 @@ Optional properties:
>>  - cs-gpios : should specify GPIOs used for chipselects.
>>    The gpios will be referred to as reg = <index> in the SPI child nodes.
>>    If unspecified, a single SPI device without a chip select can be used.
>> +- pl022,bus-id : Bus ID (0, 1, ...)
> 
> I don't understand why we need the bus-id here. My understanding is that
> this is a linux-specific number that should not be necessary when all
> devices are described in the device tree rather than through spi_board_info.
> 
> Can't you just set master->bus_num to -1 when using the DT for probing?
> 
>> +- pl022,enable-dma : enables DMA driven transfers (boolean)
> 
> Similar thing here: Can't you just set the enable_dma flag when
> a dma channel is provided in the device tree and unset it otherwise?
> 
> It also seems a bit pointless to enable DMA mode when you don't provide
> a way to specify the channel at the same time.

Completely right! I'm removing pl022,bus-id, setting bus_id to -1 in the
dt case. And removing pl022,enable-dma since dma is anyway only useful
in the platform data case where the dma_filter() callback is specified.

Thanks for pointing this out,

Roland
