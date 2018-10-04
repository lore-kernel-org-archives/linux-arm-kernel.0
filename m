From: yogeshnarayan.gaur@nxp.com (Yogesh Narayan Gaur)
Date: Thu, 4 Oct 2018 08:47:33 +0000
Subject: [PATCH 1/3] mtd: spi-nor: Add Octal mode support for mt35xu512aba
In-Reply-To: <20181004093925.2961d881@bbrezillon>
References: <20181003165603.2579-1-vigneshr@ti.com>
 <20181003165603.2579-2-vigneshr@ti.com>
 <VI1PR04MB1038C20CA97E453FC4C9CEAE99EA0@VI1PR04MB1038.eurprd04.prod.outlook.com>
 <20181004093925.2961d881@bbrezillon>
Message-ID: <VI1PR04MB103837831B8BFEC2F7FD12E799EA0@VI1PR04MB1038.eurprd04.prod.outlook.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Boris,

> -----Original Message-----
> From: Boris Brezillon [mailto:boris.brezillon at bootlin.com]
> Sent: Thursday, October 4, 2018 1:09 PM
> To: Yogesh Narayan Gaur <yogeshnarayan.gaur@nxp.com>
> Cc: Vignesh R <vigneshr@ti.com>; Marek Vasut <marek.vasut@gmail.com>; Rob
> Herring <robh+dt@kernel.org>; Brian Norris <computersforpeace@gmail.com>;
> Linux ARM Mailing List <linux-arm-kernel@lists.infradead.org>; linux-
> mtd at lists.infradead.org; devicetree at vger.kernel.org; linux-
> kernel at vger.kernel.org; juliensu at mxic.com.tw; zhengxunli at mxic.com.tw;
> masonccyang at mxic.com.tw
> Subject: Re: [PATCH 1/3] mtd: spi-nor: Add Octal mode support for
> mt35xu512aba
> 
> +Julien, Zhengxunli and Mason from Macronix
> 
> Hi Yogesh,
> 
> On Thu, 4 Oct 2018 06:51:41 +0000
> Yogesh Narayan Gaur <yogeshnarayan.gaur@nxp.com> wrote:
> 
> > Hi Vignesh,
> >
> > > -----Original Message-----
> > > From: Vignesh R [mailto:vigneshr at ti.com]
> > > Sent: Wednesday, October 3, 2018 10:26 PM
> > > To: Boris Brezillon <boris.brezillon@bootlin.com>; Marek Vasut
> > > <marek.vasut@gmail.com>; Rob Herring <robh+dt@kernel.org>
> > > Cc: Brian Norris <computersforpeace@gmail.com>; Yogesh Narayan Gaur
> > > <yogeshnarayan.gaur@nxp.com>; Linux ARM Mailing List <linux-arm-
> > > kernel at lists.infradead.org>; linux-mtd at lists.infradead.org;
> > > devicetree at vger.kernel.org; linux-kernel at vger.kernel.org; Vignesh R
> > > <vigneshr@ti.com>
> > > Subject: [PATCH 1/3] mtd: spi-nor: Add Octal mode support for
> > > mt35xu512aba
> > >
> > > Micron's mt35xu512aba flash is an Octal flash that has x8 IO lines.
> > > It supports read/write over 8 IO lines simulatenously. Add support
> > > for Octal read mode for Micron mt35xu512aba.
> > > Unfortunately, this flash is only complaint to SFDP JESD216B and
> > > does not seem to support newer JESD216C standard that provides auto
> > > detection of Octal mode capabilities and opcodes. Therefore, this
> > > capability is manually added using new SPI_NOR_OCTAL_READ flag.
> > >
> >
> > Thanks for sending the patch-set of adding octal support.
> > If possible, can you share the MT35x datasheet?
> >
> > I also have the patch ready in which I have added support for Read (1-1-8 and
> 1-8-8) protocol and Write (1-1-8 and 1-8-8).
> > Also have added support of Octal in driver/spi/spi.c framework.
> >
> > IMO, we would collaborate our patches.
> 
> Looks like we are of stepping on each others toes here (see this branch [1]). I
> guess it's not a problem if we agree on who is working on what.
> 
> Yogesh, you already sent "spi: add flags for octal I/O data transfer" [3] which is
> only adding the new OCTAL flags but is not patching spi.c and spi-mem.c to take
> those new flags into account. Here is my version of this patch [2] (it's still
> missing an update of SPI_MEM_MAX_BUSWIDTH). Let me know what you want
> to do (rework your version to address the problem or take mine).
> 
I haven't said that I have sent the patches. My patches are ready and needed to be sent for review.
In these patches,  I am adding support for X-X-X protocol for octal support and integrating them with spi  and flash m25p80 interface.

Would send the patches by today evening for review.

Regards
Yogesh Gaur

> Regarding other patches in [2], they're mainly here to add support for X-X-X and
> DTR modes and get the m25p80 logic integrated in spi-nor.c so that we can
> really check which NOR operations are supported by the SPI controller.
> 
> Regards,
> 
> Boris
> 
> [1]https://emea01.safelinks.protection.outlook.com/?url=https%3A%2F%2Fgith
> ub.com%2Fbbrezillon%2Flinux%2Fcommits%2Fspi-
> nor%2Focto&amp;data=02%7C01%7Cyogeshnarayan.gaur%40nxp.com%7C3ad
> 4b6f2a4c9470e98f308d629cc8362%7C686ea1d3bc2b4c6fa92cd99c5c301635%7
> C0%7C0%7C636742355682081158&amp;sdata=vXg7nwZ6dLrUxoNw9t41GYMp
> oPdNWUWhLM6wZPmrIec%3D&amp;reserved=0
> [2]https://emea01.safelinks.protection.outlook.com/?url=https%3A%2F%2Fgith
> ub.com%2Fbbrezillon%2Flinux%2Fcommit%2F9854a8fdd23f64e79859fd07a71d4
> a1c57b812f2&amp;data=02%7C01%7Cyogeshnarayan.gaur%40nxp.com%7C3ad
> 4b6f2a4c9470e98f308d629cc8362%7C686ea1d3bc2b4c6fa92cd99c5c301635%7
> C0%7C0%7C636742355682081158&amp;sdata=yEZqGYprHS8q2wuisFLpHg8bMj
> uuWDrl3ggWlA8LRoc%3D&amp;reserved=0
> [3]https://emea01.safelinks.protection.outlook.com/?url=https%3A%2F%2Fpat
> chwork.ozlabs.org%2Fpatch%2F894916%2F&amp;data=02%7C01%7Cyogeshnar
> ayan.gaur%40nxp.com%7C3ad4b6f2a4c9470e98f308d629cc8362%7C686ea1d3
> bc2b4c6fa92cd99c5c301635%7C0%7C0%7C636742355682081158&amp;sdata=t
> 5DFvXgDOlyLn7pMieue9BB5q24DNiJMywGvNrWAYOo%3D&amp;reserved=0
