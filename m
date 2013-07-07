From: shc_work@mail.ru (=?UTF-8?B?QWxleGFuZGVyIFNoaXlhbg==?=)
Date: Sun, 07 Jul 2013 14:31:41 +0400
Subject: =?UTF-8?B?UmVbMl06IFtQQVRDSF0gQVJNOiBkdHM6IGlteDI3IHBoeUNBUkQtUyByZW1v?=
 =?UTF-8?B?dmUgd3JvbmcgSTJDIFJUQw==?=
In-Reply-To: <20130707102207.GI16871@s25.your-server.de>
References: <1372782469.486055292@f129.mail.ru>
 <1373100718.107651915@f159.i.mail.ru>
 <20130707102207.GI16871@s25.your-server.de>
Message-ID: <1373193101.622550139@f60.mail.ru>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

> On Sat, Jul 06, 2013 at 12:51:58PM +0400, Alexander Shiyan wrote:
> > > Fixup of commit 7874d595b78e431f0f661d2fe47625649308a52e
> > > "ARM: dts: Add device tree support for phycard pca100".
> > > 
> > > Remove wrong I2C RTC node.
> > > 
> > > Signed-off-by: Markus Pargmann <mpa@pengutronix.de>
> > > ---
> > > 
> > > Thanks, Alexander, you are right. I2C2 has no RTC.
> > ...
> > 
> > There are a couple of comments on this file.
> > 
> > I think that the OWIRE should be moved to the RDK.
> 
> I moved OWIRE and i2c1 to RDK. Both are not used on the SOM.
> 
> > ioexpander must contain "gpio-controller" at least, and for use it further,
> > it is necessary to define the label for this node.
> 
> I checked all I2C devices in the board schematics. There is actually no
> ioexpander. I don't know why it was added. I will send some I2C patches
> later.

Perhaps the chip is mounted on the camera module.
A similar IC is exist on PCM-970 camera addon device.
If so, the device should also be moved to RDK.

---
