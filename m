From: jhbird.choi@samsung.com (Jonghwan Choi)
Date: Fri, 16 May 2014 18:57:38 +0900
Subject: [PATCH v2] cpufreq: exynos:  Fix the compile error
In-Reply-To: <5375D150.1020109@gmail.com>
References: <000001cf70dc$9ccfe4e0$d66faea0$@samsung.com>
 <5375D150.1020109@gmail.com>
Message-ID: <000001cf70ed$451bbec0$cf533c40$@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 16.05.2014 5:50 PM, Tomasz Figa wrote:

> We have been discussing Exynos cpufreq framework rework, including DT support since quite a long time.
> so if you want to know details, please look at respective discussion threads. I don't have time to
> find them for you right now, but if you look for threads of cpufreq patches by Thomas Abraham and ones
> about Exynos multiplatform support, then you should have quite complete set of information.
> 
I will check that.

> In general, I can see three ways to "fix" this for 3.15:
> 
> 1) revert moving soc_is_* macros to mach-exynos/common.h,
> 
> 2) move soc_is_* macros to a header in mach-exynos/include/mach/,
> 
> 3) use of_machine_is_compatible() or of_match_node() on root node in this driver to match directly
> with SoC compatible strings.
> 
> Probably option 3) would be preferred, as it would remove some of the dependencies of this driver on
> arch code and including plat/cpu.h (or mach/cpu.h as would be introduced by 2)) would be no longer
> necessary.

Thanks~

Best Regards.
