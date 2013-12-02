From: shc_work@mail.ru (=?UTF-8?B?QWxleGFuZGVyIFNoaXlhbg==?=)
Date: Mon, 02 Dec 2013 14:33:29 +0400
Subject: =?UTF-8?B?UmU6IFtQQVRDSCBSRVNFTkRdIG1mZDogbWMxM3h4eDogUmVtb3ZlIHVubmVl?=
 =?UTF-8?B?ZGVkIG1jMTN4eHhfbG9jay91bmxvY2s=?=
In-Reply-To: <529C5804.2020501@gmail.com>
References: <1385787681-7736-1-git-send-email-shc_work@mail.ru>
 <529C5804.2020501@gmail.com>
Message-ID: <1385980409.843563145@f327.i.mail.ru>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello.

> Le 30/11/2013 06:01, Alexander Shiyan a ?crit :
> > Locking is performed by regmap API so no additional locking is
> > needed. Nevertheless, keep locking in the ADC conversion routine.
> > This need for keep proper read ADC sequence when calling from adc &
> > touchscreen drivers.
> 
> You can't do that so easily !
> Regmap only protect against concurrent access to the SPI/I2C bus, but do
> not protect the driver's internal data.
> And it does not protect against a race between concurrent access at a
> higher level :
...
> It's OK to do this if you are protected by a mutex, but as soon as you
> remove it you will have concurrency between two irq_unmask/irq_mask.

irq_unmask/irq_mask and some other functions can be converted to use
mc13xxx_reg_rmw. So I'll make a patch for this first.
Thanks.

---
