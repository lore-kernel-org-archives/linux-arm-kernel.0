From: will.deacon@arm.com (Will Deacon)
Date: Mon, 23 Mar 2015 17:38:21 +0000
Subject: [PATCH v5 1/8] arm64: Get rid of struct cpu_table
In-Reply-To: <55104926.1060901@arm.com>
References: <1426690527-14258-1-git-send-email-ard.biesheuvel@linaro.org>
 <1426690527-14258-2-git-send-email-ard.biesheuvel@linaro.org>
 <55104926.1060901@arm.com>
Message-ID: <20150323173821.GD1556@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Mar 23, 2015 at 05:11:02PM +0000, Suzuki K. Poulose wrote:
> On 18/03/15 14:55, Ard Biesheuvel wrote:
> > @@ -209,22 +207,12 @@ static void __init smp_build_mpidr_hash(void)
> >
> >   static void __init setup_processor(void)
> >   {
> > -       struct cpu_info *cpu_info;
> >          u64 features, block;
> >          u32 cwg;
> >          int cls;
> >
> > -       cpu_info = lookup_processor_type(read_cpuid_id());
> > -       if (!cpu_info) {
> > -               printk("CPU configuration botched (ID %08x), unable to continue.\n",
> > -                      read_cpuid_id());
> > -               while (1);
> > -       }
> > -
> > -       cpu_name = cpu_info->cpu_name;
> > -
> > -       printk("CPU: %s [%08x] revision %d\n",
> > -              cpu_name, read_cpuid_id(), read_cpuid_id() & 15);
> > +       printk("CPU: AArch64 Processor [%08x] revision %d\n",
> > +              read_cpuid_id(), read_cpuid_id() & 15);
> >
> 
> While we are at it, does it make sense to change
> 
>   s/CPU/Boot CPU/
> 
> to make it clear on a big.Little system ?

This is already queued, so I don't think it's worth the effort now.

Will
