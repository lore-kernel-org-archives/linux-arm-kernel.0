From: jgunthorpe@obsidianresearch.com (Jason Gunthorpe)
Date: Thu, 23 May 2013 11:11:12 -0600
Subject: [PATCH 2/2] net: mv643xx_eth: proper initialization for Kirkwood
 SoCs
In-Reply-To: <20130523160111.GP31290@titan.lakedaemon.net>
References: <1369154510-4927-1-git-send-email-sebastian.hesselbarth@gmail.com>
 <1369253042-15082-1-git-send-email-sebastian.hesselbarth@gmail.com>
 <1369253042-15082-2-git-send-email-sebastian.hesselbarth@gmail.com>
 <20130522201607.GA18823@obsidianresearch.com>
 <20130523160111.GP31290@titan.lakedaemon.net>
Message-ID: <20130523171112.GB31281@obsidianresearch.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, May 23, 2013 at 12:01:11PM -0400, Jason Cooper wrote:
> > > +	/* Kirkwood resets some registers on gated clocks. Especially
> > > +	 * CLK125_BYPASS_EN must be cleared but is not available on
> > > +	 * all other SoCs/System Controllers using this driver.
> > > +	 */
> > > +	if (of_machine_is_compatible("marvell,kirkwood"))
> > > +		wrlp(mp, PORT_SERIAL_CONTROL1,
> > > +		     rdlp(mp, PORT_SERIAL_CONTROL1) & ~CLK125_BYPASS_EN);
> > 
> > of_machine_is_compatible seems heavy handed, I would expect this to be
> > based on the compatible string of the ethernet node itself, not the
> > machine??
> 
> Is there a model number variation between IP that needs this and IP that
> doesn't?  If not, I'm fine with of_machine_is_compatible().

Well the name 'mv643xx' is a family of system controller SOC's
from ages ago, it seems reasonble to continue the trend and label the
IP variations with the SOC name:

 compatible = "marvell,kirwood,ethernet", "marvell,mv643xx_eth"

Jason
