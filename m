From: horms@verge.net.au (Simon Horman)
Date: Thu, 17 Aug 2017 10:33:37 +0200
Subject: [PATCH  0/3] Add SMP support
In-Reply-To: <KL1PR06MB1702CEF4633BD237ABDB3BDDB8890@KL1PR06MB1702.apcprd06.prod.outlook.com>
References: <1502189793-59679-1-git-send-email-biju.das@bp.renesas.com>
 <20170809083554.GI2705@verge.net.au>
 <KL1PR06MB1702CEF4633BD237ABDB3BDDB8890@KL1PR06MB1702.apcprd06.prod.outlook.com>
Message-ID: <20170817083337.GG26170@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Aug 11, 2017 at 09:37:45AM +0000, Biju Das wrote:
> Hello,
> 
> 
> > -----Original Message-----
> > From: Biju Das
> > Sent: 10 August 2017 12:19
> > To: 'Simon Horman' <horms@verge.net.au>
> > Cc: 'Rob Herring' <robh+dt@kernel.org>; 'Mark Rutland'
> > <mark.rutland@arm.com>; 'Magnus Damm' <magnus.damm@gmail.com>;
> > 'Russell King' <linux@armlinux.org.uk>; Chris Paterson
> > <Chris.Paterson2@renesas.com>; 'devicetree at vger.kernel.org'
> > <devicetree@vger.kernel.org>; 'linux-renesas-soc at vger.kernel.org' <linux-
> > renesas-soc at vger.kernel.org>; 'linux-arm-kernel at lists.infradead.org' <linux-
> > arm-kernel at lists.infradead.org>
> > Subject: RE: [PATCH 0/3] Add SMP support
> >
> >
> >
> > > -----Original Message-----
> > > From: Biju Das
> > > Sent: 10 August 2017 10:17
> > > To: 'Simon Horman' <horms@verge.net.au>
> > > Cc: Rob Herring <robh+dt@kernel.org>; Mark Rutland
> > > <mark.rutland@arm.com>; Magnus Damm <magnus.damm@gmail.com>;
> > Russell
> > > King <linux@armlinux.org.uk>; Chris Paterson
> > > <Chris.Paterson2@renesas.com>; devicetree at vger.kernel.org;
> > > linux-renesas- soc at vger.kernel.org;
> > > linux-arm-kernel at lists.infradead.org
> > > Subject: RE: [PATCH 0/3] Add SMP support
> > >
> > >
> > > > -----Original Message-----
> > > > From: Simon Horman [mailto:horms at verge.net.au]
> > > > Sent: 09 August 2017 09:36
> > > > To: Biju Das <biju.das@bp.renesas.com>
> > > > Cc: Rob Herring <robh+dt@kernel.org>; Mark Rutland
> > > > <mark.rutland@arm.com>; Magnus Damm <magnus.damm@gmail.com>;
> > > Russell
> > > > King <linux@armlinux.org.uk>; Chris Paterson
> > > > <Chris.Paterson2@renesas.com>; devicetree at vger.kernel.org;
> > > > linux-renesas- soc at vger.kernel.org;
> > > > linux-arm-kernel at lists.infradead.org
> > > > Subject: Re: [PATCH 0/3] Add SMP support
> > > >
> > > > On Tue, Aug 08, 2017 at 11:56:30AM +0100, Biju Das wrote:
> > > > > This series aims to add SMP support for r8a7743 SoC.
> > > > >
> > > > > This series has been tested against Linux-next tag 20170727 and
> > > > > renesas-dev branch.
> > > >
> > > > It seems that these patches are targeted at the renesas tree.
> > > > The best practice in that case is to base patches on the latest devel branch.
> > > > Please consider doing so in future.
> > > >
> > > > The patches themselves seem good to me, however, I would like to
> > > > enquire about testing. In particular, have you tested CPU hotplug
> > > > and suspend to RAM with these patches (and without in the case of the
> > latter)?
> > >
> > > I have tested CPU hotplug with this patch and it works ok.
> > >
> > > Currently iWave platform doesn't support STR I guess. But we should
> > > check the changes on other M2 platforms to prove that things don't break.
> 
> I have tested STR on iWave RZ-G1M platform as well. I  used ttySC0 as wake up
> Source(echo enabled > /sys/class/tty/ttySC0/power/wakeup)
> 
> It works fine with and without the patch .
> 
> It is tested against renesas-developer branch tag 20170809-v4.13-rc4.
> 
> > I have tested STR on RZ-G1M SK(r8a7743) platform using gpio-key as wake up
> > source.
> > It works fine with and without the patch . It is tested against renesas-developer
> > branch.
> >
> > Also I have tested STR on R-Car M2 board.it works fine with gpio-key as wake
> > up source.
> >
> > > [>]
> > > > I am cautious about any regressions that may creep in when going
> > > > from UP to SMP.

Thanks for testing, I have applied this series.
