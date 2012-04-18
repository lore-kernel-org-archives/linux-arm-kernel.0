From: w.sang@pengutronix.de (Wolfram Sang)
Date: Wed, 18 Apr 2012 11:20:19 +0200
Subject: [PATCH V2 1/3] lib: add support for stmp-style devices
In-Reply-To: <20120418090551.GA30966@shlinux2.ap.freescale.net>
References: <1332368519-22660-1-git-send-email-w.sang@pengutronix.de>
 <1332368519-22660-2-git-send-email-w.sang@pengutronix.de>
 <4F73CCC6.6000001@freescale.com>
 <20120329064320.GA20840@pengutronix.de>
 <20120418090551.GA30966@shlinux2.ap.freescale.net>
Message-ID: <20120418092019.GB2232@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Apr 18, 2012 at 05:05:52PM +0800, Dong Aisheng wrote:
> Hi Wolfram,
> 
> On Thu, Mar 29, 2012 at 08:43:20AM +0200, Wolfram Sang wrote:
> > Hi,
> > 
> > > >  include/linux/stmp_device.h |   20 +++++++++++
> > > IMHO, this header should be placed at include/linux/fsl/.
> > 
> > Hmm, one never knows if somewhen in the future some other vendor decides to do
> > do a device with this register layout. It is just a layout, not an IP core per
> > se. So, I'd prefer to leave it as is.
> > 
> 
> Acked-by: Dong Aisheng <dong.aisheng@linaro.org>

Thanks!

> 
> I'm converting mxs-dma driver to be mach-independent which also needs
> this patch.
> 
> Do you know when this will be merged?

Nope. I assumed it could go in via arm-soc, since it makes sense and
Arnd used to comment this series. He is probably busy, currently.

> BTW, one small question:
> Is it possible that stmp_reset_block also be used by other vendors?

Sure, why not? I could ask a friend to to do an FPGA for me with this
layout.

> If not, i guess include/linux/fsl which already exists may be the
> right place.

Which is a bad choice in my book. linux/dma would have been the proper
thing for mxs-dma.h, I'd think.

Regards,

   Wolfram

-- 
Pengutronix e.K.                           | Wolfram Sang                |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 198 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20120418/e219cda9/attachment.sig>
