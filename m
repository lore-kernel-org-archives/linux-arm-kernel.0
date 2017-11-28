From: robh@kernel.org (Rob Herring)
Date: Tue, 28 Nov 2017 13:38:00 -0600
Subject: [PATCH 3/6] arm: dts: marvell: Add missing #phy-cells to
 usb-nop-xceiv
In-Reply-To: <87po8az1uc.fsf@free-electrons.com>
References: <20171109222614.5719-1-robh@kernel.org>
 <20171109222614.5719-3-robh@kernel.org>
 <CAL_JsqJhq7TqdaS+i8yk8rRJM0hH2hyk8eybXsnR0D8QoncXZg@mail.gmail.com>
 <20171121200922.GD30040@lunn.ch>
 <CAK8P3a1x7mnpvfgsnwVJdX4OFwJZn0GpTE9ATfoLuQPB5ev=gg@mail.gmail.com>
 <87po8az1uc.fsf@free-electrons.com>
Message-ID: <CAL_JsqK1rVRnKaYf7PCiy9vTw7VZb6xEiNa80NSe41yQUavvxg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Nov 22, 2017 at 10:59 AM, Gregory CLEMENT
<gregory.clement@free-electrons.com> wrote:
> Hi Arnd,
>
>  On mar., nov. 21 2017, Arnd Bergmann <arnd@arndb.de> wrote:
>
>> On Tue, Nov 21, 2017 at 9:09 PM, Andrew Lunn <andrew@lunn.ch> wrote:
>>> On Tue, Nov 21, 2017 at 12:29:48PM -0600, Rob Herring wrote:
>>>> On Thu, Nov 9, 2017 at 4:26 PM, Rob Herring <robh@kernel.org> wrote:
>>>> > "usb-nop-xceiv" is using the phy binding, but is missing #phy-cells
>>>> > property. This is probably because the binding was the precursor to the phy
>>>> > binding.
>>>> >
>>>> > Fixes the following warning in Marvell dts files:
>>>> >
>>>> > Warning (phys_property): Missing property '#phy-cells' in node ...
>>>> >
>>>> > Signed-off-by: Rob Herring <robh@kernel.org>
>>>> > Cc: Jason Cooper <jason@lakedaemon.net>
>>>> > Cc: Andrew Lunn <andrew@lunn.ch>
>>>> > Cc: Gregory Clement <gregory.clement@free-electrons.com>
>>>> > Cc: Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>
>>>> > ---
>>>> > Please apply to Marvell tree.
>>>>
>>>> Ping.
>>>>
>>>> Arnd, can you apply if you'd like the warnings fixed and Marvell
>>>> maintainers don't respond.
>>>
>>> Hi Rob
>>>
>>> Patches submitted a week before the merge window opens are generally
>>> deferred to the next cycle. I expect that once -rc1 is out, Gregory
>>> will pick up this patch.
>>
>> These are real bugfixes, I want them in 4.15, since we now get a
>> loud warning for them. I'd rather not shut up that warning because
>> it's not a false-positive.
>
> As pointed by Andrew, I planned to take them once the 4.15-rc1 would be
> released. It was not obvious for me that it was real fixes. Actually I
> would have expected to have first the dts fixed in a release and then
> the warning enabled.

I didn't plan to fix everyone's warnings for them. Unfortunately, the
combination of linux-next being infrequent in Oct and kernelci.org
failing to report dtc warnings caused all the warnings started to get
noticed late, so I fixed the noisier cases. The only way anyone pays
attention is when dtc is updated and warnings appear. I've emailed out
warnings in advance before. I've turned off the more subjective ones
by default. Neither seems to get widely noticed (now in reviews
instead of saying "don't do X", I say "don't do X and building with
W=2 will tell you this"). More dtc checks are coming, so I'm open to
suggestions on the process.

Rob
