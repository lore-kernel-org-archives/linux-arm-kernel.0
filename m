From: wangyuhang2014@gmail.com (yuhang wang)
Date: Fri, 23 Aug 2013 21:20:53 +0800
Subject: [PATCH V1 3/5] mtd: m25p80: add the quad-read support
In-Reply-To: <52174D25.9050805@gmail.com>
References: <1376885403-12156-1-git-send-email-b32955@freescale.com>
 <201308222229.01778.marex@denx.de>
 <20130822233611.GA25263@sirena.org.uk>
 <201308230158.05909.marex@denx.de>
 <20130823094141.GE25263@sirena.org.uk> <52174BAC.3070901@gmail.com>
 <52174D25.9050805@gmail.com>
Message-ID: <CAHSAbzPq7rDgEnQgtVDE7v6w2SoHAt522C9p+xz8azt7a+xDrQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

2013/8/23 Brian Norris <computersforpeace@gmail.com>:
> On 08/23/2013 04:46 AM, Brian Norris wrote:
>>
>> (Now that I've been pointed to the support merged into the SPI tree...)
>>
>> Aren't the following new DT properties (for the SPI slave) sufficient?
>>
>> spi-rx-nbits
>> spi-tx-nbits
>
> ...
>
>> They're already in the following commit:
>>
>> commit f477b7fb13df2b843997559ff34e87d054ba6538
>> Author: wangyuhang <wangyuhang2014@gmail.com>
>> Date:   Sun Aug 11 18:15:17 2013 +0800
>>
>>      spi: DUAL and QUAD support
>>
>>      fix the previous patch some mistake below:
>>      1. DT in slave node, use "spi-tx-nbits = <1/2/4>" in place of using
>>         "spi-tx-dual, spi-tx-quad" directly, same to rx. So correct the
>>         previous way to get the property in @of_register_spi_devices().
>>      2. Change the value of transfer bit macro(SPI_NBITS_SINGLE,
>> SPI_NBITS_DUAL
>>         SPI_NBITS_QUAD) to 0x01, 0x02 and 0x04 to match the actual wires.
>>      3. Add the following check
>>         (1)keep the tx_nbits and rx_nbits in spi_transfer is not beyond
>> the
>>            single, dual and quad.
>>         (2)keep tx_nbits and rx_nbits are contained by @spi_device->mode
>>            example: if @spi_device->mode = DUAL, then tx/rx_nbits can not
>> be set
>>                     to QUAD(SPI_NBITS_QUAD)
>>         (3)if "@spi_device->mode & SPI_3WIRE", then tx/rx_nbits should be
>> in
>>            single(SPI_NBITS_SINGLE)
>>
>>      Signed-off-by: wangyuhang <wangyuhang2014@gmail.com>
>>      Signed-off-by: Mark Brown <broonie@linaro.org>
>
>
> Speaking of which, the new device-tree properties are not documented in
> Documentation/devicetree/bindings/spi/spi-bus.txt yet.
>
> Brian

Sorry, because I don't have the entire environment in my own PC, so I
will update the document patch as soon as possible when I go back to
company.
