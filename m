From: nicolas.pitre@linaro.org (Nicolas Pitre)
Date: Wed, 18 Jun 2014 10:37:15 -0400 (EDT)
Subject: [PATCH] ARM: save/restore diagnostic register on ARMv7
 suspend/resume
In-Reply-To: <20140618123906.GI8860@dragon>
References: <1403081398-32116-1-git-send-email-shawn.guo@freescale.com>
 <20140618104009.GH32699@arm.com> <20140618123906.GI8860@dragon>
Message-ID: <alpine.LFD.2.11.1406181033510.16842@knanqh.ubzr>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, 18 Jun 2014, Shawn Guo wrote:

> On Wed, Jun 18, 2014 at 11:40:09AM +0100, Will Deacon wrote:
> > On Wed, Jun 18, 2014 at 09:49:58AM +0100, Shawn Guo wrote:
> > > The CP15 diagnostic register holds ARM errata bits on ARMv7, so it
> > > needs to be saved/restored on suspend/resume.  Otherwise, the
> > > effectiveness of errata workaround gets lost together with diagnostic
> > > register bit across suspend/resume cycle.
> > 
> > This should be conditional on Cortex-A9, since this register is certainly
> > not architected.
> 
> Ah, yes.  In that case, I should probably handle it at platform level to
> avoid messing up generic ARMv7 suspend/resume routines.

Please don't do that.

You may look at commit 16c79a3776 and do something similar for 
Cortex-A9.


Nicolas
