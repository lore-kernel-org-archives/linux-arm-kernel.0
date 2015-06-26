From: santosh.shilimkar@oracle.com (santosh shilimkar)
Date: Fri, 26 Jun 2015 11:41:30 -0700
Subject: [PATCH] keystone: psci: adds cpu_die implementation
In-Reply-To: <558D902B.1050603@ti.com>
References: <1435240970-30869-1-git-send-email-vitalya@ti.com>
 <20150625144511.GA6844@leverpostej> <558C174F.80108@oracle.com>
 <558C25E0.3010102@ti.com> <20150625161308.GF6844@leverpostej>
 <558C328C.5070803@ti.com> <20150625165741.GA10564@leverpostej>
 <20150625172057.GA11952@leverpostej> <558C4B84.9030303@oracle.com>
 <558D8492.2090503@ti.com> <558D902B.1050603@ti.com>
Message-ID: <558D9CDA.7080001@oracle.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 6/26/2015 10:47 AM, Grygorii Strashko wrote:
> Hi,
>
> On 06/26/2015 07:57 PM, Vitaly Andrianov wrote:
>> On 06/25/2015 02:42 PM, santosh shilimkar wrote:


> Another question is how well current PSCI implementation supports keystone2/LPAE !?
>
> - It seems, at least below hack should be applied :(
>
> +++ b/arch/arm/kernel/psci_smp.c
> @@ -51,7 +51,7 @@ static int psci_boot_secondary(unsigned int cpu, struct task_struct *idle)
>   {
>          if (psci_ops.cpu_on)
>                  return psci_ops.cpu_on(cpu_logical_map(cpu),
> -                                      __pa(secondary_startup));
> +                                       virt_to_idmap(&secondary_startup));

This is legitimate change should be there irrespectively.
I think you should post this as a proper patch.

Regards,
Santosh
