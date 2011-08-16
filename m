From: linus.walleij@linaro.org (Linus Walleij)
Date: Tue, 16 Aug 2011 11:21:50 +0200
Subject: PB1176 broken in -rc1
In-Reply-To: <20110810152400.GO10121@e102144-lin.cambridge.arm.com>
References: <20110810152400.GO10121@e102144-lin.cambridge.arm.com>
Message-ID: <CACRpkdaoDJy-YKONaz2j07pPvTZuHZ7KgEm6XGxNXK-jNzB8_w@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Aug 10, 2011 at 5:24 PM, Will Deacon <will.deacon@arm.com> wrote:

> Hi Linus,
>
> My PB1176 platform appears to lock up as soon as it hits userspace when
> running a 3.1-rc1 kernel.

My kernel does not even boot on either -rc1 or -rc2 on the
PB1176, with or wthout Jamies poisoning fixup.

Did you change anything else on top of -rc1 when you tested this?

Will, Jamie, any hints?

If I cherry-pick my TCM patches adding PB1176 support to a clean
v3.0 branch, everything works fine, so I suspect I am not guilty for
this AFAICT, it's something else.

Also the -rc2 code works fine on U300 which has a TCM,
ARM926-EJS.

P.S. By the way regarding this:

> [ ? ?0.000000] CPU: found DTCM0 4k @ 00000000, not enabled
> [ ? ?0.000000] CPU: moved DTCM0 4k to fffe8000, enabled
> [ ? ?0.000000] CPU: found DTCM1 4k @ 00000000, not enabled
> [ ? ?0.000000] CPU: moved DTCM1 4k to fffe9000, enabled
> [ ? ?0.000000] CPU: found ITCM0 4k @ 00000000, not enabled
> [ ? ?0.000000] CPU: moved ITCM0 4k to fffe0000, enabled
> [ ? ?0.000000] CPU: found ITCM1 4k @ 00000000, not enabled
> [ ? ?0.000000] CPU: moved ITCM1 4k to fffe1000, enabled

[Will]
> The NULL addresses in the dmesg look
> strange to me, but I'm not familiar with the TCMs.

This looks perfectly normal. The TCMs are default disabled and mapped
to address 0x00000000, I activate them and move them to our desired
location.

Thanks,
Linus Walleij
