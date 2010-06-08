From: mcuos.com@gmail.com (Wan ZongShun)
Date: Tue, 8 Jun 2010 22:49:09 +0800
Subject: [PATCH 2/2] pxa: modify the pxa2xx-ac97 file for pxa168
In-Reply-To: <AANLkTimNwtScfKYVc4qPZFEP6GYklPoHLgr2AE7yquQL@mail.gmail.com>
References: <4C0E21A1.4000909@gmail.com>
	<AANLkTimNwtScfKYVc4qPZFEP6GYklPoHLgr2AE7yquQL@mail.gmail.com>
Message-ID: <AANLkTimZjKvAAcK9xiXng7wJ0tVBJrmTIvMgyzrS7HqH@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

2010/6/8 Eric Miao <eric.y.miao@gmail.com>:
> 2010/6/8 Wan ZongShun <mcuos.com@gmail.com>:
>> In order to allow the sharing of the pxa2xx-ac97 driver file with pxa168,
>> we have to do a little change to pxa2xx-ac97 file.
>>
>> All private register addresses were located in mach/include/ac97.h.
>
> This is not the right way to go, as suggested already. I hope the ac97
> driver is more self-contained. i.e. having a platform device for:
>
> ?- where the registers are mapped from
> ?- drcmr channel numbers can be encoded within dma resource
> ?- ac97 register definitions are not exposed everywhere
>

Got it, so I should put above to platform_device and remove regs-ac97.h,
any private bit definition should be removed to driver directory as
driver _only_.


-- 
*linux-arm-kernel mailing list
mail addr:linux-arm-kernel at lists.infradead.org
you can subscribe by:
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel

* linux-arm-NUC900 mailing list
mail addr:NUC900 at googlegroups.com
main web: https://groups.google.com/group/NUC900
you can subscribe it by sending me mail:
mcuos.com at gmail.com
