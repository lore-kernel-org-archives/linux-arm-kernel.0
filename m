From: gerg@linux-m68k.org (Greg Ungerer)
Date: Mon, 20 Mar 2017 21:52:29 +1000
Subject: [PATCH 1/2] spi: imx: set correct chip_select in platform setup
In-Reply-To: <20170320073815.GD3443@dragon>
References: <1489726983-17706-1-git-send-email-gerg@linux-m68k.org>
 <1489726983-17706-2-git-send-email-gerg@linux-m68k.org>
 <20170320073815.GD3443@dragon>
Message-ID: <b68d4ab2-67e5-e97f-5439-6c880c993249@linux-m68k.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 20/03/17 17:38, Shawn Guo wrote:
> On Fri, Mar 17, 2017 at 03:03:02PM +1000, Greg Ungerer wrote:
>> Some platform based configuration setup of spi-imx SPI devices does
>> not set the "chip_select" to the actual hardware chip select used.
>> This works because the cs_gpio mapping that is associated with this
>> platform setup maps the chip_select offset used to the appropriate
>> hardware chip select. The spi-imx driver uses the chip_select as an
>> index into the cs_gpio array and ultimately gets the correct hardware
>> chip select for its hardware setup.
>>
>> The motivation is to be able to eventually modify the spi-imx code to
>> use the "chip_select" directly for harwdare setup instead of indirectly
>> via the cs_gpio mapping array.
>>
>> This change only affects platforms using the hardware chip select
>> addressing method for their SPI devices (sometimes called native chip
>> select). The majority of devices using the spi-imx driver use the GPIO
>> addressing method.
>>
>> The change to use the correct "chip_select" is strait forward. But the
>> cs_gpio mapping arrary also needs to be modifed to match that change. In
>> simple terms the cs_gpio mapping should always have the hardware chip
>> select number at its same index offset.
>>
>> There is no functional change with these patches. The three affected
>> platforms should work exactly as before. However I don't have any of
>> these platforms (or access to them) and so I can't test them. So this
>> patch is compile tested only.
>>
>> Signed-off-by: Greg Ungerer <gerg@linux-m68k.org>
>
> The subject prefix should be 'ARM: imx: ...'.
>
> Since the patch can go independently, I fix up the prefix and applied
> the patch.  Thanks.

Thanks Shawn.

Regards
Greg
