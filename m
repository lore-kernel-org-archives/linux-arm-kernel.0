From: mturquette@linaro.org (Mike Turquette)
Date: Mon, 24 Mar 2014 17:38:47 -0700
Subject: [PATCH 0/4] clk: dt: add support for default rate/parent
In-Reply-To: <20140321081217.GD26674@tbergstrom-lnx.Nvidia.com>
References: <1392282048-6284-1-git-send-email-t-kristo@ti.com>
 <53172239.3030705@ti.com> <20140320212308.21989.36094@quantum>
 <20140321081217.GD26674@tbergstrom-lnx.Nvidia.com>
Message-ID: <20140325003847.32624.58084@quantum>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Quoting Peter De Schrijver (2014-03-21 01:12:17)
> On Thu, Mar 20, 2014 at 10:23:08PM +0100, Mike Turquette wrote:
> > Quoting Tero Kristo (2014-03-05 05:10:17)
> > > Ping.
> > > 
> > > Mike, any feedback on this?
> > 
> > Hi Tero,
> > 
> > Have you seen Sylwester's approach[1]? I prefer it since it is more
> > device-oriented and less "centralized". The clock consumer enumerates
> > the default parent or rate of a consumed clock. This can be made to work
> 
> That assumes driver writers are aware of the clock tree topology. IME that's
> seldomly the case.

It assumes no such thing.

The point of Sylwester's patch is that if a driver consumes a clock and
needs to do the very typical setup regarding that clock's rate or
parent, then we now have a sensible way to express that in DT.

One of the strengths of DT is that the C code does not have to know all
of the details about topology or how things are hooked up. We can hide
some of those cute embedded nonsense hacks in DTS and the device
integrator can manage it there.

Regards,
Mike

> 
> Cheers,
> 
> Peter.
