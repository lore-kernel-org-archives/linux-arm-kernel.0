From: joe@perches.com (Joe Perches)
Date: Wed, 10 Dec 2014 22:12:02 -0800
Subject: [PATCH v5 1/5] phy: add a driver for the Rockchip SoC internal
 USB2.0 PHY
In-Reply-To: <5489338C.1030109@ti.com>
References: <1418208371-18851-1-git-send-email-lyz@rock-chips.com>
 <1418208371-18851-2-git-send-email-lyz@rock-chips.com>
 <5489338C.1030109@ti.com>
Message-ID: <1418278322.18092.30.camel@perches.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, 2014-12-11 at 11:32 +0530, Kishon Vijay Abraham I wrote:
> On Wednesday 10 December 2014 04:16 PM, Yunzhi Li wrote:
> > diff --git a/drivers/phy/phy-rockchip-usb.c b/drivers/phy/phy-rockchip-usb.c
[]
> > +/*
> > + * The higher 16-bit of this register is used for write protection
> > + * only if BIT(13 + 16) set to 1 the BIT(13) can be written.
> > + */
> > +#define SIDDQ_MSK		BIT(13 + 16)

huh?

This #define looks _very_ odd.

Is this supposed to be a single bit 29 or
some range?
