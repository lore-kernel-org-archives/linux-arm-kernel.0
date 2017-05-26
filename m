From: yamada.masahiro@socionext.com (Masahiro Yamada)
Date: Fri, 26 May 2017 10:42:14 +0900
Subject: [GIT PULL (RESEND)] ARM: uniphier: UniPhier fixes for v4.12
In-Reply-To: <20170525235902.GA25387@localhost>
References: <CAK7LNARbSkbEOhs7QMd+6VV+KWbkjK4LR9rmQ=YBWqPY+8_XPQ@mail.gmail.com>
 <20170525235902.GA25387@localhost>
Message-ID: <CAK7LNARFkU42_FwUMjCUOU0kTZn2gvU4b=8LPhGXOUv6pQP-kg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Olof,

2017-05-26 8:59 GMT+09:00 Olof Johansson <olof@lixom.net>:
> On Mon, May 22, 2017 at 11:03:49AM +0900, Masahiro Yamada wrote:
>> Hi Arnd, Olof,
>>
>> Last week, I thought I found a problem in my pull request,
>> but it turned out my misunderstanding.
>>
>> So, my pull request I sent is OK.
>> I am re-sending this request mail for clarification.
>>
>> Here are some ARM UniPhier SoC fixes for v4.12.
>> Due to the eMMC driver update, PHY parameters must be specified
>> via DT to make the eMMC controller work again.
>
> That's not good, that's a regression in behavior. The driver should
> have a fallback when the properties are not present to avoid regressions
> like these.

Right.  The care for old DT is missing from the driver change.
Theoretically, it is a regression if Linux 4.12 kernel image is used with
DT from Linux 4.11 tree.

However, all our customer products are based on Linux 4.4 (or older)
so I am sure there is no practical problem.
Because the eMMC driver was not upstreamed at that time,
products kernels are locally patched as needed.

I am upstreaming patches to create a better code base for future products, but
Linux 4.11 and 4.12 are not LTS, so never used at least on socionext products.


> Please work with the driver maintainer to either get them to revert
> their change that regresses you, or promptly fix it appropriately with
> fallback values.

You are right, but this is a different issue.


If you are unhappy with pulling this as a fix
(because it is not DT but the driver that should be fixed),
I can include the DT changes in usual PRs for v4.13-rc1.


As I said above, I admit this is not fatal for us
because socionext kernel developers are co-located
and know the upstream status.



> Also, the driver changes were commited back in March, with plenty of time
> to land DT changes well before the merge window. Waiting until the merge
> window is closed is not appropriate -- this should have come in earlier.

You are right.
But, v4.11-rc4 had already passed and I had already sent the pull request
before the driver change was merged.

I generally try to send my PRs around -rc4
because "sorry, this is too late" is scary.
I should have sent the second pull request.
If you do not mind some after -rc4, I will do late PRs next time.


So, what should I do about this?

If you do not want to pull this, I will move the patches
to for-v4.13 branch, which will be sent around -rc4.

-- 
Best Regards
Masahiro Yamada
