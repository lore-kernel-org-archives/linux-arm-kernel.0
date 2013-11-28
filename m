From: l.stach@pengutronix.de (Lucas Stach)
Date: Thu, 28 Nov 2013 10:49:56 +0100
Subject: [PATCH 3/3] ARM: tegra: set SM2 voltage correct
In-Reply-To: <5296281C.1060403@wwwdotorg.org>
References: <cover.1385508112.git.stefan@agner.ch>
 <c9ceead9e3df77b5a33ad654db23c241cd624096.1385508112.git.stefan@agner.ch>
 <5296281C.1060403@wwwdotorg.org>
Message-ID: <1385632196.5838.4.camel@weser.hi.pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Am Mittwoch, den 27.11.2013, 10:13 -0700 schrieb Stephen Warren:
> On 11/26/2013 04:45 PM, Stefan Agner wrote:
> > Set the requested SM2 voltage to the correct value of 1.8V. The value
> > before used to work on TPS658623 since the driver applied a wrong
> > voltage table too. However, the TPS658643 used on newer devices uses
> > yet another voltage table and those broke that compatibility. The
> > regulator driver now has the correct voltage table for both regulator
> > versions and those the correct voltage can be used in this device
> > tree.
> 
> One thing you haven't called out explicitly here is that this series is
> an incompatible change to the DT, since the old buggy driver used to
> allow old buggy DT content to accidentally work.
> 
The current (wrong and potentially dangerous) DT content only worked on
the engineering sample models. So this change definitely does improve
the situation, even with the risk of breaking a small fraction of
working boards.

> I'm not too familiar with who's using mainline on the Colibri boards.
> Hopefully everyone doing that is using in-kernel DTs, so this
> incompatible change won't be any issue for anyone.
> 
I know of some parties using mainline, but I think everyone so far is
able to use DTs bundled with the kernel.

Regards,
Lucas
-- 
Pengutronix e.K.                           | Lucas Stach                 |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
Peiner Str. 6-8, 31137 Hildesheim, Germany | Phone: +49-5121-206917-5076 |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
