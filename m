From: thomas.petazzoni@free-electrons.com (Thomas Petazzoni)
Date: Tue, 15 May 2012 11:17:57 +0200
Subject: [PATCH 2/8] arm: mach-armada: add source files
In-Reply-To: <20120515091218.GB6820@lunn.ch>
References: <1337072084-21967-1-git-send-email-thomas.petazzoni@free-electrons.com>
 <1337072084-21967-3-git-send-email-thomas.petazzoni@free-electrons.com>
 <20120515091218.GB6820@lunn.ch>
Message-ID: <20120515111757.32847b91@skate>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello Andrew,

Thanks for the quick feedback!

Le Tue, 15 May 2012 11:12:18 +0200,
Andrew Lunn <andrew@lunn.ch> a ?crit :

> > +/include/ "armada.dtsi"
> > +
> > +/ {
> > +	model = "Marvell Armada 370 family SoC";
> > +	compatible = "marvell,armada370", "marvell,armada";
> 
> It should be mrvl, not marvell, in all the compatibility strings.

Ok, we will change that.

> Also, we need to be careful with armada. kirkwood is an armada for
> example. It maybe be better to not actually use armada without
> postfix.

Do you have a recommendation for this? We support both Armada 370 and
Armada XP, so the obvious common prefix for these two platforms is
"armada". Since kirkwood are ARMv5 and those new Armada are ARMv7,
would armadav7 be a better prefix? Then we could have armadav7-370 and
armadav7-xp? Other suggestions?

> This chunk of code comes up multiple times in various orion
> devices. Could it be refactored into plat-orion?

Probably yes. However, the register definitions are different between
the different devices.

Best regards,

Thomas
-- 
Thomas Petazzoni, Free Electrons
Kernel, drivers, real-time and embedded Linux
development, consulting, training and support.
http://free-electrons.com
