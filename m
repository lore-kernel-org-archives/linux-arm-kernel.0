From: will.deacon@arm.com (Will Deacon)
Date: Fri, 26 Sep 2014 10:26:04 +0100
Subject: [PATCH v2 1/3] clocksource: arm_arch_timer: change clocksource
 name if CP15 unavailable
In-Reply-To: <54250FFE.2050605@linaro.org>
References: <1411052390-27238-1-git-send-email-nathan_lynch@mentor.com>
 <1411052390-27238-2-git-send-email-nathan_lynch@mentor.com>
 <54250FFE.2050605@linaro.org>
Message-ID: <20140926092604.GC22293@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Sep 26, 2014 at 08:04:30AM +0100, Daniel Lezcano wrote:
> On 09/18/2014 04:59 PM, Nathan Lynch wrote:
> > The arm and arm64 VDSOs need CP15 access to the architected counter.
> > If this is unavailable (which is allowed by ARM v7), indicate this by
> > changing the clocksource name to "arch_mem_counter" before registering
> > the clocksource.
> >
> > Suggested by Stephen Boyd.
> >
> > Signed-off-by: Nathan Lynch <nathan_lynch@mentor.com>
> > Reviewed-by: Stephen Boyd <sboyd@codeaurora.org>
> 
> Hi Nathan,
> 
> is it possible to have the acked-by of the different maintainers for the 
> other patches ?

FWIW: I acked the series:

  http://lists.infradead.org/pipermail/linux-arm-kernel/2014-September/289143.html

There's ongoing debate about whether or not we should have a vdso, but this
series still makes sense in isolation.

Will
