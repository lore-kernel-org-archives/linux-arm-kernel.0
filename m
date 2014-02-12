From: Mohit.KUMAR@st.com (Mohit KUMAR DCG)
Date: Wed, 12 Feb 2014 12:52:02 +0800
Subject: [PATCH V5 4/8] phy: st-miphy-40lp: Add skeleton driver
In-Reply-To: <10315753.nkNxr0yDnp@wuerfel>
References: <cover.1391871170.git.pratyush.anand@st.com>
 <201402101654.22187.arnd@arndb.de>
 <2CC2A0A4A178534D93D5159BF3BCB66189FD2CAA9B@EAPEX1MAIL1.st.com>
 <10315753.nkNxr0yDnp@wuerfel>
Message-ID: <2CC2A0A4A178534D93D5159BF3BCB66189FD2CAD14@EAPEX1MAIL1.st.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello Arnd,

> -----Original Message-----
> From: Arnd Bergmann [mailto:arnd at arndb.de]
> Sent: Tuesday, February 11, 2014 8:09 PM
> To: Mohit KUMAR DCG
> Cc: Pratyush ANAND; Kishon Vijay Abraham I; spear-devel; linux-arm-
> kernel at lists.infradead.org; devicetree at vger.kernel.org; linux-
> kernel at vger.kernel.org; Lee Jones
> Subject: Re: [PATCH V5 4/8] phy: st-miphy-40lp: Add skeleton driver
> 
> On Tuesday 11 February 2014 11:57:46 Mohit KUMAR DCG wrote:
> >
> > > Maybe mention that this phy is used inside the spear13xx SoC here
> > > rather than a standalone phy.
> >
> > - Yes, for spear13xx its used internally. Do you think that it
> > requires to be mentioned here?
> > We have few prototype boards that uses this as external phy.
> 
> [adding Lee since he mentioned working on a similar part]
> 
> I'm a bit confused. Is it actually the same IP block that can be used internally
> as part of a SoC and as a standalone chip?
> 
> Since some of the settings of the PHY are controlled through the misc
> register in case of spear13xx, I assume that part is different on the
> standalone version. How do you actually select the mode in that case?
> 
> It would certainly be helpful to explain this somewhere, and the binding
> might not be the worst place for this.
> 
> On a related note, the driver in its current shape looks a bit silly since it
> doesn't contain any of the miphy specific code but only the SoC specific parts
> (as I suggested you do, so I'm not blaming you :-)) and a multiplexer that
> switches between the two possible implementations.

- yes, thats what we were explaining earlier. If it is integrated into some SoC 
Then there are some soc specific configurations. Actual phy reg settings could
also vary for the different SoCs for the best tuning.

However we agreed to your idea as miphy40lp register definitions would remain
same across the SoCs.

> 
> What is your plan for the future, do you intend to add the actual miphy code
> soon, or is that something you just want to leave as an option for the future
> but have no specific plans to do right now? If not, the driver would probably
> look nicer if it were split into two separate implementations, one for each
> spear13xx SoC and with a separate set of phy_ops but no multiplexer.

Do you want  it to split the code into two different files like phy-miphyspear1310.c
and phy-miphyspear1340.c ?

Regards
Mohit
