From: ezequiel.garcia@free-electrons.com (Ezequiel Garcia)
Date: Thu, 18 Jul 2013 10:55:06 -0300
Subject: [PATCH] ARM: Kirkwood: Fix the internal register ranges
 translation
In-Reply-To: <51E63B3A.2010807@keymile.com>
References: <1371569479-31498-1-git-send-email-ezequiel.garcia@free-electrons.com>
 <51E5145A.90404@keymile.com> <20130716125531.GD2317@localhost>
 <51E63B3A.2010807@keymile.com>
Message-ID: <20130718135505.GA3264@localhost>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Gerlando,

On Wed, Jul 17, 2013 at 08:35:38AM +0200, Gerlando Falauto wrote:
> On 07/16/2013 02:56 PM, Ezequiel Garcia wrote:
> [...]
> > Also, speaking of "device bus" this nand node should be behind a devicebus node.
> >
> > 		ranges = <MBUS_ID(0xf0, 0x01) 0 0 0xf1000000 0x100000   /* internal-regs */
> > 			  MBUS_ID(0x01, 0x2f) 0 0 0xf4000000 0x400>;
> >
> > 		devbus {
> > 			status = "okay";
> > 			ranges = <0 MBUS_ID(0x01, 0x2f) 0 0x400>;
> >
> > 			/* nand */
> > 			nand {
> > 				compatible = "marvell,orion-nand";
> > 				reg = <0 0x400>;
> > 			};
> > 		};
> >
> > (notice this will allow you to relocate the base address of the NAND windows
> > easily if it conflicts with your PCIe needs).
> 
> I am MAYBE slowly starting to understand this whole mbus rework.
> Just one remark though: don't you think it would make sense to add 
> something like:
> 
> #define MBUS_ID_INTERNAL_REGS	MBUS_ID(0xf0, 0x01)
> #define MBUS_ID_NAND		MBUS_ID(0x01, 0x2f)
> 

Yeah, maybe it would make sense. This has been discussed in the past
and others were against, so that's the reason it's not included in
the series I submitted.

But feel free to send a patch proposing it once the MBus is merged!

Thanks,
-- 
Ezequiel Garc?a, Free Electrons
Embedded Linux, Kernel and Android Engineering
http://free-electrons.com
