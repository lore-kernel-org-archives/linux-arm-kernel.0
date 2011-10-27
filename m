From: linus.walleij@linaro.org (Linus Walleij)
Date: Thu, 27 Oct 2011 20:27:36 +0200
Subject: [PATCH] AMBA: Use suspend_noriq to force devices into runtime
	suspend
In-Reply-To: <20111027155434.GN19187@n2100.arm.linux.org.uk>
References: <1319730524-29483-1-git-send-email-ulf.hansson@stericsson.com>
	<20111027155434.GN19187@n2100.arm.linux.org.uk>
Message-ID: <CAKnu2MpGOKFKpO=2mmu4a74gmbCUdO8Ui5+1nEB6GbfitGBLRw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

2011/10/27 Russell King - ARM Linux <linux@arm.linux.org.uk>:

> On Thu, Oct 27, 2011 at 05:48:44PM +0200, Ulf Hansson wrote:
>> To be able to make sure devices are put into runtime suspend
>> after a suspend sequence, the suspend_noirq callback is used.
>>
>> Previously it was was possible for drivers doing pm_runtime_suspend
>> and pm_runtime_put_sync directly from it's suspend callbacks.
>> This is now not possible due to the following commit, which solve a
>> race issue:
>>
>> PM: Limit race conditions between runtime PM and system sleep (v2)
>
> There's a patch which has been queued for the last 2 months adding
> runtime PM support to the AMBA bus layer which is now merged into
> mainline. ?Please check whether this works for you.

I think this patch is on top of that one. This moves the
runtime_[suspend|resume] so as to put all the runtime PM stuff
inside the same #ifdef block, then adds two new _noirq
functions to address the problems from the named
commit by Rafael.

Yours,
Linus Walleij
