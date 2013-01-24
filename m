From: w.sang@pengutronix.de (Wolfram Sang)
Date: Thu, 24 Jan 2013 14:27:59 +0100
Subject: [PATCH] i2c: samsung: resume race fix
In-Reply-To: <20121107114437.0a563c7e@endymion.delvare>
References: <1352284106-24988-1-git-send-email-ch.naveen@samsung.com>
 <20121107114437.0a563c7e@endymion.delvare>
Message-ID: <20130124132759.GH12933@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Nov 07, 2012 at 11:44:37AM +0100, Jean Delvare wrote:
> On Wed, 07 Nov 2012 15:58:26 +0530, Naveen Krishna Chatradhi wrote:
> > Don't unmark the device as suspended until after it's been re-setup.
> > 
> > The main race would be w.r.t. an i2c driver that gets resumed at the same
> > time (asyncronously), that is allowed to do a transfer since suspended
> > is set to 0 before reinit, but really should have seen the -EIO return
> > instead.
> 
> I thought that the suspend order was children first and the resume
> order was parent first?

Same here, why does it not work this way?

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
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20130124/818565c5/attachment-0001.sig>
