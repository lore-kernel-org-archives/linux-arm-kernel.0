From: will.deacon@arm.com (Will Deacon)
Date: Wed, 8 Oct 2014 10:17:41 +0100
Subject: [PATCH] arm: armv7: perf: fix armv7 ref-cycles error
In-Reply-To: <5434AA24.7010600@huawei.com>
References: <5434AA24.7010600@huawei.com>
Message-ID: <20141008091741.GC26140@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Oct 08, 2014 at 04:06:12AM +0100, zhangzhiqiang wrote:
> hi all,
> ----------------------------------------
> 
> ref-cycles event is specially to Intel core, but can still used in arm architecture
> with the wrong return value with 3.10 stable. for instance:
> 
>  perf stat -e ref-cycles sleep 1
> 
>  Performance counter stats for 'sleep 1':
> 
>   	0 ref-cycles
> 
>        1.002381916 seconds time elapsed
> 
> this patch fix the bug and make it return NOT SUPPORTED
> distinctly.
> 
> In upstream this bug has been fixed by other way(not primary for the bug), which changes more than one file
> and more than 1000 lines. the primary commit is 6b7658ec8a100b608e59e3cde353434db51f5be0.
> besides we can not simply cherry-pick.

I thought I saw Greg pick this up the other day?

Will
