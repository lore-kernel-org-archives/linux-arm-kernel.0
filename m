From: daniel@caiaq.de (Daniel Mack)
Date: Wed, 9 Dec 2009 21:57:09 +0800
Subject: [PATCH] mx31moboard: fix typo
In-Reply-To: <4B1F9BC2.6010205@epfl.ch>
References: <20091203193034.GD22533@pengutronix.de>
	<20091203193321.GE22533@pengutronix.de>
	<Pine.LNX.4.64.0912041013380.3981@axis700.grange>
	<4B19473D.7010801@epfl.ch>
	<20091204174623.GW14091@buzzloop.caiaq.de>
	<4B1F9BC2.6010205@epfl.ch>
Message-ID: <20091209135709.GG28375@buzzloop.caiaq.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Dec 09, 2009 at 01:44:50PM +0100, Valentin Longchamp wrote:
> Daniel Mack wrote:
> >Could you double check whether the clock is running? The only thing I can
> >think of is differences in the bootloaders. I still have the proprietary
> >'losh' running here, which I have no sources for.
> >
> 
> The clock is running (well, at least the parent ipg_clk and the
> gating is configured for the clock running, thanks to
> clk_enable(&iim_clk);
> 
> About the bootloader, on our boards we have redboot, adapted from
> the release Freescale did for the ADS. So it may be a bootloader
> issue. What could be missing in my bootloader that makes this read
> fail ?
> 
> I would say that maybe someting the EMI or SPBA configuration is
> missing so that I can access the addresses in this range. Any ideas
> ?

I don't, sorry. I was hoping anyone else has more documentation - at
least the reference manual makes me believe there is more that just that
2 pages.

In worst case we need to revert that patch, but I would like to avoid
that.

Daniel
