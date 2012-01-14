From: linus.walleij@linaro.org (Linus Walleij)
Date: Sat, 14 Jan 2012 12:41:21 +0100
Subject: [PATCH 2/2] mach-sa1100: modernize and cleanup timer code
In-Reply-To: <20120114084221.GM1068@n2100.arm.linux.org.uk>
References: <1325672513-16725-1-git-send-email-linus.walleij@linaro.org>
 <20120112161034.GE2645@Boggieman>
 <CACRpkdYZaxfArU3_i3RuhxT1-wMM80gn6pnZG_mMwg=Ba-oRgQ@mail.gmail.com>
 <20120114084221.GM1068@n2100.arm.linux.org.uk>
Message-ID: <CACRpkdYSKSV2cGrk5zTP5FhkkUc2Gvz344C=kqeheMAyNsfV8Q@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

2012/1/14 Russell King - ARM Linux <linux@arm.linux.org.uk>:
> On Sat, Jan 14, 2012 at 08:33:54AM +0100, Linus Walleij wrote:
>> On Thu, Jan 12, 2012 at 5:10 PM, Kristoffer Ericson
>> <kristoffer.ericson@gmail.com> wrote:
>>
>> > Urs?kta f?rseningen, fick n?got minne kring att cpu klockningen inte fungerade korrekt
>> > om man inte satte direkt systemklock v?rde. Var n?got som pratade med russell om
>> > f?r n?got ?r sedan.
>>
>> Menar du detta:
>> MIN_OSCR_DELTA * 2
>>
>> S? ?r det ju med i den nya koden oxo, det ?r ingen semantisk skillnad
>> s? vitt jag kan se...
>>
>> Det enda som egentligen ?ndras ?r att minimum lapse mellan tv? events
>> (mult+shift) ber?knas av clockevent core.
>
> If you speak english on these lists, other people might be able to
> understand what you're saying.

Haha sorry Russell I didn't notice that the response was in LAKML :-)

So Kristoffer remarked that the CPU clocking was sensitive on the
SA1100 so he wanted to test it first.

And I said that apart from the minimum scheduling interval now
handled by the clockevent core it should be semantically equivalent.

But it never hurts to test it so I'll wait for Kristoffers ACK.

Yours,
Linus Walleij
