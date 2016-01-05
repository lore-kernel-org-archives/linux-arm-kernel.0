From: jolsa@redhat.com (Jiri Olsa)
Date: Tue, 5 Jan 2016 11:07:08 +0100
Subject: [RFC PATCH v2] perf test: Improve bp_signal
In-Reply-To: <1451987875-15893-1-git-send-email-wangnan0@huawei.com>
References: <20160104165535.GI1616@arm.com>
 <1451987875-15893-1-git-send-email-wangnan0@huawei.com>
Message-ID: <20160105100708.GA29394@krava.brq.redhat.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jan 05, 2016 at 09:57:55AM +0000, Wang Nan wrote:
> Will Deacon [1] has some question on patch [2]. This patch improves
> test__bp_signal so we can test:
> 
>  1. A watchpoint and a breakpoint that fire on the same instruction
>  2. Nested signals
> 
> Test result:
> 
>  On x86_64 and ARM64 (result are similar with patch [2] on ARM64):
> 
>  # ./perf test -v signal
>  17: Test breakpoint overflow signal handler                  :
>  --- start ---
>  test child forked, pid 10213
>  count1 1, count2 3, count3 2, overflow 3, overflows_2 3
>  test child finished with 0
>  ---- end ----
>  Test breakpoint overflow signal handler: Ok
> 
> So at least 2 cases Will doubted are handled correctly.
> 
> [1] http://lkml.kernel.org/g/20160104165535.GI1616 at arm.com
> [2] http://lkml.kernel.org/g/1450921362-198371-1-git-send-email-wangnan0 at huawei.com
> 
> Signed-off-by: Wang Nan <wangnan0@huawei.com>
> Signed-off-by: Jiri Olsa <jolsa@kernel.org>
> Cc: Will Deacon <will.deacon@arm.com>
> Cc: Arnaldo Carvalho de Melo <acme@redhat.com>
> ---
> 
> v1 -> v2: Improve readability, fix typo. Thanks to Jiri Olsa.
> 
> To Jiri: I guess you will be okay to provide your SOB for your code at [3],
>          so I add it in this v2 patch.

sure, patch looks good to me

thanks,
jirka
