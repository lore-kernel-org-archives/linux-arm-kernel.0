From: hdegoede@redhat.com (Hans de Goede)
Date: Wed, 12 Aug 2015 12:18:43 +0200
Subject: [linux-sunxi] [PATCH] pinctrl: sun4i: add spdif to pin
 description.
In-Reply-To: <CAGb2v64A+T1aE622uvW6nCmJACWrtLVaLRfoLgh=CppGDrEX2A@mail.gmail.com>
References: <1439309965-9530-1-git-send-email-codekipper@gmail.com>
 <CAGb2v64Ptt5NgeicsYtiR8At+K4aDd3Lb3U4kijQ5UM+UafSrA@mail.gmail.com>
 <CAEKpxBmS6YJMjREc3gmeSQOzBXFKw=Sb-xPK57oUn6BtmASErg@mail.gmail.com>
 <55CB051D.3090109@redhat.com>
 <CAEKpxB=UQYEnwXYAzMZA4noR9Xg8wnSjD+H0bNO5GV3dtZQtTg@mail.gmail.com>
 <CAGb2v64A+T1aE622uvW6nCmJACWrtLVaLRfoLgh=CppGDrEX2A@mail.gmail.com>
Message-ID: <55CB1D83.2050106@redhat.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On 12-08-15 11:18, Chen-Yu Tsai wrote:
> On Wed, Aug 12, 2015 at 5:13 PM, Code Kipper <codekipper@gmail.com> wrote:
>> On 12 August 2015 at 10:34, Hans de Goede <hdegoede@redhat.com> wrote:
>>>
>>> Hi,
>>>
>>>
>>> On 12-08-15 07:31, Code Kipper wrote:
>>>>
>>>> On 11 August 2015 at 18:48, Chen-Yu Tsai <wens@csie.org> wrote:
>>>>
>>>>> On Wed, Aug 12, 2015 at 12:19 AM,  <codekipper@gmail.com> wrote:
>>>>>>
>>>>>> From: Marcus Cooper <codekipper@gmail.com>
>>>>>>
>>>>>> Signed-off-by: Marcus Cooper <codekipper@gmail.com>
>>>>>> ---
>>>>>>    drivers/pinctrl/sunxi/pinctrl-sun4i-a10.c | 9 ++++++---
>>>>>>    1 file changed, 6 insertions(+), 3 deletions(-)
>>>>>>
>>>>>> diff --git a/drivers/pinctrl/sunxi/pinctrl-sun4i-a10.c
>>>>>
>>>>> b/drivers/pinctrl/sunxi/pinctrl-sun4i-a10.c
>>>>>>
>>>>>> index 7376a97..daf7dec 100644
>>>>>> --- a/drivers/pinctrl/sunxi/pinctrl-sun4i-a10.c
>>>>>> +++ b/drivers/pinctrl/sunxi/pinctrl-sun4i-a10.c
>>>>>> @@ -135,7 +135,8 @@ static const struct sunxi_desc_pin sun4i_a10_pins[]
>>>>>
>>>>> = {
>>>>>>
>>>>>>           SUNXI_PIN(SUNXI_PINCTRL_PIN(B, 3),
>>>>>>                     SUNXI_FUNCTION(0x0, "gpio_in"),
>>>>>>                     SUNXI_FUNCTION(0x1, "gpio_out"),
>>>>>> -                 SUNXI_FUNCTION(0x2, "ir0")),          /* TX */
>>>>>> +                 SUNXI_FUNCTION(0x2, "ir0"),           /* TX */
>>>>>> +                 SUNXI_FUNCTION(0x4, "spdif")),        /* MCLK */
>>>>>>           SUNXI_PIN(SUNXI_PINCTRL_PIN(B, 4),
>>>>>>                     SUNXI_FUNCTION(0x0, "gpio_in"),
>>>>>>                     SUNXI_FUNCTION(0x1, "gpio_out"),
>>>>>> @@ -176,11 +177,13 @@ static const struct sunxi_desc_pin
>>>>>
>>>>> sun4i_a10_pins[] = {
>>>>>>
>>>>>>                     SUNXI_FUNCTION(0x0, "gpio_in"),
>>>>>>                     SUNXI_FUNCTION(0x1, "gpio_out"),
>>>>>>                     SUNXI_FUNCTION(0x2, "i2s"),           /* DI */
>>>>>> -                 SUNXI_FUNCTION(0x3, "ac97")),         /* DI */
>>>>>> +                 SUNXI_FUNCTION(0x3, "ac97"),          /* DI */
>>>>>> +                 SUNXI_FUNCTION(0x4, "spdif")),        /* DI */
>>>>>>           SUNXI_PIN(SUNXI_PINCTRL_PIN(B, 13),
>>>>>>                     SUNXI_FUNCTION(0x0, "gpio_in"),
>>>>>>                     SUNXI_FUNCTION(0x1, "gpio_out"),
>>>>>> -                 SUNXI_FUNCTION(0x2, "spi2")),         /* CS1 */
>>>>>> +                 SUNXI_FUNCTION(0x2, "spi2"),          /* CS1 */
>>>>>> +                 SUNXI_FUNCTION(0x4, "spdif")),        /* DO */
>>>>>
>>>>>
>>>>> The datasheet and manual list them as NC or Reserved. Maybe mention how
>>>>> you knew
>>>>> they were available?
>>>>>
>>>> Not sure if this deserves to be in the commit message but I can
>>>> definitely
>>>> put together a covering letter with links etc.
>>>
>>>
>>> I dear to say it belongs right there in the source code, use a multi-line
>>> comment above the SUNXI_FUNCTION(0x4, "spdif")) to explain where the mux
>>> info comes from. someday sooner or later someone is going to compare the
>>> kernel mux table to the datasheet and think "huh, that is not right",
>>> that person will be saved an immense amount of time by simply having a
>>> comment there.
>>
>> Good point I was thinking something along the lines of this
>> /*
>>   * The SPDIF block is not referenced at all in the A10 user
>>   * manual. However it is described in the code leaked and the
>>   * pin descriptions are declared in the A20 user manual which
>>   * is pin compatible with this device.
>>   */
>> Thing is do I add this above every spdif pin, the first change(MCLK) or the
>> pin most likely to be used(SPDIF DO)?
>
> I'd say put it before the first pin, and then reference it (like
> "undocumented, see the comment for pin P??? above", for the rest.

Ack / +1 exactly what I was thinking :)

Regards,

Hans


>
> ChenYu
>
>> Thanks,
>> CK
>>>
>>>
>>> And do NOT say that this will not happen, because I've already done
>>> such a comparison once in the past.
>>>
>>> Regards,
>>>
>>> Hans
>>
>>
