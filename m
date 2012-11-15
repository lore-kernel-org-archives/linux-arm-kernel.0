From: rob.clark@linaro.org (Rob Clark)
Date: Thu, 15 Nov 2012 07:04:24 -0600
Subject: [PATCH] ARM: add get_user() support for 8 byte types
In-Reply-To: <201211150919.37343.arnd@arndb.de>
References: <1352495853-9790-1-git-send-email-rob.clark@linaro.org>
 <201211130911.09613.arnd@arndb.de>
 <20121113112430.GF28341@n2100.arm.linux.org.uk>
 <201211150919.37343.arnd@arndb.de>
Message-ID: <CAF6AEGv-O_D6nOnEwi5w8NUcv+dQFe7pJBXhUA8xq+tykG4dfg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Nov 15, 2012 at 3:19 AM, Arnd Bergmann <arnd@arndb.de> wrote:
> On Tuesday 13 November 2012, Russell King - ARM Linux wrote:
>> You're missing something; that is one of the greatest powers of open
>> source.  The many eyes (and minds) effect.  Someone out there probably
>> has a solution to whatever problem, the trick is to find that person. :)
>>
>> I think we have a working solution for this for ARM.  It won't be suitable
>> for every arch, where they have 8-bit and 16-bit registers able to be
>> allocated by the compiler, but for architectures where the minimum register
>> size is 32-bit, what we have below should work.
>
> I don't mind at all adding the extension to ARM, and I think it's pretty
> cool that you guys actually found a working solution.
>
> The part that worries me is that we are making architecture independent
> code depend on a clever hack that may or may not be possible to implement
> on a given architecture, and that most architecture maintainers wouldn't
> know how to implement correctly even if it's possible.

I could always send a 3rd version with a comment smashed on about why
that works if you think this is a problem..

BR,
-R

>         Arnd
> --
> To unsubscribe from this list: send the line "unsubscribe linux-omap" in
> the body of a message to majordomo at vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
