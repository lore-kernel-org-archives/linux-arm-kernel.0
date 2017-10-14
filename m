From: rjw@rjwysocki.net (Rafael J. Wysocki)
Date: Sat, 14 Oct 2017 02:15:34 +0200
Subject: [RESEND PATCH 1/2] spi: rockchip: Convert to late and early
 system PM callbacks
In-Reply-To: <20171013234511.dxazu5wvvz7sjiiu@dtor-ws>
References: <20171013104138.3216-1-jeffy.chen@rock-chips.com>
 <20171013183750.piabs7m3dnpabnkm@sirena.co.uk>
 <20171013234511.dxazu5wvvz7sjiiu@dtor-ws>
Message-ID: <1617641.TtuYKIH8aZ@aspire.rjw.lan>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Saturday, October 14, 2017 1:45:11 AM CEST Dmitry Torokhov wrote:
> On Fri, Oct 13, 2017 at 07:37:50PM +0100, Mark Brown wrote:
> > On Fri, Oct 13, 2017 at 11:30:06AM -0700, Dmitry Torokhov wrote:
> > > On Sat, Oct 14, 2017 at 02:19:28AM +0800, jeffy wrote:
> > 
> > > > > Yeah, it's the same stuff as we get with initcall ordering.  This sort
> > > > > of thing does happen with things like PMICs which tend to have hardware
> > > > > that the system wants to manipulate in the IRQs off part of suspend.
> > > > > Ideally the dependency annotation stuff would figure things out though
> > > > > I'm not sure what the status of that is.
> > 
> > > I'd say non-existent for resources such as regulators, pwms, clocks,
> > > etc. I do not think many places call device_link_add()... I think adding
> > > this to devm_* APIs might be easiest to get the ball going as they
> > > naturally have consumer device and can easily figure out the supplier
> > > side.
> > 
> > Hrm, are things in a state where we're supposed to be doing that?  I've
> > not seen anyone even trying which is a bit odd, I'd thought there was
> > some core work still ongoing (and it wasn't clear to me if we were going
> > to try to do things like use DT/ACPI cross references to figure this
> > stuff out).
> 
> Not sure, adding Rafael...

The infrastructure in the core is there, the part related to getting that
information from firmware is (mostly) missing.

Still, moving system suspend/resume callbacks to the late/early phases may
be a good idea anyway.

Thanks,
Rafael
