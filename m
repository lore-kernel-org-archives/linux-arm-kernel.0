From: p.zabel@pengutronix.de (Philipp Zabel)
Date: Fri, 21 Oct 2016 17:47:43 +0200
Subject: [PATCH v4 00/23] soc: renesas: Add R-Car RST driver for
 obtaining mode pin state
In-Reply-To: <1477064730.2508.24.camel@pengutronix.de>
References: <1477055857-17936-1-git-send-email-geert+renesas@glider.be>
 <1477064730.2508.24.camel@pengutronix.de>
Message-ID: <1477064863.2508.26.camel@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Am Freitag, den 21.10.2016, 17:45 +0200 schrieb Philipp Zabel:
>      A. Hi Geert,
> 
> Am Freitag, den 21.10.2016, 15:17 +0200 schrieb Geert Uytterhoeven:
> >         Hi Philipp, Mike, Stephen, Simon, Magnus,
> > 	(see questions *** below!)
> > 
> > Currently the R-Car Clock Pulse Generator (CPG) drivers obtains the
> > state of the mode pins either by a call from the platform code, or
> > directly by using a hardcoded register access. This is a bit messy, and
> > creates a dependency between driver and platform code.
> > 
> > This patch series converts the various Renesas R-Car clock drivers
> > and support code from reading the mode pin states using a hardcoded
> > register access to using a new minimalistic R-Car RST driver.
> > 
> > All R-Car clock drivers will rely on the presence in DT of a device node
> > for the RST module.  Backwards compatibility with old DTBs is retained
> > only for R-Car Gen2, which has fallback code using its own private copy
> > of rcar_gen2_read_mode_pins().
> 
> I think you should add a binding doc even though the DT bindings are
> still trivial.

Disregard that, I literally sent this mail and a second later noticed
patch 1 for the first time.

regards
Philipp
