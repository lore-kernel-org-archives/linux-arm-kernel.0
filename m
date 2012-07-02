From: rnayak@ti.com (Rajendra Nayak)
Date: Mon, 02 Jul 2012 15:52:32 +0530
Subject: [PATCH v2 3/3] ARM: omap: clk: Remove all direct dereferencing
 of struct clk
In-Reply-To: <4FF1705B.6070404@ti.com>
References: <1340786915-29507-1-git-send-email-rnayak@ti.com>
 <1340786915-29507-4-git-send-email-rnayak@ti.com>
 <alpine.DEB.2.00.1206291422050.2338@utopia.booyaka.com>
 <4FF1705B.6070404@ti.com>
Message-ID: <4FF17668.2070306@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

>>
>> In the case of the quoted string warnings, please go ahead and
>> concatenate those strings while you are there. That needs to be done
>> anyway.
>
> Ok, will do. I was able to fix all but one hard to fix CHECK for this
> patch..
>
> ---
> CHECK: Alignment should match open parenthesis
> #608: FILE: arch/arm/mach-omap2/dpll3xxx.c:455:
> + if (__clk_get_rate(dd->clk_bypass) == rate &&
> (clk->dpll_data->modes & (1 << DPLL_LOW_POWER_BYPASS))) {
>
> total: 0 errors, 0 warnings, 1 checks, 608 lines checked
>
> 0003-ARM-omap-clk-Remove-all-direct-dereferencing-of-stru.patch has
> style problems, please review.
>
> If any of these errors are false positives, please report
> ---
>
> I could not find anything wrong with the alignment, but checkpatch
> keeps complaining. It complains for the original code too.
> Might be a checkpatch bug? Or do you really see anything wrong in
> the alignment?

Does seem like a checkpatch issue to me, checkpatch -f on the file
after applying the patch does not throw me the 'CHECK' anymore.
Will ignore this for now and respin my v3 and report this to the
checkpatch folks.
