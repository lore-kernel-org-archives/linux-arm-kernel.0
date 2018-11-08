From: bigeasy@linutronix.de (Sebastian Andrzej Siewior)
Date: Thu, 8 Nov 2018 13:00:40 +0100
Subject: arm64 + ARM64_64K_PAGES=y
In-Reply-To: <1ab7ee03-64fe-384a-c88f-f6d519b965db@ti.com>
References: <1ab7ee03-64fe-384a-c88f-f6d519b965db@ti.com>
Message-ID: <20181108120040.pzupzyqnsxeuv5ne@linutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 2018-11-06 15:34:55 [-0600], Grygorii Strashko wrote:
> Hi All,
Hi,

> Do anybody tried to use ARM64 RT with 76K pages enabled?

75 would be an off by one but this :)

> My attempt shows that enabling  CONFIG_ARM64_64K_PAGES=y increases latencies by ~30%
> 
> cyclictest -n -m -Sp98 -q -D2m with CONFIG_ARM64_64K_PAGES=y
> 
> 
> T: 0 (  772) P:98 I:1000 C: 120000 Min:      7 Act:   13 Avg:   10 Max:      85
> T: 1 (  773) P:98 I:1500 C:  79998 Min:      7 Act:   13 Avg:   10 Max:      71
> T: 2 (  774) P:98 I:2000 C:  59997 Min:      7 Act:   11 Avg:   11 Max:      64
> T: 3 (  775) P:98 I:2500 C:  47996 Min:      7 Act:   14 Avg:   12 Max:      66
> 
> 
> cyclictest -n -m -Sp98 -q -D2m with CONFIG_ARM64_64K_PAGES=n
> 
> 
> T: 0 (  697) P:98 I:1000 C: 120000 Min:      7 Act:   10 Avg:    9 Max:      38
> T: 1 (  698) P:98 I:1500 C:  79987 Min:      7 Act:   10 Avg:   10 Max:      32
> T: 2 (  699) P:98 I:2000 C:  59981 Min:      7 Act:   14 Avg:   11 Max:      46
> T: 3 (  700) P:98 I:2500 C:  47977 Min:      6 Act:   11 Avg:   10 Max:      45

So this is an idle system?
The Kconfig help says "faster TLB lookup". Interesting.
Are the 16k pages in between (latency wise) by any chance?

> -- 
> regards,
> -grygorii

Sebastian
