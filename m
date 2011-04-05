From: sjg@chromium.org (Simon Glass)
Date: Mon, 4 Apr 2011 18:55:31 -0700
Subject: [PATCH] ARM: BUG() dies silently
In-Reply-To: <4D981EAB.8070209@codeaurora.org>
References: <1301602523-9906-1-git-send-email-omar.ramirez@ti.com>
	<BANLkTimtAcPLmcFKoHkCtWcJipy+rSSP+A@mail.gmail.com>
	<4D959058.7010606@codeaurora.org>
	<BANLkTim8GhUAZ7L-MiJiqi6xM=P_Q8kqfg@mail.gmail.com>
	<4D981EAB.8070209@codeaurora.org>
Message-ID: <BANLkTimJkQ9afnO=6gKiBqWUo+Uv=hWx2Q@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, Apr 3, 2011 at 12:15 AM, Stephen Boyd <sboyd@codeaurora.org> wrote:
> (Please stop top posting)
>
> On 4/1/2011 3:29 PM, Simon Glass wrote:
>> Hi Stephen,
>>
>> Sorry for the confusion, but in fact I was talking about the patch to
>> make ARM use the generic bug handling via an undef instruction instead
>> of calling ______bug() or writing to memory address 0. Please see
>> here:
>>
>> http://www.arm.linux.org.uk/developer/patches/viewpatch.php?id=6808/1
>
> Yes I've seen your patch (and even posted comments on it which have not
> been responded to).

Hi Stephen,

Not yet! Don't worry I will get to it. I like the suggestion and am
pleased that you pointed me to it, thank you.

> Correct me if I'm wrong, but that patch with CONFIG_BUG=n would lead to
> the same error that Omar is seeing because the code only modifies the
> bug infrastructure when CONFIG_BUG=y.

Well if CONFIG_BUG=n then there is no bug infrastructure, The whole
file is skipped and it falls back to the asm-generic/bug.h which has
even more #ifdefs in it. But I think we end up here:

#define BUG() do {} while(0)

After all the patch removes the *(int*)0 = 0 code by virtue of
CONFIG_GENERIC_BUG=y, right? If I have this wrong then I will have to
break out the C preprocessor...

Regards,
Simon

>
> --
> Sent by an employee of the Qualcomm Innovation Center, Inc.
> The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum.
>
>
