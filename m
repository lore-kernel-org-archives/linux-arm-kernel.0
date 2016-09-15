From: arnd@arndb.de (Arnd Bergmann)
Date: Thu, 15 Sep 2016 09:57:52 +0200
Subject: [GIT PULL] arm64: X-Gene platforms DTS changes queued for 4.9 -
 part1
In-Reply-To: <20160915072709.GA3380@arm.com>
References: <CADaLNDkZdAipxx6cfLJ6yrzTrcLPS_Ciw8+T5EUFVcRRw+fjPw@mail.gmail.com>
 <CADaLNDmMEWEd4o-tf4Kcqy7PP-abBg=Q1-Qdvv5CoDdoLEvi=Q@mail.gmail.com>
 <20160915072709.GA3380@arm.com>
Message-ID: <5104796.MOduSCrlzf@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thursday, September 15, 2016 8:30:30 AM CEST Will Deacon wrote:
> On Wed, Sep 14, 2016 at 06:57:59PM -0700, Duc Dang wrote:
> > On Wed, Sep 14, 2016 at 7:59 AM, Arnd Bergmann <arnd@arndb.de> wrote:
> > > On Friday, September 2, 2016 11:46:31 AM CEST Duc Dang wrote:
> > > Please send this again as two pull requests, one for the dts changes, and
> > > one for the rest (pmu driver, binding and MAINTAINERS file). Please
> > > also include an explanation in the tag description about why this gets
> > > merged through arm-soc. I see that Will suggested doing it that way,
> > > but I don't see what the reason is. We normally don't touch that directory.
> > Hi Arnd,
> > 
> > I am not clear about the reason either. Probably we don't have a
> > dedicated tree for SoC PMU?
> 
> That's right, there isn't a dedicated tree for SoC PMUs. I tend to handle
> the architected PMUs (e.g. the ones in the CPUs), but other PMUs have
> been ad-hoc in the past. That said, Mark and I do tend to review PMU
> drivers, because the internal perf interface is pretty easy to get wrong.
> 
> Arnd -- what would you like to see here? I could collect SoC PMU patches
> together and send you a pull request, or would you like me to take them via
> the arm64 tree? It's worth noting that we have PMU drivers under drivers/bus
> and drivers/hwtracing too, and I *think* arm-soc has handled those in the
> past.

I (and I suspect the same of Olof) don't understand enough about PMU drivers
to be a good gatekeeper for PMU drivers, so I've had to rely on platform
maintainers to know what they are doing when they sent me a driver in
the past. I had not realized  that we already have those drivers in multiple
places, and that seems reason enough to get a maintainer for them who
can review and apply the patches, as well as possibly consolidate them
in once place.

I don't mind forwarding the drivers to Linus in the next/drivers branch
of arm-soc, like we do for drivers/reset which also has its own maintainer
who picks up the patches to forward them to us.

It would certainly help us if you can collect the changes and forward them,
thanks a lot for the offer! Since I know you have a lot on your plate
already, how about finding another co-maintainer who doesn't already
own a subsystem but understands PMUs and could use some on-the-job
training for this?

For v4.9, I'd just take the pull request once Duc resends separate
branches, and then we start a more formal procedure for v4.10 (or
late if there are no PMU patches during that time).

	Arnd
