From: steve.capper@linaro.org (Steve Capper)
Date: Thu, 4 Dec 2014 12:27:48 +0000
Subject: [PATCH V2] arm64: optimized copy_to_user and copy_from_user
 assembly code
In-Reply-To: <CAKp6GAseBB-gPNV-o+NhEFifUpuSUx=FdyZisE2F-ZS83mXGXQ@mail.gmail.com>
References: <1407538940-9167-1-git-send-email-fkan@apm.com>
 <20141127114322.GA20659@linaro.org>
 <CALdTtnt_AGmTSYmL37rJbVs8r4fvvhXKzFMW4k8KP2j6N7dvCg@mail.gmail.com>
 <CAKp6GAseBB-gPNV-o+NhEFifUpuSUx=FdyZisE2F-ZS83mXGXQ@mail.gmail.com>
Message-ID: <CAPvkgC2Ofz-hPO=bOFoOdFJPTRuhaZxNE7PCz1YoHqnBqndRcA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 3 December 2014 at 20:01, Craig Magina <craig.magina@canonical.com> wrote:
[...]
>
> Could you provide the steps you used to reproduce this issue? I have
> already submitted an SRU to revert this patch, but would like to have
> the method you used to reproduce it for testing. Thanks for reporting
> this.
>
> --
> Craig Magina

Hi Craig,
It's not easy to reproduce as the problem occurs when the kernel is
copying memory to userspace and experiences a page fault.

I have come across it whilst running "perf record -a" on a system that
is swapping.

Also, building source code under memory pressure (i.e. kernel compile
just after the system has swapped out pages), gave me this problem
too.

Cheers,
--
Steve
