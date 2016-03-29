From: will.deacon@arm.com (Will Deacon)
Date: Tue, 29 Mar 2016 13:30:22 +0100
Subject: [PATCH 4/4] drivers/bus: make arm-ccn.c driver explicitly
 non-modular
In-Reply-To: <1459252386.5053.18.camel@arm.com>
References: <1459113058-14340-1-git-send-email-paul.gortmaker@windriver.com>
 <1459113058-14340-5-git-send-email-paul.gortmaker@windriver.com>
 <20160329114525.GC6745@arm.com> <1459252386.5053.18.camel@arm.com>
Message-ID: <20160329123021.GD6745@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Mar 29, 2016 at 12:53:06PM +0100, Pawel Moll wrote:
> Dnia 2016-03-29, Tue o godzinie 12:45 +0100, Will Deacon pisze:
> > I'd much rather fix the driver to build as a module, if at all
> > possible.
> > Suzuki (CC'd) is taking a look at that, so please drop this patch for
> > now.
> 
> There's no problem with building arm-ccn.c as a module - all it's
> really doing today is providing a PMU driver. I don't even know why
> have I made it bool-only in the first place...

Probably because it doesn't compile due to the irq_set_affinity call.

Will
