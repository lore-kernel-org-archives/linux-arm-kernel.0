From: balbi@ti.com (Felipe Balbi)
Date: Fri, 16 Jan 2015 16:57:32 -0600
Subject: [PATCH 1/5] mfd: tps65218: make INT[12] and STATUS registers
 volatile
In-Reply-To: <20150114170716.GL2419@atomide.com>
References: <1419622104-25812-1-git-send-email-balbi@ti.com>
 <1419622104-25812-2-git-send-email-balbi@ti.com>
 <20150106173734.GL6502@saruman> <20150108162512.GC31926@saruman>
 <20150112164654.GB6525@saruman> <20150114170716.GL2419@atomide.com>
Message-ID: <20150116225732.GB6254@saruman>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On Wed, Jan 14, 2015 at 09:07:17AM -0800, Tony Lindgren wrote:
> > > > > STATUS register can be modified by the HW, so we
> > > > > should bypass cache because of that.
> > > > > 
> > > > > In the case of INT[12] registers, they are the ones
> > > > > that actually clear the IRQ source at the time they
> > > > > are read. If we rely on the cache for them, we will
> > > > > never be able to clear the interrupt, which will cause
> > > > > our IRQ line to be disabled due to IRQ throttling.
> > > > > 
> > > > > Fixes: 44b4dc6 mfd: tps65218: Add driver for the TPS65218 PMIC
> > > > > Cc: <stable@vger.kernel.org> # v3.15+
> > > > > Cc: Keerthy <j-keerthy@ti.com>
> > > > > Cc: Lee Jones <lee.jones@linaro.org>
> > > > > Signed-off-by: Felipe Balbi <balbi@ti.com>
> > > > 
> > > > ping
> > > 
> > > another ping. Without this and the following patch TPS65218 power button
> > > driver which was already applied by Dmitry, won't work.
> > 
> > Anybody ? -rc4 is out and tps65218 is still broken because nobody has
> > acted on these two patches. All other patches which are meant for 3.20
> > merge window are applied and because of these pending, those patches
> > won't work.
> 
> Lee, are you planning to pick these two drivers/mfd patches?

Samuel, Lee, is someone planning on picking these two patches up ?
v3.19 remains broken.

-- 
balbi
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 819 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20150116/5feee76e/attachment.sig>
