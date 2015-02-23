From: linux@roeck-us.net (Guenter Roeck)
Date: Mon, 23 Feb 2015 09:43:13 -0800
Subject: [PATCH 2/2] at91sam9_wdt: Allow watchdog to reset device at
 early boot
In-Reply-To: <CAL_JsqLgb36Vek-Pwb8CYAfQ=MBv3QUO5Tf27j701ET2FKo1zQ@mail.gmail.com>
References: <00B1658F-2F3A-4B90-ADCA-275770832180@jcrosoft.com>
 <20150220085151.3b599de8@bbrezillon>
 <E7DD67EB-CA34-48EA-838D-3EBBF74CAEBD@jcrosoft.com>
 <20150220181640.57b21432@bbrezillon>
 <20150220180646.GA26698@roeck-us.net> <54EAD6E5.8090104@offcode.fi>
 <20150223095154.63218331@bbrezillon> <54EAEECA.80803@offcode.fi>
 <20150223161948.GA2165@roeck-us.net>
 <CAL_JsqLgb36Vek-Pwb8CYAfQ=MBv3QUO5Tf27j701ET2FKo1zQ@mail.gmail.com>
Message-ID: <20150223174313.GA22052@roeck-us.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Feb 23, 2015 at 11:10:13AM -0600, Rob Herring wrote:
> On Mon, Feb 23, 2015 at 10:19 AM, Guenter Roeck <linux@roeck-us.net> wrote:
> > On Mon, Feb 23, 2015 at 11:11:38AM +0200, Timo Kokkonen wrote:
> > [ ... ]
> >
> >>
> >> After all, we do have already watchdog_init_timeout function that parses the
> >> watchdog timeout argument from either device tree or from command line. How
> >> about if we expanded that interface? Maybe have a more generic
> >> watchdog_init_parmas() or something that parses the generic watchdog
> >> arguments, either from command line, device tree or ACPI or something. The
> >> device driver could replace call from watchdog_init_timeout() to
> >> watchdog_init_params() once it is ready to support other generic parameters,
> >> such as early-timeout-sec. Then the watchdog driver could do the right thing
> >> about whether watchdog should be left running or stopped and how long time
> >> should be given.
> >>
> > Good idea.
> >
> >> Alternatively, we could also let the watchdog core know a little more about
> >> the actual watchdog hardware, such as whether the HW is stoppable, whether
> >> it needs manual pinging by the kernel until user space has taken over. Or
> 
> Whether the h/w is stoppable or not is certainly a reasonable DT
> property. The maximum h/w timeout would be too (although that may just
> be a property of counter size and clock rate).
> 
> > Yes, all that will be needed. But, still, the stop-gap is that we'll need to
> > get buyin from the DT folks for the necessary properties. I have had the
> > outline for the necessary watchdog core implementation in my mind for a long
> > time, but I just don't have the time (nor the patience, quite frankly)
> > to get DT buyin.
> 
> Defining wdog core functionality and behavior has little to do with DT
> and you don't need buy in. Presumably you care about non-DT platforms
> as well. Moving more of the intelligence to the core would be a good
> thing and for the most part should be independent of DT.
> 

Even so, if we can not express the HW with DT as needed, we would end up
having to work around DT limitations (like using module parameters on top
of DT). I just don't have the time to do that. Maybe someone else does.
As mentioned earlier, I'll be happy to review and as much as possible test
patches.

Guenter
