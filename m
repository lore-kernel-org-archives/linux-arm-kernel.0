From: maxime.ripard@bootlin.com (Maxime Ripard)
Date: Fri, 7 Sep 2018 10:56:23 +0200
Subject: [PATCH 03/10] phy: Add MIPI D-PHY configuration options
In-Reply-To: <11216244.YyI1EIWKhC@avalon>
References: <cover.ee6158898d563fcc01d45c9652501180bccff0f0.1536138624.git-series.maxime.ripard@bootlin.com>
 <5b784b096d5507e45c641880af31b07763b4fce2.1536138624.git-series.maxime.ripard@bootlin.com>
 <11216244.YyI1EIWKhC@avalon>
Message-ID: <20180907085623.ltzybsftrw3zmmev@flea>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On Wed, Sep 05, 2018 at 04:43:57PM +0300, Laurent Pinchart wrote:
> > The current set of parameters should cover all the potential users.
> > 
> > Signed-off-by: Maxime Ripard <maxime.ripard@bootlin.com>
> > ---
> >  include/linux/phy/phy-mipi-dphy.h | 241 +++++++++++++++++++++++++++++++-
> >  include/linux/phy/phy.h           |   6 +-
> >  2 files changed, 247 insertions(+)
> >  create mode 100644 include/linux/phy/phy-mipi-dphy.h
> > 
> > diff --git a/include/linux/phy/phy-mipi-dphy.h
> > b/include/linux/phy/phy-mipi-dphy.h new file mode 100644
> > index 000000000000..792724145290
> > --- /dev/null
> > +++ b/include/linux/phy/phy-mipi-dphy.h
> > @@ -0,0 +1,241 @@
> > +/* SPDX-License-Identifier: GPL-2.0 */
> > +/*
> > + * Copyright (C) 2018 Cadence Design Systems Inc.
> > + */
> > +
> > +#ifndef __PHY_MIPI_DPHY_H_
> > +#define __PHY_MIPI_DPHY_H_
> > +
> > +#include <video/videomode.h>
> > +
> > +/**
> > + * struct phy_configure_opts_mipi_dphy - MIPI D-PHY configuration set
> > + *
> > + * This structure is used to represent the configuration state of a
> > + * MIPI D-PHY phy.
> 
> Shouldn't we split the RX and TX parameters in two structures ?

Are they different? As far as I understood it, both were having the
same parameters.



> > +	/**
> > +	 * @modes:
> > +	 *
> > +	 * transmission operation mode flags
> > +	 */
> > +	u32			modes;
> 
> Where are those flags defined ?

goto label;

> > +	/**
> > +	 * @timings:
> > +	 *
> > +	 * Video timings associated with the transmission.
> 
> That's a pretty vague description...

I'll try to improve it then

> > +	 */
> > +	struct videomode	timings;
> > +};
> > +

label:
> > +/* TODO: Add other modes (burst, commands, etc) */
> > +#define MIPI_DPHY_MODE_VIDEO_SYNC_PULSE		BIT(0)

But maybe I should reorganize it to make it more obvious.

Maxime

-- 
Maxime Ripard, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 833 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20180907/89fdad86/attachment.sig>
