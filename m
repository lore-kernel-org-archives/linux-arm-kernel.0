From: sboyd@codeaurora.org (Stephen Boyd)
Date: Tue, 05 Apr 2011 10:36:39 -0700
Subject: [PATCH] ARM: BUG() dies silently
In-Reply-To: <BANLkTimJkQ9afnO=6gKiBqWUo+Uv=hWx2Q@mail.gmail.com>
References: <1301602523-9906-1-git-send-email-omar.ramirez@ti.com>	<BANLkTimtAcPLmcFKoHkCtWcJipy+rSSP+A@mail.gmail.com>	<4D959058.7010606@codeaurora.org>	<BANLkTim8GhUAZ7L-MiJiqi6xM=P_Q8kqfg@mail.gmail.com>	<4D981EAB.8070209@codeaurora.org>
	<BANLkTimJkQ9afnO=6gKiBqWUo+Uv=hWx2Q@mail.gmail.com>
Message-ID: <4D9B5327.1070709@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 4/4/2011 6:55 PM, Simon Glass wrote:
> On Sun, Apr 3, 2011 at 12:15 AM, Stephen Boyd <sboyd@codeaurora.org> wrote:
>> Yes I've seen your patch (and even posted comments on it which have not
>> been responded to).
> Hi Stephen,
>
> Not yet! Don't worry I will get to it. I like the suggestion and am
> pleased that you pointed me to it, thank you.
>

Great!

>> Correct me if I'm wrong, but that patch with CONFIG_BUG=n would lead to
>> the same error that Omar is seeing because the code only modifies the
>> bug infrastructure when CONFIG_BUG=y.
> Well if CONFIG_BUG=n then there is no bug infrastructure, The whole
> file is skipped and it falls back to the asm-generic/bug.h which has
> even more #ifdefs in it. But I think we end up here:
>
> #define BUG() do {} while(0)
>
> After all the patch removes the *(int*)0 = 0 code by virtue of
> CONFIG_GENERIC_BUG=y, right? If I have this wrong then I will have to
> break out the C preprocessor...
>

Ah you're right. Too many ifdefs going on there.

-- 
Sent by an employee of the Qualcomm Innovation Center, Inc.
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum.
