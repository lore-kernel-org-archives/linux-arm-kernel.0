From: julien.thierry@arm.com (Julien Thierry)
Date: Fri, 25 May 2018 11:17:45 +0100
Subject: [PATCH v4 02/26] arm64: cpufeature: Add cpufeature for IRQ
 priority masking
In-Reply-To: <e44df12f-9868-ae94-4623-ec221d72d783@arm.com>
References: <1527241772-48007-1-git-send-email-julien.thierry@arm.com>
 <1527241772-48007-3-git-send-email-julien.thierry@arm.com>
 <e44df12f-9868-ae94-4623-ec221d72d783@arm.com>
Message-ID: <b0673d7e-9a1e-7dcb-5322-c05fe0821349@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



On 25/05/18 11:04, Suzuki K Poulose wrote:
> On 25/05/18 10:49, Julien Thierry wrote:
>> Add a cpufeature indicating whether a cpu supports masking interrupts
>> by priority.
> 
> How is this different from the SYSREG_GIC_CPUIF cap ? Is it just
> the description ?

More or less.

It is just to have an easier condition in the rest of the series. 
Basically the PRIO masking feature is enabled if we have a GICv3 CPUIF 
working *and* the option was selected at build time. Before this meant 
that I was checking for the GIC_CPUIF cap inside #ifdefs (and putting 
alternatives depending on that inside #ifdefs as well).

Having this as a separate feature feels easier to manage in the code. It 
also makes it clearer at boot time that the kernel will be using irq 
priorities (although I admit it was not the initial intention):

[    0.000000] CPU features: detected: IRQ priority masking


But yes that new feature will be detected only if SYSREG_GIC_CPUIF gets 
detected as well.

Cheers,

-- 
Julien Thierry
