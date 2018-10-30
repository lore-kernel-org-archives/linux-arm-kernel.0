From: gregkh@linuxfoundation.org (Greg Kroah-Hartman)
Date: Tue, 30 Oct 2018 20:00:51 +0100
Subject: [PATCH] soc: ti: QMSS: Fix usage of irq_set_affinity_hint
In-Reply-To: <ea4e3273-39da-d9f9-49ce-f18268767ce3@oracle.com>
References: <20181030111103.12110-1-marc.zyngier@arm.com>
 <ea4e3273-39da-d9f9-49ce-f18268767ce3@oracle.com>
Message-ID: <20181030190051.GA1697@kroah.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Oct 30, 2018 at 10:18:08AM -0700, Santosh Shilimkar wrote:
> Hi Greg,
> 
> On 10/30/2018 4:11 AM, Marc Zyngier wrote:
> > The Keystone QMSS driver is pretty damaged, in the sense that it
> > does things like this:
> > 
> > 	irq_set_affinity_hint(irq, to_cpumask(&cpu_map));
> > 
> > where cpu_map is a local variable. As we leave the function, this
> > will point to nowhere-land, and things will end-up badly.
> > 
> > Instead, let's use a proper cpumask that gets allocated, giving
> > the driver a chance to actually work with things like irqbalance
> > as well as have a hypothetical 64bit future.
> > 
> > Signed-off-by: Marc Zyngier <marc.zyngier@arm.com>
> > ---
> > I found this one by inspection after finding a similar bug in an
> > unrelated driver. It is only compile-tested. It would probably
> > a Cc stable, but that's Santosh's decision.
> 
> Would be able to apply this fix from Marc for stable or it needs
> to be re-posted with CC to stable ?

<formletter>

This is not the correct way to submit patches for inclusion in the
stable kernel tree.  Please read:
    https://www.kernel.org/doc/html/latest/process/stable-kernel-rules.html
for how to do this properly.

</formletter>
