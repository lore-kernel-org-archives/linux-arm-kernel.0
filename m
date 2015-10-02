From: lorenzo.pieralisi@arm.com (Lorenzo Pieralisi)
Date: Fri, 2 Oct 2015 11:52:17 +0100
Subject: [PATCH 1/2] ARM: cpuidle: make cpuidle_ops interfaces ARM64
 compliant
In-Reply-To: <560E5076.7020906@linaro.org>
References: <1443689933-28882-1-git-send-email-lorenzo.pieralisi@arm.com>
 <1443689933-28882-2-git-send-email-lorenzo.pieralisi@arm.com>
 <560E5076.7020906@linaro.org>
Message-ID: <20151002105217.GA1533@red-moon>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Oct 02, 2015 at 10:37:58AM +0100, Daniel Lezcano wrote:

[...]

> > diff --git a/arch/arm/include/asm/cpuidle.h b/arch/arm/include/asm/cpuidle.h
> > index 0f84249..ee36dd4 100644
> > --- a/arch/arm/include/asm/cpuidle.h
> > +++ b/arch/arm/include/asm/cpuidle.h
> > @@ -30,8 +30,8 @@ static inline int arm_cpuidle_simple_enter(struct cpuidle_device *dev,
> >   struct device_node;
> >
> >   struct cpuidle_ops {
> > -	int (*suspend)(int cpu, unsigned long arg);
> > -	int (*init)(struct device_node *, int cpu);
> 
> I don't know the reason why the 'cpu_psci_cpu_init_idle' signature was 
> changed. It has before the same signature as this ops.

Short answer, ACPI (ie device_node is useless on ACPI systems, so
there is no point in passing it).

> As in ARM, we can have more than one driver using the cpuidle_ops 
> infrastructure, removing the struct device_node * parameter will force 
> to add a call to of_get_cpu_node(cpu, NULL) in each driver with a call 
> to of_node_put (btw it is missing below in qcom_cpuidle_init), the 
> rollback labels and this will lead to duplicated code.
> 
> So why not change ARM64 signature instead ?

See above, I will see what I can do and I understand your concern,
it makes sense.

Thanks,
Lorenzo
