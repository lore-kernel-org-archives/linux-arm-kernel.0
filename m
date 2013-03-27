From: robherring2@gmail.com (Rob Herring)
Date: Wed, 27 Mar 2013 11:20:32 -0500
Subject: [PATCH v3] [RFC] arm: use PSCI if available
In-Reply-To: <5152F591.40201@arm.com>
References: <1364388639-11210-1-git-send-email-stefano.stabellini@eu.citrix.com>
 <5152F591.40201@arm.com>
Message-ID: <51531C50.1010106@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 03/27/2013 08:35 AM, Marc Zyngier wrote:
> On 27/03/13 12:50, Stefano Stabellini wrote:
>> Check for the presence of PSCI before setting smp_ops, use PSCI if it is
>> available.
>>
>> This is useful because at least when running on Xen it's possible to have a
>> PSCI node for example on a Versatile Express or an Exynos5 machine. In these
>> cases the PSCI SMP calls should be the ones to be called.
>>
>> Remove virt_smp_ops and platsmp.c from mach-virt because they aren't needed
>> anymore.

[...]

>> +static void __cpuinit psci_secondary_init(unsigned int cpu)
>> +{
>> +	gic_secondary_init(0);
>> +}
> 
> So here we end-up with a dependency between SMP, PSCI, and GIC.
> I really can't see that being a good idea, even I like the general
> direction of this series.
> 

The GIC dependency should be removed with Catalin's series to use
notifiers for GIC cpu interface init.

Rob
