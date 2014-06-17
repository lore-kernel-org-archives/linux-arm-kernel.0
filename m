From: dianders@google.com (Doug Anderson)
Date: Mon, 16 Jun 2014 21:07:44 -0700
Subject: [PATCH 3/3] ARM: dts: Enable audio support for Peach-pi board
In-Reply-To: <CAC5m3Byeu5zdM=PeK5MkgsEOFRjrPd1Vrk1a3FaM7VPTOFyYOg@mail.gmail.com>
References: <1402464739-19044-1-git-send-email-tushar.b@samsung.com>
 <1402464739-19044-4-git-send-email-tushar.b@samsung.com>
 <CAD=FV=XqqP7+xDOAKCixivzgaO0xvJX7L+CCN+unAEuf-6aUbQ@mail.gmail.com>
 <539ED2C0.8030405@gmail.com>
 <CAD=FV=UaaRQVq3TmXMTv9OkER+zORC89YfPNjwZwfCQKmuavrw@mail.gmail.com>
 <CAC5m3Byeu5zdM=PeK5MkgsEOFRjrPd1Vrk1a3FaM7VPTOFyYOg@mail.gmail.com>
Message-ID: <CAD=FV=U51f+sL_hSGdzusthC3OEgv3kbQ9t1G28JRgXueFYQEQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Tushar,

On Mon, Jun 16, 2014 at 8:36 PM, Tushar Behera <trblinux@gmail.com> wrote:
> On Mon, Jun 16, 2014 at 10:19 PM, Doug Anderson <dianders@google.com> wrote:
>> Tushar,
>>
>> On Mon, Jun 16, 2014 at 4:19 AM, Tushar Behera <trblinux@gmail.com> wrote:
>>> On 06/13/2014 10:33 PM, Doug Anderson wrote:
>>>> Tushar,
>>>>
>>>> On Tue, Jun 10, 2014 at 10:32 PM, Tushar Behera <tushar.b@samsung.com> wrote:
>>>>> Peach-pi board has MAX98090 audio codec connected on HSI2C-7 bus.
>>>>
>>>> If you want to be a stickler about it, peach-pi actually has a
>>>> max98091.  That requires code changes to the i2c driver, though.
>>>> ...and unfortunately listing two compatible strings for i2c devices is
>>>> broken.  :(
>>>>
>>> Hi Doug,
>>>
>>> You are right. I checked the boot logs, the detected codec type is
>>> MAX98091. Since both these CODECs are supported through a single driver
>>> and the detection of chip is done during runtime, I would suggest we go
>>> ahead with "max98090" compatible string. I will update the commit
>>> message accordingly.
>>>
>>> Does that sound okay to you?
>>
>> As per my understanding you shouldn't do this.  You should have two patches:
>>
>> 1. Add "max98091".  You could simply post Wonjoon's patch from
>> <https://chromium-review.googlesource.com/184091>
>>
>> 2. Change the device tree to refer to "max98091"
>>
>> The argument that the "current kernel driver has a single driver" is
>> an argument that you're not supposed to make for device tree.  The
>> same device tree is supposed to work for U-Boot, BSD, or any other
>> platform.  On those platforms it might not be a shared driver.
>>
>
> My argument is that the device type is getting detected during
> runtime, hence there is no need to differentiate between these two.
>
> But if you prefer that way, I will repost.

Yes please.

True that it is possible to detect 98090 vs. 98091.  ...but it's also
possible to detect exynos5250 vs. exynos5420 vs. exynos5800.  ...yet
they have different compatible strings.
