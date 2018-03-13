From: codekipper@gmail.com (Code Kipper)
Date: Tue, 13 Mar 2018 09:15:49 +0100
Subject: [PATCH v2 4/6] ASoC: sun4i-i2s: Add multi-lane functionality
In-Reply-To: <20180313080026.jtag4w46koxzeqe2@flea>
References: <20180312155753.9478-1-codekipper@gmail.com>
 <20180312155753.9478-5-codekipper@gmail.com>
 <20180313080026.jtag4w46koxzeqe2@flea>
Message-ID: <CAEKpxBkE_Aipa3Z6r0HnVNuU-kmfr1zandotZzQ9Z0AkShR=rw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 13 March 2018 at 09:00, Maxime Ripard <maxime.ripard@bootlin.com> wrote:
> On Mon, Mar 12, 2018 at 04:57:51PM +0100, codekipper at gmail.com wrote:
>> From: Marcus Cooper <codekipper@gmail.com>
>>
>> The i2s block supports multi-lane i2s output however this functionality
>> is only possible in earlier SoCs where the pins are exposed and for
>> the i2s block used for HDMI audio on the later SoCs.
>>
>> To enable this functionality, an optional property has been added to
>> the bindings.
>>
>> Signed-off-by: Marcus Cooper <codekipper@gmail.com>
>> ---
>>  .../devicetree/bindings/sound/sun4i-i2s.txt        |  3 ++
>>  sound/soc/sunxi/sun4i-i2s.c                        | 48 +++++++++++++++++-----
>>  2 files changed, 41 insertions(+), 10 deletions(-)
>>
>> diff --git a/Documentation/devicetree/bindings/sound/sun4i-i2s.txt b/Documentation/devicetree/bindings/sound/sun4i-i2s.txt
>> index 48addef65b8f..3f966ac61b9e 100644
>> --- a/Documentation/devicetree/bindings/sound/sun4i-i2s.txt
>> +++ b/Documentation/devicetree/bindings/sound/sun4i-i2s.txt
>> @@ -33,6 +33,9 @@ Optional properties:
>>                               configured to extend the slot width to the
>>                               value specified. Min 8, Max 32.
>>
>> +- allwinner,playback-channels:  if this property is present then the number
>> +                             of available channels is extended and the
>> +                             outputs enabled.
>
> Isn't it something that is fixed for each generation of SoCs? Can't we
> attach it to the compatible?

I'm not sure as the documentation is pretty poor. It looks like it is
supported by all of the variations that we've seen but only exposed as
pins on A10 and A20. I'm also not sure who would ever use it with
external devices.
The reason why I've added it is that it is required by HDMI for
supporting surround sound on the newer SoCs.
CK

>
> Maxime
>
> --
> Maxime Ripard, Bootlin (formerly Free Electrons)
> Embedded Linux and Kernel engineering
> https://bootlin.com
