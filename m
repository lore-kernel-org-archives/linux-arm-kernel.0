From: sudeep.holla@arm.com (Sudeep Holla)
Date: Tue, 24 Feb 2015 18:23:11 +0000
Subject: [PATCH 1/2] ARM: kernel: add support for cpu cache information
In-Reply-To: <20150223193621.GP8656@n2100.arm.linux.org.uk>
References: <1424716091-22914-1-git-send-email-sudeep.holla@arm.com>
 <20150223193621.GP8656@n2100.arm.linux.org.uk>
Message-ID: <54ECC18F.2080409@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



On 23/02/15 19:36, Russell King - ARM Linux wrote:
> On Mon, Feb 23, 2015 at 06:28:10PM +0000, Sudeep Holla wrote:
>> This patch adds support for cacheinfo on ARM platforms.
>
> These patches should carry with them the justification for exporting
> this information to userspace.
>
> "Because we can" is not a good reason; once exported, this
> information becomes a userspace API that we have to maintain, and
> thus it comes with a non-zero support cost going forward.
>

Agreed. So far I have got requests from GCC, JIT and graphics guys.
IIUC they need this to support cache flushing for user applications like
gcc trampolines and JIT compilers. I am also told that having knowledge
of cache architecture can help optimal code strategies, though I don't
have much details on that.

Though it's not a arguable reason, this feature is already supported on
x86 and other architecture and they are users interested in getting this
info on ARM/ARM64 systems too(especially in heterogeneous systems like
big-little, multi-cluster systems and even NUMA systems)

Regards,
Sudeep
