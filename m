From: balbi@ti.com (Felipe Balbi)
Date: Mon, 19 Jan 2015 08:41:07 -0600
Subject: [PATCH 1/5] mfd: tps65218: make INT[12] and STATUS registers
 volatile
In-Reply-To: <20150118095214.GA3574@x1>
References: <1419622104-25812-1-git-send-email-balbi@ti.com>
 <1419622104-25812-2-git-send-email-balbi@ti.com>
 <20150118095214.GA3574@x1>
Message-ID: <20150119144107.GC20386@saruman>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, Jan 18, 2015 at 09:52:14AM +0000, Lee Jones wrote:
> On Fri, 26 Dec 2014, Felipe Balbi wrote:
> 
> > STATUS register can be modified by the HW, so we
> > should bypass cache because of that.
> > 
> > In the case of INT[12] registers, they are the ones
> > that actually clear the IRQ source at the time they
> > are read. If we rely on the cache for them, we will
> > never be able to clear the interrupt, which will cause
> > our IRQ line to be disabled due to IRQ throttling.
> > 
> > Fixes: 44b4dc6 mfd: tps65218: Add driver for the TPS65218 PMIC
> > Cc: <stable@vger.kernel.org> # v3.15+
> > Cc: Keerthy <j-keerthy@ti.com>
> > Cc: Lee Jones <lee.jones@linaro.org>
> > Signed-off-by: Felipe Balbi <balbi@ti.com>
> > ---
> >  drivers/mfd/tps65218.c | 11 +++++++++++
> >  1 file changed, 11 insertions(+)
> 
> Sorry for the delay.  It's difficult to get a WiFi signal 2000m up in
> an Austrian mountain. :)

now you're just making excuses ;-)

> Applied now, thanks.

thanks :-)

-- 
balbi
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 819 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20150119/92854f0d/attachment.sig>
