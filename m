From: thomas.petazzoni@free-electrons.com (Thomas Petazzoni)
Date: Tue, 16 Feb 2016 17:31:55 +0100
Subject: [PATCH 5/5] arm64: marvell: add Device Tree files for Armada 7K/8K
In-Reply-To: <56C19B18.8090005@arm.com>
References: <1455526065-7307-1-git-send-email-thomas.petazzoni@free-electrons.com>
 <1455526065-7307-6-git-send-email-thomas.petazzoni@free-electrons.com>
 <56C19B18.8090005@arm.com>
Message-ID: <20160216173155.4f832646@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Marc,

Thanks for the review!

On Mon, 15 Feb 2016 09:32:08 +0000, Marc Zyngier wrote:

> > +				interrupts = <GIC_PPI 9 (GIC_CPU_MASK_SIMPLE(4) | IRQ_TYPE_LEVEL_HIGH)>;
> > +				reg = <0x210000 0x1000>,
> > +				      <0x220000 0x1000>,
> 
> Assuming we do have a GIC400 here (which is extremely likely), the GICC
> block should be at least 8kB to reflect the fact that this is a GICv2.

According to the datasheet I have, the GICD, GICC, GICV and GICH blocks
are all 0x10000 in size. Not sure the entire 0x10000 is actually used,
but th memory map is pretty clear.

I'll fix that in the next iteration. Thanks for spotting the
potential issue!

Best regards,

Thomas Petazzoni
-- 
Thomas Petazzoni, CTO, Free Electrons
Embedded Linux, Kernel and Android engineering
http://free-electrons.com
