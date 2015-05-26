From: linus.walleij@linaro.org (Linus Walleij)
Date: Tue, 26 May 2015 22:28:00 +0200
Subject: [PATCH v2 5/5] arm64: add KASan support
In-Reply-To: <55648193.3030003@samsung.com>
References: <1431698344-28054-1-git-send-email-a.ryabinin@samsung.com>
 <1431698344-28054-6-git-send-email-a.ryabinin@samsung.com>
 <CACRpkda3Pe9L14_iyKEfeCx1F3XJSLbz_OVHLxX0Lzy9Gt9t9Q@mail.gmail.com>
 <55647F57.8010008@samsung.com> <55648193.3030003@samsung.com>
Message-ID: <CACRpkdZsVqCy4pqVyu0_5+6m8dKdoa=60DU8fo59WZ6ZyQXRPA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, May 26, 2015 at 4:22 PM, Andrey Ryabinin <a.ryabinin@samsung.com> wrote:
> On 05/26/2015 05:12 PM, Andrey Ryabinin wrote:
>> On 05/26/2015 04:35 PM, Linus Walleij wrote:
>>> I wonder were the problem lies, any hints where to start looking
>>> to fix this?
>>>
>>
>> I suspect that your compiler lack -fsantize=kernel-address support.
>> It seems that GCC 4.9.2 doesn't supports -fsanitize=address/kernel-address on aarch64.
>>
>
> In that case you should get something like this, during kernel build:
>         scripts/Makefile.kasan:17: Cannot use CONFIG_KASAN: -fsanitize=kernel-address is not supported by compiler

Aha yep that's it when I look closer...

I'm going back and rebuilding my compiler. May as well do a trunk
5.0 build and try to get KASAN_INLINE working while I'm at it.

Yours,
Linus Walleij
