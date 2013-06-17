From: tomasz.figa@gmail.com (Tomasz Figa)
Date: Mon, 17 Jun 2013 21:02:26 +0200
Subject: [RFC PATCH 03/11] dma: amba-pl08x: Add support for different
 offset of CONFIG register
In-Reply-To: <20130617185223.GO2718@n2100.arm.linux.org.uk>
References: <1371416058-22047-1-git-send-email-tomasz.figa@gmail.com>
 <1371416058-22047-4-git-send-email-tomasz.figa@gmail.com>
 <20130617185223.GO2718@n2100.arm.linux.org.uk>
Message-ID: <2246833.13fcGZL2QP@flatron>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Monday 17 of June 2013 19:52:23 Russell King - ARM Linux wrote:
> On Sun, Jun 16, 2013 at 10:54:10PM +0200, Tomasz Figa wrote:
> > Some variants of PL08x (namely PL080S, found in Samsung S3C64xx SoCs)
> > have CONFIG register at different offset. This patch makes the driver
> > use offset from vendor data struct.
> 
> I'd suggest doing this a different way.  Instead of having to pass
> around two pointers everywhere in order to access this register, add to
> struct pl08x_phy_chan a void __iomem *reg_config; member, and
> initialize that to base + vd->config_offset.  Then use ch->reg_cfg
> instead of ch->base + PL080_CH_CONFIG.
> 
> This has the benefit that you won't have to modify a whole load of
> functions to pass another argument, which costs not only an additional
> register, but also storage to keep it around.

OK. Let me do it this way and see how it turns out. However keep in mind 
that next patch adds further dependencies on access to vendor_data struct, 
so there is nothing sure.

Best regards,
Tomasz
