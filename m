From: l.stach@pengutronix.de (Lucas Stach)
Date: Wed, 27 Nov 2013 12:06:43 +0100
Subject: [PATCH 3/3] ARM: tegra: set SM2 voltage correct
In-Reply-To: <6311b14be5af09d82e6781160e2aac3a@agner.ch>
References: <cover.1385508112.git.stefan@agner.ch>
 <c9ceead9e3df77b5a33ad654db23c241cd624096.1385508112.git.stefan@agner.ch>
 <1385546387.4270.11.camel@weser.hi.pengutronix.de>
 <6311b14be5af09d82e6781160e2aac3a@agner.ch>
Message-ID: <1385550403.4044.3.camel@weser.hi.pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Am Mittwoch, den 27.11.2013, 12:05 +0100 schrieb Stefan Agner:
> Hi Lucas,
> 
> Am 2013-11-27 10:59, schrieb Lucas Stach:
> > This isn't a global Tegra change, but very specific to the Colibri, so
> > please reword your commit headline to reflect that.
> Agree, will do that.
> 
> > Also there are other issues with the regulator setup on Colibri, I sent
> > a patch for this a good while ago, but didn't come around to revise it
> > until now. So if you are going to touch things here, please look up that
> > patch and fold it into this one.
> I guess you refer to this patchset:
> http://thread.gmane.org/gmane.linux.ports.tegra/11984
> 
> Ok, I will fold patch 4 into my patchset. Not sure whether I should add
> patch 3 (ULPI phy on Colibri T20) as well, since this one is somewhat
> unrelated...
> 
The ULPI patch is already upstream.

At least the first hunk of patch 4 should be folded into your patch, as
it's a real regulator bugfix like your correction of the sm2 voltage.

Lowering sm0 and sm1 voltages is somewhat an optimization and may be
done as a separate patch.

Regards,
Lucas
-- 
Pengutronix e.K.                           | Lucas Stach                 |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
Peiner Str. 6-8, 31137 Hildesheim, Germany | Phone: +49-5121-206917-5076 |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
