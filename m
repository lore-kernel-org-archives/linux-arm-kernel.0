From: yamada.masahiro@socionext.com (Masahiro Yamada)
Date: Sat, 5 Nov 2016 12:17:11 +0900
Subject: [PATCH 2/3] ARM: cache-uniphier: refactor jump label to follow
 coding style guideline
In-Reply-To: <20161104133221.GD1041@n2100.armlinux.org.uk>
References: <1478259816-24965-1-git-send-email-yamada.masahiro@socionext.com>
 <1478259816-24965-3-git-send-email-yamada.masahiro@socionext.com>
 <20161104122322.GB1041@n2100.armlinux.org.uk>
 <CAK7LNAQKCW2tDXEia7qZ+d9Xy1_ccHSGCat4=w+nfyHiuTHy6w@mail.gmail.com>
 <20161104133221.GD1041@n2100.armlinux.org.uk>
Message-ID: <CAK7LNAQeCn35s7T+c0YGedYZW5aWijUO2asZ6MFntzrUTdMtYw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

2016-11-04 22:32 GMT+09:00 Russell King - ARM Linux <linux@armlinux.org.uk>:
> On Fri, Nov 04, 2016 at 09:50:56PM +0900, Masahiro Yamada wrote:
>> Hi Russell,
>>
>> 2016-11-04 21:23 GMT+09:00 Russell King - ARM Linux <linux@armlinux.org.uk>:
>> > On Fri, Nov 04, 2016 at 08:43:35PM +0900, Masahiro Yamada wrote:
>> >> Documentation/CodingStyle recommends to use label names which say
>> >> what the goto does or why the goto exists.
>> >>
>> >> Just in case, split it up into three labels because the CodingStyle
>> >> says "one err bugs" is a common type of bug (although, I do not
>> >> believe the current code includes such a bug).
>> >
>> > However, this has the effect of making the code unnecessarily more
>> > complicated, which is a bad thing.  Avoiding unnecessary code
>> > complexity wins over style rules.
>>
>>
>> I thought this patch is stupid, but makes the code more straight-forward;
>> the failure path only calls really needed iounmap/kfree()
>> without exploiting that NULL input makes them no-op.
>
> ... while making it more fragile, because we're going back to a
> situation where the right places need to jump to the right label
> in the cleanup, so that the right functions are called.
>
> This is a backwards step.
>
> The reason that iounmap() and kfree() check for NULL pointers is to
> allow the cleanup paths to be simple, and that's very important as
> many cleanup paths are simply _not_ tested.


OK, fair enough.



-- 
Best Regards
Masahiro Yamada
