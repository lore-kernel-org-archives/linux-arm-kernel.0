From: wsa@the-dreams.de (Wolfram Sang)
Date: Thu, 15 Aug 2013 14:31:37 +0200
Subject: [PATCH 1/2] i2c: davinci: remove useless mach/hardware include
In-Reply-To: <51F191AD.9020108@ti.com>
References: <1374712099-32095-1-git-send-email-santosh.shilimkar@ti.com>
 <1374712099-32095-2-git-send-email-santosh.shilimkar@ti.com>
 <51F0F283.5080900@ti.com> <51F191AD.9020108@ti.com>
Message-ID: <20130815123137.GC17155@katana>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Jul 25, 2013 at 04:59:25PM -0400, Santosh Shilimkar wrote:
> On Thursday 25 July 2013 05:40 AM, Sekhar Nori wrote:
> > On Thursday 25 July 2013 05:58 AM, Santosh Shilimkar wrote:
> >> This driver no longer uses definitions from mach/hardware.h.
> >> On the other hand, including this header breaks this driver
> >> on non-davinci platforms which don't have such a header.
> >>
> >> Fix it.
> >>
> >> Cc: Sekhar Nori <nsekhar@ti.com>
> >> Cc: Wolfram Sang <wsa@the-dreams.de>
> >>
> >> Signed-off-by: Santosh Shilimkar <santosh.shilimkar@ti.com>
> > 
> > Acked-by: Sekhar Nori <nsekhar@ti.com>
> > 
> > One minor nit:
> > 
> >> ---
> >>  drivers/i2c/busses/i2c-davinci.c |    1 -
> >>  1 file changed, 1 deletion(-)
> >>
> >> diff --git a/drivers/i2c/busses/i2c-davinci.c b/drivers/i2c/busses/i2c-davinci.c
> >> index fa55605..ddaa2a3 100644
> >> --- a/drivers/i2c/busses/i2c-davinci.c
> >> +++ b/drivers/i2c/busses/i2c-davinci.c
> >> @@ -41,7 +41,6 @@
> >>  #include <linux/of_i2c.h>
> >>  #include <linux/of_device.h>
> >>  
> > 
> > You can now remove this empty line too.
> > 
> Yes. Updated patch below with your ack added.
> 
> Regards,
> Santosh
> 
> From d7ae1c488ebae19028f33abff76c4d684271a7fb Mon Sep 17 00:00:00 2001
> From: Santosh Shilimkar <santosh.shilimkar@ti.com>
> Date: Tue, 23 Jul 2013 15:40:46 -0400
> Subject: [PATCH 1/2] i2c: davinci: remove useless mach/hardware include
> 
> This driver no longer uses definitions from mach/hardware.h.
> On the other hand, including this header breaks this driver
> on non-davinci platforms which don't have such a header.
> 
> Fix it.

Applied to for-next, thanks! Please send a proper V2 in a seperate
message next time.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20130815/c8758217/attachment.sig>
