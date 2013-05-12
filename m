From: linus.walleij@linaro.org (Linus Walleij)
Date: Mon, 13 May 2013 01:36:23 +0200
Subject: [PATCH] pinctrl: document the "GPIO mode" pitfall
In-Reply-To: <2359346.pRaN3J5Bl7@avalon>
References: <1363345636-2006-1-git-send-email-linus.walleij@stericsson.com>
 <1761651.lXztZzrj1S@avalon>
 <CACRpkdaMdU4DHWULnSB_dvGk8pTRbirL1HVTGqJ2rwqXR798uQ@mail.gmail.com>
 <2359346.pRaN3J5Bl7@avalon>
Message-ID: <CACRpkdauJ1DUn2FYWT7gqM3pW3QGzjimFnDgzqmDrZXMk9Yu0Q@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, Apr 27, 2013 at 3:16 AM, Laurent Pinchart
<laurent.pinchart@ideasonboard.com> wrote:
> On Friday 26 April 2013 10:49:12 Linus Walleij wrote:

>> > Does DRIVE_* imply that the pin is driven by the selected function, and
>> > OUTPUT imply that the pin is driven to a fixed level ?
>>
>> That is unclear, but I suggest DRIVE* implies that everything on the pin
>> is driven according to that configuration. (Else it is getting ignored...)
>>
>> OUTPUT would be used when you don't know the particulars or when
>> the driving cannot be controlled in a fine-grained manner like with the
>> DRIVE* configs.
>>
>> Does this make sense?
>
> Kinda, but it's still unclear to me. While the options are (briefly)
> documented, how they interact isn't.

Do you think the sematics need to be etched in stone or do
you think it could be left as driver-specific, like if I write in the
defintion that the interaction of different config arguments is up
to the driver?

>> > What about cases where I want to drive the pin to a fixed level in a non
>> > low-power output mode (for instance because I need more current that what
>> > the low-power output mode provides) ?
>>
>> Just use pinconfig for that?
>
> How would you do so ? Only OUTPUT allows setting the output level explictly,
> the other DRIVE_* options don't specify the output level.

The PIN_CONFIG_DRIVE_STRENGTH argument is in mA.

Is this what you're after or something else?

Yours,
Linus Walleij
