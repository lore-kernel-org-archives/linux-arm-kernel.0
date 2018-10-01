From: maxime.ripard@bootlin.com (Maxime Ripard)
Date: Mon, 1 Oct 2018 17:44:17 +0200
Subject: [PATCH] dts: sun8i-h3: add sy8106a to orange pi plus
In-Reply-To: <20180929131617.GA7940@carbon.kippendief.biz>
References: <20180927083636.5415-1-jorik@kippendief.biz>
 <20180928135516.jxhnsgaa3s2nagv7@flea>
 <20180929131617.GA7940@carbon.kippendief.biz>
Message-ID: <20181001154417.joccdlvxoee6pvic@flea>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Jorik,

On Sat, Sep 29, 2018 at 03:16:17PM +0200, Jorik Jonker wrote:
> Hi,
> 
> On Fri, Sep 28, 2018 at 03:55:16PM +0200, Maxime Ripard wrote:
> > The prefix of your commit title should be "ARM: dts: ..."
> 
> Sure, will fix it in v2.
> 
> > > I have tested this on two Orange Pi Plus boards, and they run stable
> > > across a range of voltages (and frequencies).
> > 
> > How was this tested?
> 
> Basically using intermittent cpuburn runs and monitor freq/voltage/temp.
> I've included a description of my test in the v2 commit log.

You just missed the 4.20 merge window, unfortunately, but ideally,
having cpufreq-ljt-stress-test from
https://github.com/ssvb/cpuburn-arm would be great.

That won't prevent your patch from going in, but it would be great if
you could test this at some point during the 4.20-rc phase, and fix
things if they are broken.

> > > +		/*
> > > +		 * The datasheet uses 1.1V as the minimum value of VDD-CPUX,
> > > +		 * however both the Armbian DVFS table and the official one
> > > +		 * have operating points with voltage under 1.1V, and both
> > > +		 * DVFS table are known to work properly at the lowest
> > > +		 * operating point.
> > > +		 *
> > > +		 * Use 1.0V as the minimum voltage instead.
> > > +		 */
> > 
> > There's not much point to that comment, since it's been that way for
> > all the other SoCs from Allwinner. However, that would be great to
> > have it in the commit log.
> 
> Totally agree, but I thought: there must be a good reason this text is in
> the PC dts, so let's put it in the Plus dts as well. I've moved it from the
> patch to the log in the v2 patch, which I will send right away.

Thanks!
Maxime

-- 
Maxime Ripard, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com
