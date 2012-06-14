From: w.sang@pengutronix.de (Wolfram Sang)
Date: Thu, 14 Jun 2012 11:14:34 +0200
Subject: [PATCH] i2c: let the core register devices from devicetree
In-Reply-To: <1339623217.9220.119.camel@pasglop>
References: <1339622215-4733-1-git-send-email-w.sang@pengutronix.de>
 <1339623217.9220.119.camel@pasglop>
Message-ID: <20120614091434.GB14419@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Jun 14, 2012 at 07:33:37AM +1000, Benjamin Herrenschmidt wrote:
> On Wed, 2012-06-13 at 23:12 +0200, Wolfram Sang wrote:
> > Currently, every driver has to do it on its own, but it should be done
> > in the core, like we already do with board_info structs.
> > 
> > Signed-off-by: Wolfram Sang <w.sang@pengutronix.de>
> > ---
> > 
> > Based on v3.5-rc2. Only build tested, I don't have a OF based device
> > around at the moment.
> 
> Won't that conflict with i2c-powermac doing it its own way ?

Yup :(

I assume there is no chance that the powermac devicetree can be
pre-processed to be compatible with of_i2c_register_devices?

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
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20120614/3bc4eeb9/attachment.sig>
