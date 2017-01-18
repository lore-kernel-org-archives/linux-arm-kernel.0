From: arnd@arndb.de (Arnd Bergmann)
Date: Wed, 18 Jan 2017 13:34:30 +0100
Subject: [PATCH 0/2] ARM: DTS: Fix broken GICv2 register maps
In-Reply-To: <1484736811-24002-1-git-send-email-marc.zyngier@arm.com>
References: <1484736811-24002-1-git-send-email-marc.zyngier@arm.com>
Message-ID: <2966702.djJyWhCMlK@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wednesday, January 18, 2017 10:53:29 AM CET Marc Zyngier wrote:
> For a GICv2 (which happens to be virtualization capable), the
> architecture mandates the following regions:
> 
> 	     GICD: 4kB
> 	     GICC: 8kB
> 	     GICH: 8kB
> 	     GICV: 8kB
> 
> Unfortunately, I made a mistake in one of the examples contained in
> the DT binding document, and everyone duplicated that same mistake all
> over the map.
> 
> This small series fixes the DT binding, and hopefully updates all the
> offending DTs to be compliant with the architecture.
> 

Looks good to me, can you send this as a pull request to arm at kernel.org
once you have collected a reasonable number of Acks?

Acked-by: Arnd Bergmann <arnd@arndb.de>
