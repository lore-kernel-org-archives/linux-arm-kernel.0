From: haojian.zhuang@gmail.com (Haojian Zhuang)
Date: Mon, 7 May 2012 16:18:40 +0800
Subject: [PATCH 1/2] mfd: max8925: request resource region
In-Reply-To: <20120507075800.GL26481@n2100.arm.linux.org.uk>
References: <1336360249-29963-1-git-send-email-haojian.zhuang@gmail.com>
 <20120507075800.GL26481@n2100.arm.linux.org.uk>
Message-ID: <CAN1soZzj1FKhFPHOUjbARpzuA1_vB4TO0O8ThCiG49nPqYqCwg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, May 7, 2012 at 3:58 PM, Russell King - ARM Linux
<linux@arm.linux.org.uk> wrote:
> On Mon, May 07, 2012 at 11:10:48AM +0800, Haojian Zhuang wrote:
>> If resource region isn't requested, component devices will fail to request
>> their resources.
>>
>> Signed-off-by: Haojian Zhuang <haojian.zhuang@gmail.com>
>
> This looks wrong.
>
> This driver looks broken. ?IO regions are for PC IO stuff, not for I2C
> buses. ?There is no resource reservation system in the kernel for
> registers on I2C devices.

There's some components in PMIC devices. I used IO resources to
identify these components,
and these IO resources are register offset in PMIC. But if I choose
MEM resources, it may
conflict with real memory resources. So I choose IO resources. Do you
have any other implementation
instead?

Thanks
Haojian
