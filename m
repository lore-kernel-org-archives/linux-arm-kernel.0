From: wens@csie.org (Chen-Yu Tsai)
Date: Wed, 29 Oct 2014 09:54:10 +0800
Subject: [linux-sunxi] [PATCH 4/6] ARM: dts: sun9i: Add GPIO LEDs for A80
 Optimus board
In-Reply-To: <20141028202708.GB9255@lukather>
References: <1414489843-2680-1-git-send-email-wens@csie.org>
 <1414489843-2680-5-git-send-email-wens@csie.org>
 <B1174832-BCE8-4B92-A239-1388D4C5BAAF@dominion.thruhere.net>
 <20141028202708.GB9255@lukather>
Message-ID: <CAGb2v64t3hdAk4NRioqpFBS++VzvU_26hzgG14ucTgnho7MANg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Oct 29, 2014 at 4:27 AM, Maxime Ripard
<maxime.ripard@free-electrons.com> wrote:
> On Tue, Oct 28, 2014 at 12:04:28PM +0100, Koen Kooi wrote:
>>
>> > Op 28 okt. 2014, om 10:50 heeft Chen-Yu Tsai <wens@csie.org> het volgende geschreven:
>> >
>> > The A80 Optimus board has 3 usable LEDs that are controlled via GPIO.
>> >
>> > This patch adds support for 2 of them which are driver by GPIOs in the
>> > main pin controller. The remaining one uses GPIO from the R_PIO
>> > controller, which we don't support yet.
>>
>> Out of curiousity, are those LEDs labeled and if so, would it make
>> sense to assign default triggers matching the labels to them? As a
>> personal preference I tend to have one of the LEDs use the
>> 'heartbeat' trigger so I can see that it's alive.

They are not labeled in any meaningful way (LED2~4), are next to each
other, and are all the same color. Not very helpful. :|

The stock firmware uses them for mmc0, mmc1, and sleep activity.

> I'm not a huge fan of forcing this kind of policy decision down to the
> users, especially for such "generic" boards that don't have any
> labeled LEDs.
>
> I feel like it's a userspace decision, but I don't have a strong
> opinion on this :)

If the LEDs were more distinguishable from each other, I would go for
a default behavior. But that is not the case.

ChenYu
