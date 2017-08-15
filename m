From: codekipper@gmail.com (Code Kipper)
Date: Tue, 15 Aug 2017 09:23:53 +0200
Subject: [linux-sunxi] [PATCH v3 11/11] ASoC: sun4i-i2s: Add support for H3
In-Reply-To: <CAGb2v66T9gNhnuvM-z8ZVwtWjgg=i0O-H2QXuR_vvz9Vy_YbWg@mail.gmail.com>
References: <20170812110059.5115-1-codekipper@gmail.com>
 <20170812110059.5115-12-codekipper@gmail.com>
 <CAGb2v66T9gNhnuvM-z8ZVwtWjgg=i0O-H2QXuR_vvz9Vy_YbWg@mail.gmail.com>
Message-ID: <CAEKpxBnc_M9f5Muou6Z00X0UaM_tnXBwU96grtLJjVHnDv7XuQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 12 August 2017 at 14:27, Chen-Yu Tsai <wens@csie.org> wrote:
> On Sat, Aug 12, 2017 at 7:00 PM,  <codekipper@gmail.com> wrote:
>> From: Marcus Cooper <codekipper@gmail.com>
>>
>> The sun8i-h3 introduces a lot of changes to the i2s block such
>> as different register locations, extended clock division and
>> more operational modes. As we have to consider the earlier
>> implementation then these changes need to be isolated.
>>
>> None of the new functionality has been implemented yet, the
>> driver has just been expanded to allow it work on the H3 SoC.
>>
>> Signed-off-by: Marcus Cooper <codekipper@gmail.com>
>> ---
>>  .../devicetree/bindings/sound/sun4i-i2s.txt        |   2 +
>>  sound/soc/sunxi/sun4i-i2s.c                        | 176 ++++++++++++++++++++-
>>  2 files changed, 176 insertions(+), 2 deletions(-)
>>
>> diff --git a/Documentation/devicetree/bindings/sound/sun4i-i2s.txt b/Documentation/devicetree/bindings/sound/sun4i-i2s.txt
>> index ee21da865771..fc5da6080759 100644
>> --- a/Documentation/devicetree/bindings/sound/sun4i-i2s.txt
>> +++ b/Documentation/devicetree/bindings/sound/sun4i-i2s.txt
>> @@ -8,6 +8,7 @@ Required properties:
>>  - compatible: should be one of the following:
>>     - "allwinner,sun4i-a10-i2s"
>>     - "allwinner,sun6i-a31-i2s"
>> +   - "allwinner,sun8i-h3-i2s"
>>  - reg: physical base address of the controller and length of memory mapped
>>    region.
>>  - interrupts: should contain the I2S interrupt.
>> @@ -22,6 +23,7 @@ Required properties:
>>
>>  Required properties for the following compatibles:
>>         - "allwinner,sun6i-a31-i2s"
>> +       - "allwinner,sun8i-h3-i2s"
>>  - resets: phandle to the reset line for this codec
>>
>>  Example:
>> diff --git a/sound/soc/sunxi/sun4i-i2s.c b/sound/soc/sunxi/sun4i-i2s.c
>> index a6b464c8cc6c..b6faa95d972a 100644
>> --- a/sound/soc/sunxi/sun4i-i2s.c
>> +++ b/sound/soc/sunxi/sun4i-i2s.c
>> @@ -92,11 +92,41 @@
>>  #define SUN4I_I2S_RX_CHAN_SEL_REG      0x38
>>  #define SUN4I_I2S_RX_CHAN_MAP_REG      0x3c
>>
>> +/* Defines required for sun8i-h3 support */
>> +#define SUN8I_I2S_CTRL_BCLK_OUT                        BIT(18)
>> +#define SUN8I_I2S_CTRL_LRCK_OUT                        BIT(17)
>> +
>> +#define SUN8I_I2S_FMT0_LRCK_PERIOD_MASK                GENMASK(17, 8)
>> +#define SUN8I_I2S_FMT0_LRCK_PERIOD(period)     ((period << 8) - 1)
>
> I'm pretty sure this should be ((period - 1) << 8).
>
> Once fixed,
>
> Reviewed-by: Chen-Yu Tsai <wens@csie.org>
>
> P.S. the version tag for this series in the subject is wrong.

Hi Wens,
thanks for the reviews..I've ack'd them all and will push again once tested.
BR,
CK
