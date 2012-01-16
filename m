From: santosh.shilimkar@ti.com (Shilimkar, Santosh)
Date: Mon, 16 Jan 2012 14:22:13 +0100
Subject: OMAP3 L2/outer cache enabled in kernel (after being disabled by
 uBoot)?
In-Reply-To: <20120116131329.GA928@n2100.arm.linux.org.uk>
References: <WC20120116100344.4204CC@terrafix.co.uk>
 <CAMQu2gw4H=m1QA+ucORYsO_LZR8Sj57=+jwmrkHu_7sdCzhN8g@mail.gmail.com>
 <20120116105949.GG16726@n2100.arm.linux.org.uk>
 <CAMQu2gyBVOyWSCT39jP6xEtoNKrUCuaj_QTD+1EVhXgVc_H2HA@mail.gmail.com>
 <20120116131329.GA928@n2100.arm.linux.org.uk>
Message-ID: <CAMQu2gzPGrbBd4_SOM0TFfGH_Y+XYzoh2XjsoPgpzU10tFOpYQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Jan 16, 2012 at 2:13 PM, Russell King - ARM Linux
<linux@arm.linux.org.uk> wrote:
> On Mon, Jan 16, 2012 at 01:43:03PM +0100, Shilimkar, Santosh wrote:
>> This code will be in assembly and that's what I have
>> been using. Not having stack shoudn't be a blocker
>> and can be work-around in this code. And this API
>> has to be anyway called before MMU is enabled.
>
> What about SMC on OMAP potentially corrupting most of the integer
> registers? ?What if it corrupts an integer register which we depend
> upon? ?You don't have a stack here to save those registers. ?We'd
> need at least one additional register to save the old 'lr' value.
>
That's right.

> What about other secure monitors? ?Some implementations require you to
> give parameters via memory. ?How do you obtain that memory that early
> on in the kernel boot (you haven't parsed anything here.)
>
> Not only that but you're asking to make the kernel boot a _lot_ more
> fragile, when people start stuffing all kinds of utter shite into this
> hook - and then we're burdened again with the old 'my kernel won't
> boot and it remains silent, well your debug code is utter shite get rid
> of it' crap that we used to have in the early 2000s.
>
> I really don't want to go anywhere near that situation.
>
Fair point. It will be harder to maintain and won't be consistent.

>> Am not sure what you mean because secure API
>> as such isn't a problem. If you mean one standard interface
>> for all the ARM SOC's then that's something won't be
>> easy to handled because it is tied up the security architecture
>> which can vary across SoCs.
>
> The latter. ?This is exactly the kind of pain I forsaw with this security
> shite, and when I heard about it I was utterly dismayed at ARM Ltd for
> coming up with such a brain-dead lack of design here.
>
> You're having to struggle with the results of that by having lots of
> SoC specific hooks all around the place to fiddle with this that and the
> other. ?Your need to have something called from the early assembly code
> is just yet more of that disease caused by ARM Ltd's lack of forsight
> on this matter.
>
> I have no solution for you on this

I managed use some secure macro kind of code but as you said it
will be really hard to maintain.

So we are stuck with this issue then.

Regards
Santosh
