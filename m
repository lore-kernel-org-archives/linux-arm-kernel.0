From: codekipper@gmail.com (Code Kipper)
Date: Tue, 19 Apr 2016 21:49:46 +0200
Subject: [linux-sunxi] Re: [PATCH v1 1/1] add missing UARTs pins for
 AllWinner H3 DTS + add new I2C entries for AllWinner H3 DTS
In-Reply-To: <CAGb2v65dsjbpGUrJXFG35cLGnFA6uDxtgMqupBN97=8XNnO68Q@mail.gmail.com>
References: <8673D89D449742EAB9F6EBD05655A295@GirolesWin7>
 <CAGb2v67e_F1=VaY7ovzW7Whc2ToJU3YabeT-orrLTb0Pouhw_Q@mail.gmail.com>
 <21e74cd8-2ec7-4fd3-aa5c-ba4eed29a6ab@googlegroups.com>
 <CAGb2v65dsjbpGUrJXFG35cLGnFA6uDxtgMqupBN97=8XNnO68Q@mail.gmail.com>
Message-ID: <CAEKpxBnH5UH8ATtRTAJ_M2dfyvhzq08mTvfOoW_i+P6w3ciusw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 19 April 2016 at 17:11, Chen-Yu Tsai <wens@csie.org> wrote:
> On Tue, Apr 19, 2016 at 10:46 PM,  <martinayotte@gmail.com> wrote:
>> Hi ChenYu,
>>
>> Thanks for your comments.
>>
>> On Tuesday, April 19, 2016 at 7:11:50 AM UTC-4, Chen-Yu Tsai wrote:
>>> Hi,
>>>
>>> >  arch/arm/boot/dts/sun8i-h3-orangepi-2.dts  | 36 ++++++++++++++
>>> >  arch/arm/boot/dts/sun8i-h3-orangepi-pc.dts | 36 ++++++++++++++
>>> >  arch/arm/boot/dts/sun8i-h3.dtsi            | 75
>>>
>>> First of all, you are touching 3 different files here. These should
>>> be separate patches.
>>
>> I'm trying to understand you here, but I can't. Those 3 files changed are related each other. I could have separated the UART changes from I2C changes, but still those 3 files would have been modified at the same time for a single commit and "git patch-format" would still have created a single patch for the 3 files commit.
>
> Try to wrap lines to 80 characters or less.
>
> 1 change per patch. You are making 3 changes here. a) adding shared
> pinmux settings,
> b & c) enabling uarts and i2c busses for 2 boards.
>
> You could split them into 1 dtsi patch adding the pinmux setting, and
> then 1 for each
> board enabling the peripherals.
>
>>
>> Seeing all the patches that coming into the mailing lists, all of them contains multiple files patches, why should it be different here ?
>>
>>>
>>> Secondly, our policy is to not have a default function for generic GPIO pins.
>>>
>>
>> If this is the official policy, then why so many DTS currently present are not following the same rules, such sun6i-a31-hummingbird, sun7i-a20-olinuxino-micro, sun7i-a20-mk808c, sun7i-a20-cubietruck and so many others ?
>
> Perhaps they were enabled before the policy was enacted, or it just
> slipped through. I
> contributed to a few. But for many boards we might not have schematics
> or the actual
> device to check.
>
> Also, other boards having such settings is not a good argument.
+1 for what Wen is saying here. If the pins go to a header then it's
best to leave it as a GPIO. Uart2 on the mk808c is enabled as it's
used for Bluetooth.
CK

>
>> I thought the rules were there to make DTS the most default common usage definitions for most end-users in a general availability.
>> Then, if someone is really in shortage of GPIOs, they could easily turn them back to "disabled" state.
>
> How would you determine what the most common usage is for "development boards"?
> If the vendor explicitly designed the pins to be used one way, and even printed
> the description on the board, then you may have a valid argument. But even then,
> with the C.H.I.P., they are going with DT overlays.
>
> It shouldn't be hard for an end user to modify the DT. And with I2C devices, it
> is almost a requirement.
>
>
> Regards
> ChenYu
>
> --
> You received this message because you are subscribed to the Google Groups "linux-sunxi" group.
> To unsubscribe from this group and stop receiving emails from it, send an email to linux-sunxi+unsubscribe at googlegroups.com.
> For more options, visit https://groups.google.com/d/optout.
