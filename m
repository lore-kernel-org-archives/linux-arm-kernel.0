From: ben@datarespons.no (=?utf-8?B?QmrDuHJuIEVyaWsgTmlsc2Vu?=)
Date: Wed, 29 Jan 2014 17:17:40 +0100
Subject: imx6 power consumption
In-Reply-To: <1387440914.4131.4.camel@bnilsen-HP>
References: <E1VszO5-00060R-Gp@merlin.infradead.org>
 <20131218024546.GA6691@S2101-09.ap.freescale.net>
 <E1VtF3I-0002MQ-Ra@merlin.infradead.org>
 <20131218113240.GK6691@S2101-09.ap.freescale.net>
 <b43eb01926cf4b1f9413a66cc5791d9b@DM2PR03MB317.namprd03.prod.outlook.com>
 <1387440914.4131.4.camel@bnilsen-HP>
Message-ID: <mailman.24.1391012292.1056.linux-arm-kernel@lists.infradead.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi guys,

On Thu, 2013-12-19 at 09:15 +0100, Bj?rn Erik Nilsen wrote:
> Hi Anson,
> 
> On Thu, 2013-12-19 at 03:28 +0100, Anson.Huang at freescale.com wrote:
> > 
> > Best Regards.
> > Anson huang ???
> >  
> > Freescale Semiconductor Shanghai
> > ?????????192?A?2?
> > 201203
> > Tel:021-28937058
> > 
> > 
> > >-----Original Message-----
> > >From: linux-arm-kernel [mailto:linux-arm-kernel-bounces at lists.infradead.org]
> > >On Behalf Of Shawn Guo
> > >Sent: Wednesday, December 18, 2013 7:33 PM
> > >To: Bj?rn Erik Nilsen
> > >Cc: linux-arm-kernel at lists.infradead.org
> > >Subject: Re: imx6 power consumption
> > >
> > >On Wed, Dec 18, 2013 at 12:12:05PM +0100, Bj?rn Erik Nilsen wrote:
> > >> As far as I can tell, commit e95dddb34c8 "ARM: imx: enable anatop
> > >> suspend/resume" is the common ancestor for mainline and freescale, and
> > >> from there pm-imx6q.c starts to diverge.
> > >>
> > >> I haven not looked at it in great detail yet, but it seems there are
> > >> not too many patches missing in mainline. Any idea why remaining
> > >> patches haven't been upstreamed?
> > >
> > >Probably because no one cares and would spend time to upstream these patches.
> > 
> > This root cause is we did NOT put the DSM code in IRAM and free DDR IO in DSM.
> > We have done this in our internal v3.10 kernel, so I will do the upstream soon,
> > Below is the DSM number of i.MX6Q SabreSD we got on v3.10 release:
> > 
> > VDDARM_IN(R27)             0mA at 0.97V
> > VDDSOC_IN(R21)             4.2 at 0.97V
> > DDR(R25)                   14.8mA at 1.5V
> > VDDHIGH_IN + SNVS(SH17)    0.35mA at 2.98V, 0.9mA
> 
> 
> I successfully managed to cherry-pick a handful of commits from
> freescale 3.10 and got down to approximately half the consumption.
> That's already very good news.
> 
> Looking forward to see these patches upstream. Will you be able upstream
> them before 3.14 you think?


Any updates on this?
