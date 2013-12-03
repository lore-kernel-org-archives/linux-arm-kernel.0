From: marex@denx.de (Marek Vasut)
Date: Tue, 3 Dec 2013 13:28:20 +0100
Subject: [PATCH 2/5] ARM: mxs: crypto: Remove the old DCP driver
In-Reply-To: <20131203110731.GE13726@S2101-09.ap.freescale.net>
References: <1385932823-3860-1-git-send-email-marex@denx.de>
 <1385932823-3860-2-git-send-email-marex@denx.de>
 <20131203110731.GE13726@S2101-09.ap.freescale.net>
Message-ID: <201312031328.20860.marex@denx.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Dear Shawn Guo,

> On Sun, Dec 01, 2013 at 10:20:20PM +0100, Marek Vasut wrote:
> > Remove the old DCP driver as it had multiple severe issues. The driver
> > will be replaced by a more robust implementation. Here is a short list
> > of problems with this driver:
> > 
> > 1) It only supports AES_CBC
> > 
> > 2) The driver was apparently never ran behind anyone working with MXS. ie.:
> >    -> Restarting the DCP block is not done via mxs_reset_block()
> >    -> The DT name is not "fsl,dcp" or "fsl,mxs-dcp" as other MXS drivers
> > 
> > 3) Introduces new ad-hoc IOCTLs
> > 4) The IRQ handler can't use usual completion() in the driver because
> > that'd
> > 
> >    trigger "scheduling while atomic" oops, yes?
> > 
> > Signed-off-by: Marek Vasut <marex@denx.de>
> 
> Please drop "ARM: mxs: " from patch subject, since it's not a patch
> touching arch/arm/mach-mxs anyhow.  It's there confusing people.
> 
> Shawn

Removed. Will gather more feedback and repost V2.

Best regards,
Marek Vasut
