From: rjw@rjwysocki.net (Rafael J. Wysocki)
Date: Mon, 04 Jul 2016 15:17:18 +0200
Subject: [PATCH v7 2/6] ACPI / processor_idle: Add support for Low Power
 Idle(LPI) states
In-Reply-To: <577A5DD3.4050901@arm.com>
References: <1467122152-5604-1-git-send-email-sudeep.holla@arm.com>
 <57766B15.4090407@linaro.org> <577A5DD3.4050901@arm.com>
Message-ID: <6955030.D47pi9uhTn@vostro.rjw.lan>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Monday, July 04, 2016 02:00:03 PM Sudeep Holla wrote:
> 
> On 01/07/16 14:07, Daniel Lezcano wrote:
> > On 06/28/2016 03:55 PM, Sudeep Holla wrote:
> >> ACPI 6.0 introduced an optional object _LPI that provides an alternate
> >> method to describe Low Power Idle states. It defines the local power
> >> states for each node in a hierarchical processor topology. The OSPM can
> >> use _LPI object to select a local power state for each level of processor
> >> hierarchy in the system. They used to produce a composite power state
> >> request that is presented to the platform by the OSPM.
> >>
> >> Since multiple processors affect the idle state for any non-leaf
> >> hierarchy
> >> node, coordination of idle state requests between the processors is
> >> required. ACPI supports two different coordination schemes: Platform
> >> coordinated and  OS initiated.
> >>
> >> This patch adds initial support for Platform coordination scheme of LPI.
> >>
> >> Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>
> >> Signed-off-by: Sudeep Holla <sudeep.holla@arm.com>
> >> ---
> >
> > Hi Sudeep,
> >
> > I looked at the acpi processor idle code sometime ago and from my POV,
> > it was awful, unnecessary complex and very difficult to maintain. The
> > usage of flags all over the places is significant of the lack of control
> > of the written code.
> >
> 
> So you have any specific things in mind ? That's too broad and I know
> it's not so clean, but it's so for legacy reasons. I would leave that
> to Rafael to decide as it takes lots of testing to clean up these code.

The cleanup needs to be done at one point.

Question is when to do it, before adding LPI support or after doing that
(and each option has its pros and cons IMO).

> > Even if you are not responsible of this implementation, the current
> > situation forces you to add more awful code on top of that, which is
> > clearly against "making Linux better".
> >
> 
> OK

So if there are cases in which you need to make the code more complex
because of the legacy stuff in there, I'd say it's better to clean it up
first.

Thanks,
Rafael
