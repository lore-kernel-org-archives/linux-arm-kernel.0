From: linus.walleij@linaro.org (Linus Walleij)
Date: Wed, 16 May 2012 09:14:47 +0200
Subject: [PATCH] pinctrl: Add generic pinctrl-simple driver that supports
 omap2+ padconf
In-Reply-To: <4FB1513A.4070002@wwwdotorg.org>
References: <20120503065131.GA3738@game.jcrosoft.org>
 <20120503152708.GC5140@atomide.com>
 <4FA30805.5050804@wwwdotorg.org>
 <20120504044305.GD7788@game.jcrosoft.org>
 <20120504150342.GI5140@atomide.com>
 <20120504153251.GE7788@game.jcrosoft.org>
 <20120504163420.GA5613@atomide.com>
 <4FA42631.6060304@wwwdotorg.org>
 <20120504220809.GW5613@atomide.com>
 <4FAAD141.3090306@wwwdotorg.org>
 <20120509204925.GV5088@atomide.com> <4FABF553.20601@wwwdotorg.org>
 <CACRpkdbqjofEi-5J+GTMOXFK1VvbXqa6At1fKXCge+5_y6aaRA@mail.gmail.com>
 <4FB1513A.4070002@wwwdotorg.org>
Message-ID: <CACRpkdZCJXy4EMCa0x8pOLUOz=646_housV8qyqMh9AgfwxxUw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, May 14, 2012 at 8:38 PM, Stephen Warren <swarren@wwwdotorg.org> wrote:
> On 05/12/2012 05:49 PM, Linus Walleij wrote:
>>
>> We have some pinctrl drivers implementing gpiolib too already,
>> and it's unavoidable I think, as some recent discussion about
>> matcing struct gpio_chip and pinctrl GPIO ranges shows.
>
> I strongly believe we should only do this when the exact same HW module
> is both pinctrl and GPIO.

Yep so this is what I have done for pinctrl-nomadik.c

> When there are separate HW modules, we should have separate drivers. The
> fact that the two drivers need to co-ordinate with each-other isn't a
> good argument to make them one driver.

So this matches the pinctrl-u300.c/pinctrl-coh901.c design pattern.

>> Maybe "-simple" isn't such a good name for this thing. Noone thinks
>> any kind of pin control is simple in any sense of the word anyway :-D
>>
>> Tony, would pinctrl-dt-only.c be a better name perhaps?
>
> That might be OK for the filename, but it doesn't seem like a useful
> change for the DT compatible value.

Oh I didn't think of these. Hm from a generic world running Windows
Mobile etc I take it that this is seen as simple mappings then?

Yours,
Linus Walleij
