From: gg@slimlogic.co.uk (Graeme Gregory)
Date: Tue, 5 Jul 2016 15:18:58 +0100
Subject: [PATCH v6 00/10] acpi, clocksource: add GTDT driver and GTDT
 support in arm_arch_timer
In-Reply-To: <CAJZ5v0iFcjxQV9YV2KaXGAPRBM8M2xxPm5e2b4uhwYAZZtndPg@mail.gmail.com>
References: <1467224153-22873-1-git-send-email-fu.wei@linaro.org>
 <57714bed-3f9c-90c2-ac30-2d462d8a06d4@linaro.org>
 <20160701152340.GO12735@arm.com>
 <2183745.J7YpvxXQ47@vostro.rjw.lan>
 <CAJZ5v0iFcjxQV9YV2KaXGAPRBM8M2xxPm5e2b4uhwYAZZtndPg@mail.gmail.com>
Message-ID: <20160705141858.GD18338@xora-haswell.xora.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Jul 04, 2016 at 02:53:20PM +0200, Rafael J. Wysocki wrote:
> On Fri, Jul 1, 2016 at 11:04 PM, Rafael J. Wysocki <rjw@rjwysocki.net> wrote:
> > On Friday, July 01, 2016 04:23:40 PM Will Deacon wrote:
> >> On Thu, Jun 30, 2016 at 09:48:02PM +0800, Hanjun Guo wrote:
> >> > On 2016/6/30 21:27, Rafael J. Wysocki wrote:
> >> > >On Thursday, June 30, 2016 10:10:02 AM Hanjun Guo wrote:
> >> > >>GTDT is part of ACPI spec, drivers/acpi/ is for driver code of
> >> > >>ACPI spec, I think it can stay in drivers/acpi/ from this point
> >> > >>of view, am I right?
> >> > >
> >> > >The question is not "Can it?", but "Does it need to?".
> >> > >
> >> > >It is in the spec, but still there's only one architecture needing it.
> >> > >
> >> > >There is no way to test it on any other architecture and no reason to build it
> >> > >for any other architecture, so why does it need to be located in drivers/acpi/ ?
> >> >
> >> > I'm fine to move it to other places such as arch/arm64/kernel/, but I
> >> > would like to ask ARM64 maintainer's suggestion for this.
> >> >
> >> > Will, Catalin, what's your opinion on this?
> >>
> >> We don't have any device-tree code for the architected timer under
> >> arch/arm64, so I don't see why we should need anything for ACPI either.
> >
> > And I don't see a reason for the GTDT code to be there in drivers/acpi/.
> >
> > What gives?
> 
> Well, since there are things like acpi_lpss in there, my position here
> is kind of weak. :-)
> 
> That said I'm not particularly happy with having them in
> drivers/acpi/, so I definitely won't object against attempts to moving
> them somewhere else.
> 
> > Maybe it should go to the same place as the analogus DT code, then?
> 
> I'm mostly concerned about how (and by whom) that code is going to be
> maintained going forward, though.  I also think it should be made
> clear that it is ARM64-only.
> 

So is this a documentation issue in which case Fu Wei can add that to
the file to explain its limited to ARM64. Or we could even rename the
file acpi_arm64_gtdt.c

It seems a pity as the comment on this series were minors to block
things on a filename/location.

Graeme
