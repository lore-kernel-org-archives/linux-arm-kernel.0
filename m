From: julia.lawall@lip6.fr (Julia Lawall)
Date: Sat, 10 Oct 2015 23:10:06 +0200 (CEST)
Subject: [PATCH 5/5] arm: add missing of_node_put
In-Reply-To: <8655275.vMqHQfLN9g@wuerfel>
References: <1444480254-14399-1-git-send-email-Julia.Lawall@lip6.fr>
 <1444480254-14399-6-git-send-email-Julia.Lawall@lip6.fr>
 <8655275.vMqHQfLN9g@wuerfel>
Message-ID: <alpine.DEB.2.02.1510102307570.2053@localhost6.localdomain6>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, 10 Oct 2015, Arnd Bergmann wrote:

> On Saturday 10 October 2015 14:30:54 Julia Lawall wrote:
> > diff --git a/arch/arm/kernel/devtree.c b/arch/arm/kernel/devtree.c
> > index 11c54de..432ff34 100644
> > --- a/arch/arm/kernel/devtree.c
> > +++ b/arch/arm/kernel/devtree.c
> > @@ -143,6 +143,7 @@ void __init arm_dt_init_cpu_maps(void)
> >                                                "max cores %u, capping them\n",
> >                                                cpuidx, nr_cpu_ids)) {
> >                         cpuidx = nr_cpu_ids;
> > +                       of_node_put(cpu);
> >                         break;
> >                 }
> > 
> 
> The same for_each_child_of_node() loop has three 'return' statements'
> aside from the 'break' statement here. I think you should change your
> semantic patch to cover both cases.

It was intended to, but it seems that it's not working on the case where 
there is no argument to return.

In any case, it's an opportunity to ask a question.  Would one want a 
of_node_put in front of every return, or should the returns become gotos, 
to a single of_node_put after the current end of the function?

julia
