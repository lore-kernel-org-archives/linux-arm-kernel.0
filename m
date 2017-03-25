From: martin.blumenstingl@googlemail.com (Martin Blumenstingl)
Date: Sat, 25 Mar 2017 19:28:03 +0100
Subject: [PATCH 2/2] iio: adc: meson-saradc: add Meson8b SoC compatibility
In-Reply-To: <231f1fef-e947-3461-2e5b-99d80abfa73a@kernel.org>
References: <20170325162938.28659-1-martin.blumenstingl@googlemail.com>
 <20170325162938.28659-3-martin.blumenstingl@googlemail.com>
 <231f1fef-e947-3461-2e5b-99d80abfa73a@kernel.org>
Message-ID: <CAFBinCDVLZdBEX=UnGKFCkRF02YYx4hoRw54+AcwAku9zGjvaQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, Mar 25, 2017 at 7:13 PM, Jonathan Cameron <jic23@kernel.org> wrote:
> On 25/03/17 16:29, Martin Blumenstingl wrote:
>> Meson GX SoCs however use some magic bits to prevent simultaneous (=
>> conflicting, because only consumer should use the FIFO buffer with the
>> ADC results) usage by the Linux kernel and the bootloader (the BL30
>> bootloader uses the SAR ADC to read the CPU temperature).
>> This patch changes guards all BL30 functionality so it is skipped on
>> SoCs which don't have it. Since the hardware itself doesn't know whether
>> BL30 is available the internal meson_sar_adc_data is extended so this
>> information can be provided per of_device_id.data inside the driver.
>>
>> Additionally the clocks "adc_clk" and "adc_sel" are not provided by the
>> clock-controller itself. "adc_sel" is not available at all. "adc_clk"
>> is provided by the SAR ADC IP block itself on Meson8b (and earlier).
>> This is already supported by the meson_saradc driver.
>>
>> Finally a new of_device_id for the Meson8b SoC is added so it can be
>> wired up in the corresponding DT.
>>
>> Signed-off-by: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
> Looks sensible to me. Just fix those bits from Peter and we'll let it sit
> a few days on the list to see if anyone else wants to chip in.
OK, we'll have to wait for one of the DT-maintainers ACK (on the other
patch) anyways, so I'll re-spin this in a week or so and fix
everything that has come up until then
