From: thomas.petazzoni@free-electrons.com (Thomas Petazzoni)
Date: Tue, 20 Jun 2017 17:36:51 +0200
Subject: [PATCH v4 6/6] arm64: dts: marvell: enable GICP and ICU on
 Armada 7K/8K
In-Reply-To: <87tw3a3dy4.fsf@free-electrons.com>
References: <20170620140722.31646-1-thomas.petazzoni@free-electrons.com>
 <20170620140722.31646-7-thomas.petazzoni@free-electrons.com>
 <87tw3a3dy4.fsf@free-electrons.com>
Message-ID: <20170620173651.6370ea58@windsurf.lan>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello,

On Tue, 20 Jun 2017 16:56:35 +0200, Gregory CLEMENT wrote:

> > +#include <dt-bindings/interrupt-controller/mvebu-icu.h>  
> 
> With this line you created a dependency with the patch "irqchip:
> irq-mvebu-icu: new driver for Marvell ICU". And without it the dtb is
> not buidable.
> 
> So either I wait for the next kernel release to apply it or I will need
> a stable branch with the commit adding the mvebu-icu.h file.

Alternatively, I could change the patch to use hardcoded values for now
(i.e replace ICU_GRP_NSR everywhere by 0x0), and then change it during
the next kernel cycle to use the #define value. I would really prefer
such a solution to a solution where merging the entire ICU DT change
would be delayed by one cycle.

Let me know what you prefer. Maybe Marc can say if the irqchip
maintainers can provide a stable branch containing the mvebu-icu.h file.

Best regards,

Thomas
-- 
Thomas Petazzoni, CTO, Free Electrons
Embedded Linux and Kernel engineering
http://free-electrons.com
