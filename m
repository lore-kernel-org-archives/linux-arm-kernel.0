From: rjw@rjwysocki.net (Rafael J. Wysocki)
Date: Fri, 01 Jul 2016 23:04:15 +0200
Subject: [PATCH v6 00/10] acpi,
 clocksource: add GTDT driver and GTDT support in arm_arch_timer
In-Reply-To: <20160701152340.GO12735@arm.com>
References: <1467224153-22873-1-git-send-email-fu.wei@linaro.org>
 <57714bed-3f9c-90c2-ac30-2d462d8a06d4@linaro.org>
 <20160701152340.GO12735@arm.com>
Message-ID: <2183745.J7YpvxXQ47@vostro.rjw.lan>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Friday, July 01, 2016 04:23:40 PM Will Deacon wrote:
> On Thu, Jun 30, 2016 at 09:48:02PM +0800, Hanjun Guo wrote:
> > On 2016/6/30 21:27, Rafael J. Wysocki wrote:
> > >On Thursday, June 30, 2016 10:10:02 AM Hanjun Guo wrote:
> > >>GTDT is part of ACPI spec, drivers/acpi/ is for driver code of
> > >>ACPI spec, I think it can stay in drivers/acpi/ from this point
> > >>of view, am I right?
> > >
> > >The question is not "Can it?", but "Does it need to?".
> > >
> > >It is in the spec, but still there's only one architecture needing it.
> > >
> > >There is no way to test it on any other architecture and no reason to build it
> > >for any other architecture, so why does it need to be located in drivers/acpi/ ?
> > 
> > I'm fine to move it to other places such as arch/arm64/kernel/, but I
> > would like to ask ARM64 maintainer's suggestion for this.
> > 
> > Will, Catalin, what's your opinion on this?
> 
> We don't have any device-tree code for the architected timer under
> arch/arm64, so I don't see why we should need anything for ACPI either.

And I don't see a reason for the GTDT code to be there in drivers/acpi/.

What gives?

Maybe it should go to the same place as the analogus DT code, then?

Thanks,
Rafael
