From: thomas.petazzoni@bootlin.com (Thomas Petazzoni)
Date: Mon, 30 Apr 2018 15:45:51 +0200
Subject: [PATCH 03/17] arm64: dts: marvell: add syscon compatible to
 CP110 ICU node
In-Reply-To: <20180421135537.24716-4-miquel.raynal@bootlin.com>
References: <20180421135537.24716-1-miquel.raynal@bootlin.com>
 <20180421135537.24716-4-miquel.raynal@bootlin.com>
Message-ID: <20180430154551.616cba0f@windsurf>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello,

On Sat, 21 Apr 2018 15:55:23 +0200, Miquel Raynal wrote:
> Prepare the migration to new bindings where the ICU node has several
> subnodes: one per interrupt group (NSR, SEI, REI, etc). The code for
> each node will share the same set of registers. Turning the ICU node
> into a syscon is a clean solution to handle that.
> 
> Signed-off-by: Miquel Raynal <miquel.raynal@bootlin.com>

In fact, I am wondering if this is really necessary. Can't we instead
just create the regmap() for the ICU MMIO region in the ->probe() of
the parent ICU device ?

Best regards,

Thomas
-- 
Thomas Petazzoni, CTO, Bootlin (formerly Free Electrons)
Embedded Linux and Kernel engineering
https://bootlin.com
