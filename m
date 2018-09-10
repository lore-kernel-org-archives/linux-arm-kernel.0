From: maxime.ripard@bootlin.com (Maxime Ripard)
Date: Mon, 10 Sep 2018 16:18:23 +0200
Subject: [PATCH 03/10] phy: Add MIPI D-PHY configuration options
In-Reply-To: <4247225.jW0mJSbZmP@avalon>
References: <cover.ee6158898d563fcc01d45c9652501180bccff0f0.1536138624.git-series.maxime.ripard@bootlin.com>
 <11216244.YyI1EIWKhC@avalon> <20180907085623.ltzybsftrw3zmmev@flea>
 <4247225.jW0mJSbZmP@avalon>
Message-ID: <20180910141823.q43yylpkcq5cls4r@flea>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Sep 07, 2018 at 05:50:52PM +0300, Laurent Pinchart wrote:
> On Friday, 7 September 2018 11:56:23 EEST Maxime Ripard wrote:
> > On Wed, Sep 05, 2018 at 04:43:57PM +0300, Laurent Pinchart wrote:
> > >> The current set of parameters should cover all the potential users.
> > >> 
> > >> Signed-off-by: Maxime Ripard <maxime.ripard@bootlin.com>
> > >> ---
> > >> 
> > >>  include/linux/phy/phy-mipi-dphy.h | 241 ++++++++++++++++++++++++++++++-
> > >>  include/linux/phy/phy.h           |   6 +-
> > >>  2 files changed, 247 insertions(+)
> > >>  create mode 100644 include/linux/phy/phy-mipi-dphy.h
> > >> 
> > >> diff --git a/include/linux/phy/phy-mipi-dphy.h
> > >> b/include/linux/phy/phy-mipi-dphy.h new file mode 100644
> > >> index 000000000000..792724145290
> > >> --- /dev/null
> > >> +++ b/include/linux/phy/phy-mipi-dphy.h
> > >> @@ -0,0 +1,241 @@
> > >> +/* SPDX-License-Identifier: GPL-2.0 */
> > >> +/*
> > >> + * Copyright (C) 2018 Cadence Design Systems Inc.
> > >> + */
> > >> +
> > >> +#ifndef __PHY_MIPI_DPHY_H_
> > >> +#define __PHY_MIPI_DPHY_H_
> > >> +
> > >> +#include <video/videomode.h>
> > >> +
> > >> +/**
> > >> + * struct phy_configure_opts_mipi_dphy - MIPI D-PHY configuration set
> > >> + *
> > >> + * This structure is used to represent the configuration state of a
> > >> + * MIPI D-PHY phy.
> > > 
> > > Shouldn't we split the RX and TX parameters in two structures ?
> > 
> > Are they different? As far as I understood it, both were having the
> > same parameters.
> 
> clk_miss, for instance, is a receiver parameter, while clk_post is a 
> transmitter parameter. There are relationships between the transmitter and 
> receiver parameters in the sense that they have to be compatible, and we may 
> want to compute one set of parameters based on the other one, but I think they 
> target RX and TX separately.

That would require however to have to fill a structure in the consumer
whose sole purpose would be to validate things in the phy
framework. That looks quite weird from an API point-of-view.

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
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20180910/1d2f06eb/attachment.sig>
