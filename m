From: nm@ti.com (Menon, Nishanth)
Date: Thu, 7 Oct 2010 17:15:15 -0500
Subject: [PATCH] power: introduce library for device-specific OPPs
In-Reply-To: <87fwwh7isu.fsf@deeprootsystems.com>
References: <1286357180-21565-1-git-send-email-nm@ti.com>
	<201010072354.57011.rjw@sisk.pl>
	<7A436F7769CA33409C6B44B358BFFF0C014F748B07@dlee02.ent.ti.com>
	<87fwwh7isu.fsf@deeprootsystems.com>
Message-ID: <7A436F7769CA33409C6B44B358BFFF0C014F748B1A@dlee02.ent.ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

> -----Original Message-----
> From: Kevin Hilman [mailto:khilman at deeprootsystems.com]
> Sent: Thursday, October 07, 2010 5:14 PM
> To: Menon, Nishanth
> Cc: Rafael J. Wysocki; linux-pm; lkml; l-o; l-a; Paul
> Subject: Re: [PATCH] power: introduce library for device-specific OPPs
> 
[...]
> >> > +static int opp_set_availability(struct device *dev, unsigned long
> freq,
> >> > +		bool availability_req)
> >> > +{
> >> > +	struct device_opp *tmp_dev_opp, *dev_opp = NULL;
> >> > +	struct opp *new_opp, *tmp_opp, *opp = ERR_PTR(-ENODEV);
> >> > +	int r = 0;
> >> > +
> >> > +	/* keep the node allocated */
> >> > +	new_opp = kmalloc(sizeof(struct opp), GFP_KERNEL);
> >> > +	if (!new_opp) {
> >> > +		pr_warning("Unable to allocate opp\n");
> >>
> >> Please add an identification string to the messages, something like
> >> "OPP: Unable to allocat object\n" (and similarly in the other messages).
> >> That would help to find the source of a message in case there's any
> >> problem.
> >
> > pr_fmt has been reformatted for this. The actual message which will
> appear
> > is as follows:
> > opp_set_availability: Unable to allocate opp
> >
> > is'nt that good enough considering that all functions are opp_ prefixed?
> > I can modify pr_fmt to add "OPP:" but I kinda think it is redundant. But
> I
> > have no strong opinions on that and look forward to your recommendations.
> 
> Even more informative would be to use dev_warn() and include the func.
> That way we'll even know which device has the problem.
Ack. Thanks. Yeah, this is better.. will do the change.

Regards,
Nishanth Menon
