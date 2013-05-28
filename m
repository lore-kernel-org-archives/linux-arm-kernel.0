From: andrew@lunn.ch (Andrew Lunn)
Date: Tue, 28 May 2013 23:51:26 +0200
Subject: Kirkwood CPU Freq driver
In-Reply-To: <51A5234D.9030100@baker-net.org.uk>
References: <51A12DD4.9010907@baker-net.org.uk>
 <20130526083614.GB26249@lunn.ch>
 <20130526180513.GF31290@titan.lakedaemon.net>
 <51A5234D.9030100@baker-net.org.uk>
Message-ID: <20130528215126.GF7678@lunn.ch>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, May 28, 2013 at 10:36:13PM +0100, Adam Baker wrote:
> On 26/05/13 19:05, Jason Cooper wrote:
> >On Sun, May 26, 2013 at 10:36:14AM +0200, Andrew Lunn wrote:
> >>On Sat, May 25, 2013 at 10:32:04PM +0100, Adam Baker wrote:
> >>>I've been trying to test Andrew Lunn's work creating a CPU Idle
> >>>driver for Kirkwood.
> >>
> >>Thanks for testing this. I must admit, i never tested it once the
> >>first rc came out. I clearly should of, because its broken. It was a
> >>three part patch series, and only part 1/3 made it in. Hence the
> >>issues you are seeing.
> >>
> >>Jason, please can you pick up:
> >>
> >>https://patchwork.kernel.org/patch/2051401/
> >>https://patchwork.kernel.org/patch/2080931/
> >
> >Yep, got them in now.  Sorry for the mix up.
> >
> 
> I've now tested with the first of these patches applied and the
> changes from the second added to my .config
> 
> To get it to work I had to follow the instructions in the
> Documentation to add the cpus entry to kirkwood.dtsi so I'll post
> that as a patch in a day or two but after doing that I have a
> working cpufreq driver.

Great that you got it working. Something must of changed in the
generic code, since originally a cpu node was not required.

The clocks are not needed in node, so please don't list them.

> Measuring the power consumption of my NAS server I observed a slight
> reduction in power consumption when the clock rate was reduced. I
> haven't yet measured for long enough to get an accurate measurement
> but it looks like maybe 1/4 W power saving.

I don't have a killawatt meter etc, so i had no idea how much power it
actually saves.  Thanks for the figure.

	 Andrew
