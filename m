From: frediano.ziglio@huawei.com (Frediano Ziglio)
Date: Tue, 13 Jan 2015 14:18:16 +0000
Subject: [PATCH] ARM: dts: hip04: move bootwrapper to SRAM
In-Reply-To: <4774908.c54zTnV4pN@wuerfel>
References: <54B48D5E.6050902@hisilicon.com> <3703587.1qvjMFgdrL@wuerfel>
 <54B4F350.5040007@hisilicon.com> <4774908.c54zTnV4pN@wuerfel>
Message-ID: <B944B469BF5302468AC6EB05E56CC70DB3BAA8@lhreml503-mbs.china.huawei.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

> On Tuesday 13 January 2015 18:28:32 Wei Xu wrote:
> >
> > > Generally speaking it's not ok to change firmware interfaces in an
> > > incompatible way. The preferred way to handle this would be to have
> > > the firmware that puts the boot wrapper into a different place also
> > > update this property, if at all possible.
> >
> > I very agreed with you.
> >
> > But before we have two kind of firmwares one is boot from SVC
> > supporting PXE/NAND/SATA/GRUB booting and the other is boot from HYP
> > just supporting NAND booting.
> > This time we updated the firmware and made it boot from HYP
> supporting
> > PXE/NAND/SATA/GRUB as we hoped(thanks for Alex's supporting!).
> >
> > Since we have to publish a new firmware I think it is a chance to
> > update the dts of kernel. How do you think about it?
> 
> The intention is certainly good. If you expect no further incompatible
> changes, how about adding another .dts file for this machine that can
> work with the old firmware?
> 
> 	Arnd

Would much prefer to have PSCI support instead directly in the firmware.

Frediano
