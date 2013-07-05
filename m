From: sourav.poddar@ti.com (Sourav Poddar)
Date: Fri, 5 Jul 2013 13:11:27 +0530
Subject: SPI: DUAL/QUAD support
In-Reply-To: <20130705073550.GA24258@sig21.net>
References: <CAHSAbzPNDSr_6N79fh0DTWSEg8buRRPyiw8SPodtKLPjzWXJsg@mail.gmail.com>
 <20130704130017.GA25997@sig21.net>
 <OFA0D5839D.0594EA10-ONC1257B9E.004A7347-C1257B9E.00524BA5@rohde-schwarz.com>
 <20130704154927.GE27646@sirena.org.uk>
 <OFAD729A05.8C915625-ONC1257B9E.00576B25-C1257B9E.0058477D@rohde-schwarz.com>
 <CAHSAbzOg+uHndydSC43moF7pijc67pqzB2rPnY69ynXHEzw79g@mail.gmail.com>
 <20980858CB6D3A4BAE95CA194937D5E73E9E4C2E@DBDE04.ent.ti.com>
 <20130705073550.GA24258@sig21.net>
Message-ID: <51D678A7.6050402@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Friday 05 July 2013 01:05 PM, Johannes Stezenbach wrote:
> On Fri, Jul 05, 2013 at 06:45:01AM +0000, Gupta, Pekon wrote:
>>> Just as Johannes said. In my patch m25p80's changes is incomplete.
>>> Because my inicial aim is to add the transfer width member to tell controller
>>> the mode flash in. And I will attach new patch about m25p80 later.
>>> Also you are right. There are really series of flashes do not support dual/quad
>>> transfer. So I don't know whether there are any standard for serial-flash just
>>> like the CFI for parallel-flash. Personally, to make a general standard and
>>> a general code for serial-flash is necessary. So that we do not need to add
>>> special function in m25p80.c.
>>>
>> [Pekon]: Does below generic framework for spianand, suit your driver?
>> http://lists.infradead.org/pipermail/linux-mtd/2013-July/047434.html
>>
>> you should be able to extend the generic spinand API for all
>> serial modes (SPI, Dual-SPI, Quad-SPI).
>> As QSPI and Dual-SPI devices should implicitly support SPI (MISO/MOSI)
>> So, you can do device probing using default SPI mode. And then based on
>> DT inputs and device support upgrade to QSPI / Dual-SPI mode.
>> And going forward extend it for direct memory-mapped device for XIP.
> Not sure what you have in mind since NAND and NOR flash work very
> differently, and SPI vs. memory-mapped is also very different.
>
> But to add to the spinand review comments two things caught
> my eye on quick glance over the code:
>
>> +#define mu_spi_nand_driver_version "Beagle-MTD_01.00_Linux2.6.33_20100507"
> seems like an unused leftover?  if the version number is
> important then maybe better put it in commit message?
>
Yes, actually its not required, should be removed.
>> +/bin/bash: 4: command not found
> how did this get in there?
>
>
Yes, this is useless, will  removed in the next version.
> Johannes
