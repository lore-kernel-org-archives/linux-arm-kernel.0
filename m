From: javier.martinez@collabora.co.uk (Javier Martinez Canillas)
Date: Tue, 24 Jun 2014 18:33:37 +0200
Subject: [PATCH v2] ARM: dts: Add cros_ec to exynos5420-peach-pit and
 exynos5800-peach-pi
In-Reply-To: <CAD=FV=WwmjyH4Uq_SeRMf9-f6pgu+HpkZYRx_Sv-CJV-z8rkmA@mail.gmail.com>
References: <1403556576-8038-1-git-send-email-dianders@chromium.org>	<53A91E09.7050603@gmail.com>
 <CAD=FV=WwmjyH4Uq_SeRMf9-f6pgu+HpkZYRx_Sv-CJV-z8rkmA@mail.gmail.com>
Message-ID: <53A9A861.4020502@collabora.co.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello Doug,

On 06/24/2014 06:28 PM, Doug Anderson wrote:
> Tushar,
> 
> On Mon, Jun 23, 2014 at 11:43 PM, Tushar Behera <trblinux@gmail.com> wrote:
>> On 06/24/2014 02:19 AM, Doug Anderson wrote:
>>> This adds cros_ec to exynos5420-peach-pit and exynos5800-peach-pi,
>>> including:
>>> * The keyboard
>>> * The i2c tunnel
>>> * The tps65090 under the i2c tunnel
>>> * The battery under the i2c tunnel
>>>
>>> To add extra motivation, it should be noted that tps65090 is one of
>>> the things needed to get display-related FETs turned on for pit and
>>> pi.
>>>
>>> Note that this relies on a few outstanding changes:
>>> * Needs (spi: s3c64xx: fix broken "cs_gpios" usage in the driver) and
>>>   (spi: s3c64xx: for DT platofrms always get the chipselect info from
>>>   DT node) to work properly and match the documented bindings.  See
>>>   <https://patchwork.kernel.org/patch/4346701/> and
>>>   <https://patchwork.kernel.org/patch/4346711/>
>>>
>>> Signed-off-by: Doug Anderson <dianders@chromium.org>
>>> Tested-by: Javier Martinez Canillas <javier.martinez@collabora.co.uk>
>>
>> Along with the dependency patches on next-20140623, tested keyboard on
>> Peach-Pi board.
>>
>> Tested-by: Tushar Behera <tushar.b@samsung.com>
>>
>> Some comments below.
>>
>>> ---
>>> Changes in v2:
>>> - Now just one patch since mfd patch landed.
>>> - Rebased to ToT linux-next
>>>
>>>  arch/arm/boot/dts/exynos5420-peach-pit.dts | 145 +++++++++++++++++++++++++++++
>>>  arch/arm/boot/dts/exynos5800-peach-pi.dts  | 145 +++++++++++++++++++++++++++++
>>>  2 files changed, 290 insertions(+)
>>>
>>> diff --git a/arch/arm/boot/dts/exynos5420-peach-pit.dts b/arch/arm/boot/dts/exynos5420-peach-pit.dts
>>> index 7649982..581f385 100644
>>> --- a/arch/arm/boot/dts/exynos5420-peach-pit.dts
>>> +++ b/arch/arm/boot/dts/exynos5420-peach-pit.dts
>>
>>> +                             regulators {
>>> +                                     dcdc1 {
>>> +                                             ti,enable-ext-control;
>>> +                                     };
>>> +                                     dcdc2 {
>>> +                                             ti,enable-ext-control;
>>> +                                     };
>>> +                                     dcdc3 {
>>> +                                             ti,enable-ext-control;
>>> +                                     };
>>> +                                     fet1 {
>>
>> "tps65090_fet1: fet1 {" ?
>>
>>> +                                             regulator-name = "vcd_led";
>>> +                                     };
>>> +                                     tps65090_fet2: fet2 {
>>
>> I would suggest we add similar labels to fet1, fet3, fet4, fet5 and fet6
>> also. That way it would be easy to reference them in subsequent DT nodes.
>>
>> Same comment for Peach-Pi dts file too.
> 
> OK.  I added it to all the regulators in tps65090.  That'll probably
> be useful for Javier in his max77802 work.
>

Thanks, in fact I did add both tps65090_dcdc1 and tps65090_dcdc2 labels to be
able to use these regulators as supply for some of the max77802 regulators.

Will rebase on top of this.

Best regards,
Javier

> -Doug
> 
