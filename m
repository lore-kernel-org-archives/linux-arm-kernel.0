From: richard.weinberger@gmail.com (Richard Weinberger)
Date: Thu, 18 Aug 2016 14:17:28 +0200
Subject: [PATCH] arm64: Expose TASK_SIZE to userspace via auxv
In-Reply-To: <CED1E802-65C5-48B9-8165-46684BE81164@codeaurora.org>
References: <20160816183231.21179-1-cov@codeaurora.org>
 <20160817103006.GB20762@e104818-lin.cambridge.arm.com>
 <CED1E802-65C5-48B9-8165-46684BE81164@codeaurora.org>
Message-ID: <CAFLxGvx2YB9D1rECjDrALYWoEtGk=4WL9SKXEGgpxH1c_4Sfxg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Aug 17, 2016 at 1:12 PM, Christopher Covington
<cov@codeaurora.org> wrote:
>
>
> On August 17, 2016 6:30:06 AM EDT, Catalin Marinas <catalin.marinas@arm.com> wrote:
>>On Tue, Aug 16, 2016 at 02:32:29PM -0400, Christopher Covington wrote:
>>> Some userspace applications need to know the maximum virtual address
>>they can
>>> use (TASK_SIZE).
>>
>>Just curious, what are the cases needing TASK_SIZE in user space?
>
> Checkpoint/Restore In Userspace and the Mozilla Javascript Engine https://bugzilla.mozilla.org/show_bug.cgi?id=1143022 are the specific cases I've run into. I've heard LuaJIT might have a similar situation. In general I think making allocations from the top down is a shortcut for finding a large unused region of memory.

I think this makes sense for all archs.
At lest UserModeLinux on x86 also needs to know bottom and top
addresses of the usable
address space.
Currently it figures by scanning and catching SIGSEGV.

-- 
Thanks,
//richard
