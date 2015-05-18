From: sudeep.holla@arm.com (Sudeep Holla)
Date: Mon, 18 May 2015 14:27:06 +0100
Subject: [PATCH][V3] ARM: pmu: fix memory leak due to early return not
 freeing irqs
In-Reply-To: <1431953873-12283-1-git-send-email-colin.king@canonical.com>
References: <1431953873-12283-1-git-send-email-colin.king@canonical.com>
Message-ID: <5559E8AA.5080609@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



On 18/05/15 13:57, Colin King wrote:
> From: Colin Ian King <colin.king@canonical.com>
>
> Recent commit 338d9dd3e2ae ("ARM: 8351/1: perf: don't warn about
> missing interrupt-affinity property for PPIs") introduced a memory
> leak of irqs on the "Don't bother with PPIs" return path. This issue
> was picked up by static analysis by cppcheck:
>
> [arch/arm/kernel/perf_event_cpu.c:315]: (error) Memory leak: irqs
>
> Instead, perform allocation of irqs after getting the irq hence
> removing need to clean up an allocation on the PPI affine return path.
>
> Fixes: 338d9dd3e2ae ("ARM: 8351/1: perf: don't warn about missing interrupt-affinity property for PPIs")

Will Deacon has similar patch[1] in Russell's patch tracker(8357/1)

Regards,
Sudeep

[1] 
http://lists.infradead.org/pipermail/linux-arm-kernel/2015-May/342367.html
[2] http://www.arm.linux.org.uk/developer/patches/viewpatch.php?id=8357/1
