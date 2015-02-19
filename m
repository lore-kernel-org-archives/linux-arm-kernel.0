From: sanjeevsharmaengg@gmail.com (sanjeev sharma)
Date: Thu, 19 Feb 2015 10:44:49 +0530
Subject: [PATCH] ARM: make of_device_ids const
In-Reply-To: <6700107.3fSsY2uIcW@wuerfel>
References: <1424290796-18475-1-git-send-email-u.kleine-koenig@pengutronix.de>
 <6700107.3fSsY2uIcW@wuerfel>
Message-ID: <CAGUYZuREm+XAO7mD0gxeSftStxUOADHmoZ2ngcKp218FaKOeGw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Feb 19, 2015 at 2:07 AM, Arnd Bergmann <arnd@arndb.de> wrote:
> On Wednesday 18 February 2015 21:19:56 Uwe Kleine-K?nig wrote:
>> of_device_ids (i.e. compatible strings and the respective data) are not
>> supposed to change at runtime. All functions working with of_device_ids
>> provided by <linux/of.h> work with const of_device_ids. So mark the
>> non-const structs in arch/arm as const, too.
>>
>> While at it also add some __initconst annotations.
>>
>> Acked-by: Jason Cooper <jason@lakedameon.net>
>> Signed-off-by: Uwe Kleine-K?nig <u.kleine-koenig@pengutronix.de>
>
> Applied to fixes branch, thanks!
>
>         Arnd

There are many places in driver also where this need to be fixed.I
have submitted couple of patches listed below and waiting for the
response.

serial:imx make of_device_id array const
pinctrl: freescale: make of_device_id array const

Regards
Sanjeev Sharma

>
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel at lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
