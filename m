From: nm@ti.com (Nishanth Menon)
Date: Wed, 29 Oct 2014 16:45:41 -0500
Subject: [PATCH] ARM: OMAP2+: Warn about deprecated legacy booting mode
In-Reply-To: <20141029193915.GB2542@atomide.com>
References: <20141027200008.GR2560@atomide.com>
 <20141027230138.GB7805@drone.musicnaut.iki.fi>
 <20141028221243.GU2542@atomide.com> <5450EEE7.8070801@ti.com>
 <20141029185957.GA3723@earth.universe>
 <20141029193915.GB2542@atomide.com>
Message-ID: <20141029214541.GA21790@kahuna>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 12:39-20141029, Tony Lindgren wrote:
> * Sebastian Reichel <sre@ring0.de> [141029 12:01]:
> > Hi,
> > 
> > On Wed, Oct 29, 2014 at 08:43:03AM -0500, Nishanth Menon wrote:
> > > On 10/28/2014 05:12 PM, Tony Lindgren wrote:
> > > > * Aaro Koskinen <aaro.koskinen@iki.fi> [141027 16:03]:
> > > >> Hi,
> > > >>
> > > >> On Mon, Oct 27, 2014 at 01:00:09PM -0700, Tony Lindgren wrote:
> > > >>> +
> > > >>> +	if (!of_have_populated_dt())
> > > >>> +		pr_warn("WARNING: legacy booting deprecated, please update to boot with .dts\n");
> > > >>> +
> > > >>
> > > >> Maybe use WARN so that the warning is more verbose and kernel gets tainted?
> > > > 
> > > > Well I was hoping to avoid annoying people with the trace.
> > > > But can do that if people prefer that, what do others think?
> > > > 
> > > 
> > > WARN is better and eye catchy. Also, could we add information on when
> > > the support will be removed since we call it deprecated?
> 
> Well quoting the hostage situation from a Mr. Show episode
> "Now Who Wants Ice Cream?" the answer to that would be:
> 
> OK, you want me to guess? A hundred million days, or maybe ten more
> minutes, somewhere in there, I just can't say, don't know.

How about ~1 year? We have been talking about dt only boot for over an
year already... Can we say 3.22 kernel, platforms that are not converted
to device tree only loose legacy boot support. 

-- 
Regards,
Nishanth Menon
