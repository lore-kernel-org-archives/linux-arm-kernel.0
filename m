From: sr@denx.de (Stefan Roese)
Date: Wed, 13 Apr 2016 07:30:15 +0200
Subject: [PATCH v3] spi: orion.c: Add direct access mode
In-Reply-To: <20160412192736.GC14664@sirena.org.uk>
References: <1460030811-13787-1-git-send-email-sr@denx.de>
 <20160411105740.GB3351@sirena.org.uk> <570CDF5F.9070106@denx.de>
 <20160412192736.GC14664@sirena.org.uk>
Message-ID: <570DD967.8010703@denx.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 12.04.2016 21:27, Mark Brown wrote:
> On Tue, Apr 12, 2016 at 01:43:27PM +0200, Stefan Roese wrote:
>> On 11.04.2016 12:57, Mark Brown wrote:
>>> On Thu, Apr 07, 2016 at 02:06:51PM +0200, Stefan Roese wrote:

<snip>

>>>> +               spi->direct_access[cs].vaddr = devm_ioremap_resource(&pdev->dev,
>>>> +                                                                    r);
>>>> +               if (IS_ERR(spi->direct_access[cs].vaddr)) {
>
>>> I seem to be missing where we configure the hardware to connect the
>>> windows to the chip selects.  We just seem to map the windows but never
>>> otherwise interact with the hardware.
>
>> The connection between the CS and the window is done in the DT. All
>> is now implemented as Arnd has suggested:
>
> Writing something in the DT won't magically configure anything in the
> hardware which is (as I said) the bit I'm missing.

The MBus driver (drivers/bus/mvebu-mbus.c) takes care of the MBus
window mapping. This is done, if the board dts files has one (or
multiple) entries for the SPI device(s) added to the 'ranges'
property of the 'soc' node.

This is the common method to map such windows. So no new code and
no new bindings are needed for this to work.

Thanks,
Stefan
