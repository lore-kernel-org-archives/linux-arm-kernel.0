From: linus.walleij@linaro.org (Linus Walleij)
Date: Fri, 29 Aug 2014 08:27:16 +0200
Subject: [PATCH 4/4] gpio: pca953x: Add DT binding for reset gpio
In-Reply-To: <1408008113.4035.29.camel@paszta.hi.pengutronix.de>
References: <1406618686-22385-1-git-send-email-mpa@pengutronix.de>
 <1406618686-22385-5-git-send-email-mpa@pengutronix.de>
 <CACRpkdY0TqVH1tJR1H89S5hvdJUboQdVtNvZnL3NeWit4f+amw@mail.gmail.com>
 <1407507094.3354.11.camel@paszta.hi.pengutronix.de>
 <CACRpkdY1x41=b_q83fejkTHXGG8GYDFNRUXdt=1AR_R4N18Rwg@mail.gmail.com>
 <1408008113.4035.29.camel@paszta.hi.pengutronix.de>
Message-ID: <CACRpkda7Bsff9EyWyF0WvVK50WQKcmABYX50pXkohUEoQ0ahQA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Aug 14, 2014 at 11:21 AM, Philipp Zabel <p.zabel@pengutronix.de> wrote:
> Am Montag, den 11.08.2014, 10:43 +0200 schrieb Linus Walleij:
>> On Fri, Aug 8, 2014 at 4:11 PM, Philipp Zabel <p.zabel@pengutronix.de> wrote:
>> > Am Freitag, den 08.08.2014, 15:14 +0200 schrieb Linus Walleij:

>> >> As it happens, Houcheng Lin has already proposed such a
>> >> driver:
>> >> http://marc.info/?l=linux-kernel&m=140309916607115&w=2
>> >
>> > That is a different issue, as there the device does not appear on the
>> > bus until the reset is released.
>>
>> You're just looking at the patch description. Look at what the
>> driver does.
>>
>> I wrote this reply to the patch:
>> http://marc.info/?l=linux-kernel&m=140480593524472&w=2
>>
>> With a delay of zero, the reset will be released
>> immediately, by the use of a helper OF node and this driver
>> from the reset subsystem. It's nice, generic code that solves
>> a generic problem of deasserting GPIO lines for
>> some reset.
>
> Yes, it does what you want. But its purpose is different, it's a bit
> indirect for the use case at hand,

I think a generic driver is always best, define what you mean
by "indirect" in this context.

> and we'll still find cases where this
> won't work (interaction with other pins).

But that is not what you're trying to solve right now.

> As to whether the sub-node
> might conflict with existing bindings, I don't know. This is something
> that should be taken to devicetree discussion list.

Um? I don't get this.

Yours,
Linus Walleij
