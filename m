From: shc_work@mail.ru (=?UTF-8?B?QWxleGFuZGVyIFNoaXlhbg==?=)
Date: Fri, 09 Aug 2013 14:50:11 +0400
Subject: =?UTF-8?B?UmU6IFByb3Bvc2FsOiBJMkMgZGV2aWNlIHBvd2VyIChXYXM6IGh3bW9uOiAo?=
 =?UTF-8?B?bG05MCkgQWRkIHBvd2VyIGNvbnRyb2wp?=
In-Reply-To: <20130809102757.GT6427@sirena.org.uk>
References: <1375944991-29182-1-git-send-email-wni@nvidia.com>
 <1376027820.695103970@f416.i.mail.ru>
 <20130809102757.GT6427@sirena.org.uk>
Message-ID: <1376045411.585130456@f141.i.mail.ru>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

> On Fri, Aug 09, 2013 at 09:57:00AM +0400, Alexander Shiyan wrote:
> 
> > Instead of adding the support of regulators in each device, let's think about
> > whether it is possible to create a global regulator for any device on the I2C bus.
> 
> > I see it like this:
> > We add an extra field in the i2c_board_info structure "power_name" and handle
> > it in the i2c_device_{probe/remove} functions.
> 
> This would need to be an array of supplies, relatively few devices need
> only a single power supply.  This is also not something that should be
> handled in I2C, power is not something that's uniquely needed by devices
> on an I2C bus.

Additional regulators can be handled in the driver, or "parent"-scheme can
be used. Is not it?

---
