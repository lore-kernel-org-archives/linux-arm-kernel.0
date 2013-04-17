From: gang.chen@asianux.com (Chen Gang)
Date: Wed, 17 Apr 2013 18:11:36 +0800
Subject: [Suggestion] ARM:S5pv210: compiling issue for s5pv210 by using
 randconfig
In-Reply-To: <20130417100136.GB19492@mudshark.cambridge.arm.com>
References: <514FB202.3040807@asianux.com> <515BFA8D.2000204@asianux.com>
 <20130403101018.GE11040@mudshark.cambridge.arm.com>
 <515C047A.9010906@asianux.com> <516E6A8E.3000001@asianux.com>
 <20130417100136.GB19492@mudshark.cambridge.arm.com>
Message-ID: <516E7558.4080005@asianux.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 2013?04?17? 18:01, Will Deacon wrote:
> The problem here is that you've ended up targetting a platform (s5pv210)
> that selects CPU_V7. VFP is then subsequently selected, but CONFIG_MMU=n, so
> 7TDMI and 9TDMI (v4 CPUs, no VFP) are selectable. Selecting either of those,
> causes these warnings.
> 
> Unfortunately, I'm not sure how best to fix this. Most of the !MMU CPUs are
> tied to a particular board (lots of `if ARCH_INTEGRATOR' predicates), but we
> don't want to do that for 7tdmi.
> 
> If we could enforce the strict exclusion of {<= ARMv5} and {ARMv6+} in the
> Kconfig, that would solve your problem.

  thank you very much for your analysing.

  :-)

-- 
Chen Gang

Asianux Corporation
