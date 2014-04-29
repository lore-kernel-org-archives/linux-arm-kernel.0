From: baohua@kernel.org (Barry Song)
Date: Tue, 29 Apr 2014 23:05:06 +0800
Subject: [PATCH] ARM: l2c: prima2: only call l2x0_of_init() on matching
 nodes
In-Reply-To: <20140428145223.GL26756@n2100.arm.linux.org.uk>
References: <1398644860-22973-1-git-send-email-mporter@linaro.org>
 <20140428142950.GB30292@saruman.home> <20140428143709.GC7719@beef>
 <20140428145223.GL26756@n2100.arm.linux.org.uk>
Message-ID: <CAGsJ_4x1+eePRDMP0-0WeTG6ZJdzmMkN_9USbKt8joY8AKsDdw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

2014-04-28 22:52 GMT+08:00 Russell King - ARM Linux <linux@arm.linux.org.uk>:
> On Mon, Apr 28, 2014 at 10:37:09AM -0400, Matt Porter wrote:
>> The "fix" is tested against bcm281xx and bcm21664 as that is what the
>> l2c cleanup breaks in -next. As mentioned, I don't have the sirfsoc h/w
>> so this first attempt at a fix also breaks their platform. It can be
>> addressed by adding those platform specific compatibles back to the dts,
>> of course.
>>
>> I'd much prefer that the sirfsoc folks fix this...it's going to break
>> other platforms in a multi v7 build.
>
> Well, it's about time we got rid of this from platform specific code
> anyway, taking it away from platform maintainers to mess around with.
> So that's what I'm doing.
>
> It's worth noting that if you build a single zImage with exynos also
> enabled, then you also end up with an unconditional call from that
> code to l2x0_of_init() with it's own magic numbers - and that applies
> before my changes.
>
> So let's fix this properly and yank this crap from platform maintainers
> fingers.

i mentioned dropping specific dts compatible prop will break non-csr
platforms in the mail thread "ARM: prima2: remove L2 cache size
override" and i said i was going to send v2. you said you need it
before rc6. now it has been sent, but i am sorry it is not against
next-20140424.

>
> --
> FTTC broadband for 0.8mile line: now at 9.7Mbps down 460kbps up... slowly
> improving, and getting towards what was expected from it.

-barry
