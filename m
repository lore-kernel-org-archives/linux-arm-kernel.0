From: takahiro.akashi@linaro.org (AKASHI Takahiro)
Date: Thu, 29 Oct 2015 14:43:56 +0900
Subject: [PATCH] recordmcount: arm64: replace the ignored mcount call into
 nop
In-Reply-To: <20151028115825.GB29512@arm.com>
References: <1446019445-14421-1-git-send-email-huawei.libin@huawei.com>
 <20151028041619.4e44491a@grimm.local.home> <20151028115825.GB29512@arm.com>
Message-ID: <5631B21C.3060504@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 10/28/2015 08:58 PM, Will Deacon wrote:
> On Wed, Oct 28, 2015 at 04:16:19AM -0400, Steven Rostedt wrote:
>> On Wed, 28 Oct 2015 16:04:05 +0800
>> Li Bin <huawei.libin@huawei.com> wrote:
>>
>>> By now, the recordmcount only records the function that in
>>> following sections:
>>> .text/.ref.text/.sched.text/.spinlock.text/.irqentry.text/
>>> .kprobes.text/.text.unlikely
>>>
>>> For the function that not in these sections, the call mcount
>>> will be in place and not be replaced when kernel boot up. And
>>> it will bring performance overhead, such as do_mem_abort (in
>>> .exception.text section). This patch make the call mcount to
>>> nop for this case in recordmcount.

The patch itself is fine (it might be a good idea to describe
what 0x94000000 means though), but
I'm wondering whether we have any reason to exclude .exception.text
from tracing.
In my understandings, this attribute (.exception.text) is utilized
solely for pretty printing in dump_backtrace().

Thanks,
-Takahiro AKASHI

>> I can take this in my tree with an Ack from the ARM64 maintainers.
>
> Looks like it does what it says on the tin:
>
>    Acked-by: Will Deacon <will.deacon@arm.com>
>
> Will
>
