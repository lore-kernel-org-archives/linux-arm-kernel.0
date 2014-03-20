From: mturquette@linaro.org (Mike Turquette)
Date: Thu, 20 Mar 2014 14:23:08 -0700
Subject: [PATCH 0/4] clk: dt: add support for default rate/parent
In-Reply-To: <53172239.3030705@ti.com>
References: <1392282048-6284-1-git-send-email-t-kristo@ti.com>
 <53172239.3030705@ti.com>
Message-ID: <20140320212308.21989.36094@quantum>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Quoting Tero Kristo (2014-03-05 05:10:17)
> Ping.
> 
> Mike, any feedback on this?

Hi Tero,

Have you seen Sylwester's approach[1]? I prefer it since it is more
device-oriented and less "centralized". The clock consumer enumerates
the default parent or rate of a consumed clock. This can be made to work
like your approach by having the clock driver consume these clocks and
set them up with default rates or parents. What do you think?

Regards,
Mike

[1] https://lkml.org/lkml/2014/3/3/324

> 
> -Tero
> 
> On 02/13/2014 11:00 AM, Tero Kristo wrote:
> > Hi,
> >
> > This set is a mix-match of new DT properties for generic and TI specific
> > clock drivers. Basically provided for commenting purposes. The patches
> > provide a way to configure clock parents / rates during boot through DT.
> >
> > "default-rate" : sets rate of a clock during boot, supported for any DT
> >                clock type (through generic clock driver)
> > "ti,default-parent" : selects a default parent for a multiplexer clock,
> >                     only supported for TI specific mux clock for now,
> >                     as generic mux clock does not support DT clocks
> >
> > Patch #4 provided as a reference how to move the default rates / parents
> > from kernel code to DT.
> >
> > Default-rate logic in patch #2 looks somewhat complicated, as the clocks
> > need to be sorted based on their parents to avoid cases where a child clock
> > would set its rate first, just to be overridden by its parent changing
> > rate later and resulting in incorrect rate for the child clock.
> >
> > If the default-rate generic property is not going to fly, it can be moved
> > to TI only drivers also.
> >
> > -Tero
> >
> >
> > _______________________________________________
> > linux-arm-kernel mailing list
> > linux-arm-kernel at lists.infradead.org
> > http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
> >
> 
