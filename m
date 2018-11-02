From: olof@lixom.net (Olof Johansson)
Date: Fri, 2 Nov 2018 11:22:31 -0700
Subject: [PATCH v2] soc: ti: QMSS: Fix usage of irq_set_affinity_hint
In-Reply-To: <20181031084134.96289-1-marc.zyngier@arm.com>
References: <20181031084134.96289-1-marc.zyngier@arm.com>
Message-ID: <20181102182231.jlyruwut3dtsfhp6@localhost>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Oct 31, 2018 at 08:41:34AM +0000, Marc Zyngier wrote:
> The Keystone QMSS driver is pretty damaged, in the sense that it
> does things like this:
> 
> 	irq_set_affinity_hint(irq, to_cpumask(&cpu_map));
> 
> where cpu_map is a local variable. As we leave the function, this
> will point to nowhere-land, and things will end-up badly.
> 
> Instead, let's use a proper cpumask that gets allocated, giving
> the driver a chance to actually work with things like irqbalance
> as well as have a hypothetical 64bit future.
> 
> Cc: stable at vger.kernel.org
> Acked-by: Santosh Shilimkar <ssantosh@kernel.org>
> Signed-off-by: Marc Zyngier <marc.zyngier@arm.com>
> ---
> * From v1:
>   - Added Santosh's Ack
>   - Cc stable
>   - Directly sent to arm-soc for immediate pick-up
>     (https://lore.kernel.org/lkml/0a20aaf3-65ce-a7ae-8a0e-877313483969 at oracle.com/)

Applied to fixes, thanks. (We could have added the cc too, but thanks for doing
it!)


-Olof
