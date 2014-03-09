From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Sun, 9 Mar 2014 10:11:44 +0100
Subject: [PATCH 1/7] mfd: AXP20x: Add mfd driver for AXP20x PMIC
In-Reply-To: <20140308113141.GA14009@localhost.fastwebnet.it>
References: <1393692352-10839-1-git-send-email-carlo@caione.org>
 <1393692352-10839-2-git-send-email-carlo@caione.org>
 <20140307180936.GY607@lukather>
 <20140308113141.GA14009@localhost.fastwebnet.it>
Message-ID: <20140309091144.GB3335@lukather>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Carlo,

On Sat, Mar 08, 2014 at 12:31:41PM +0100, Carlo Caione wrote:
> > > +	axp20x->pm_off = of_property_read_bool(node, "axp,system-power-controller");
> > > +
> > > +	if (axp20x->pm_off && !pm_power_off) {
> > > +		axp20x_pm_power_off = axp20x;
> > > +		pm_power_off = axp20x_power_off;
> > > +	}
> > 
> > I don't think we have any other way to actually power down the board.
> > 
> > Is there any reason why we would not need this property?
> 
> In case you have multiple PMIC on the board in this way you con define
> which is the one apt to power off.

Do we even have such a board?

Let's leave this out, we can always add it later if needs be.

-- 
Maxime Ripard, Free Electrons
Embedded Linux, Kernel and Android engineering
http://free-electrons.com
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20140309/1ba2880f/attachment.sig>
