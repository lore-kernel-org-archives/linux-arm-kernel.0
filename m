From: broonie@sirena.org.uk (Mark Brown)
Date: Wed, 2 Sep 2009 14:45:23 +0100
Subject: Samsung S3C6410 mainline merge coordination
In-Reply-To: <20090902121158.GU32606@prithivi.gnumonks.org>
References: <20090902031719.GK3838@prithivi.gnumonks.org>
	<20090902100500.GA4012@sirena.org.uk>
	<20090902121158.GU32606@prithivi.gnumonks.org>
Message-ID: <20090902134523.GA19113@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Sep 02, 2009 at 09:11:58PM +0900, Harald Welte wrote:
> On Wed, Sep 02, 2009 at 11:05:01AM +0100, Mark Brown wrote:

> > Merge any changes in with the mainline drivers - there's relatively
> > little difference from the s3c24xx IPs.  There's a reasonable chance
> > I'll get round to this myself for the 64xx series since I have one which
> > I'm using for some of my development.

> please note there are something like four different versions of the audio IP
> core in Samsung SoCs.  I myself am not familiar with the detailed technical

Yes, there's at least four IIS blocks I'm aware of - but there's a lot
of shared stuff in the devices I've seen and the programming models
haven't varied radically between them.  A lot of the time it's been more
at the level of slightly incompatible register maps than anything else.
Some of the SoCs have a mix'n'match of IP versions too which makes it
harder to find a clean break to flip over at.

I'm open to other suggestions but I'd need to see some sort of
persuasive argument that the platform support should be forked -
obviously, having two different sets of drivers makes for more
maintinance work which would be unfortunate.

> Apparently there are also features like operating the SoC codec in slave mode
> as well as different clock configurations wich mainline is missing.

Yes, the current drivers aren't entirely complete.  Most of what's
needed is relatively minor, and much of it is largely outside the audio
driver itself like the selection of alternate chip internal clock
sources which is more an issue in the clock API.

> If you (Mark) would want to work on this, pleaes coordinate with Jaswinder so
> there is no duplication of work.  I believe the most current driver source is
> the one in the 2.6.29-samsung branch - but that one already has the s5pc stuff,
> which will have to be removed for mainline right now.

The easiest thing will just be if he monitors alsa-devel; any work will
be visible there.  I don't envisage doing anything massively substantial
myself in the immediate future.

I think the major thing here is to bring the Samsung code up to current
kernel versions and start contributing to mainline as soon as possible -
the problem here is divergent development.  There's other people with an
interest in mainline support for audio on these processors too and the
more rapidly things converge on a single tree the better.
