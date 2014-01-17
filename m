From: shc_work@mail.ru (=?UTF-8?B?QWxleGFuZGVyIFNoaXlhbg==?=)
Date: Fri, 17 Jan 2014 20:59:43 +0400
Subject: =?UTF-8?B?UmU6IFtQQVRDSCBWMyAzLzNdIHBvd2VyOiByZXNldDogdXNlIHN5c2NvbiBk?=
 =?UTF-8?B?cml2ZXIgdG8gcGFyc2UgcmVib290IHJlZ2lzdGVyIGZyb20gc2N1?=
In-Reply-To: <201401171752.47393.arnd@arndb.de>
References: <1389748055-23534-1-git-send-email-fkan@apm.com>
 <1389748055-23534-4-git-send-email-fkan@apm.com>
 <201401171752.47393.arnd@arndb.de>
Message-ID: <1389977983.940533034@f47.i.mail.ru>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

???????, 17 ?????? 2014, 17:52 +01:00 ?? Arnd Bergmann <arnd@arndb.de>:
> On Wednesday 15 January 2014, Feng Kan wrote:
> > +static int __init xgene_reboot_init(void)
> >  {
> >         arm_pm_restart = xgene_restart;
> >         return 0;
> >  }
> >  device_initcall(xgene_reboot_init);
> 
> This won't work on a generic kernel, since you unconditionally set the
> pm_restart function to your own, which is broken for everything else.
> 
> Please keep the platform_driver to attach to the reboot device
> as you had before. It might be good to turn this into a generic
> "syscon-reset" driver that gets both the register number and
> the contents to write from the device node.

I am not sure but think the new driver for SYSCON GPIOs can be
reused for such purpose:
http://www.spinics.net/lists/devicetree/msg18221.html

---
