From: george.cherian@ti.com (George Cherian)
Date: Fri, 9 May 2014 15:37:30 +0530
Subject: [PATCH v2] ARM: dts: am33xx: Move the cppi41dma node so it's
 probed early
In-Reply-To: <536C82F1.6020809@linutronix.de>
References: <1398373881-23369-1-git-send-email-ezequiel@vanguardiasur.com.ar>	<CAGm1_kvHtSLNEfkJ24xZGGzsqAjHDTM1XztnX-QGs4iM5voMUw@mail.gmail.com>	<535F5BA5.6000903@ti.com>
 <CAAEAJfCG3c++WBgeipF6sCE1-9pHgU80t2Mpz0Y4koU5-uEwSA@mail.gmail.com>
 <536C7443.4000805@ti.com> <536C82F1.6020809@linutronix.de>
Message-ID: <536CA8E2.9010707@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 5/9/2014 12:55 PM, Sebastian Andrzej Siewior wrote:
> On 05/09/2014 08:22 AM, George Cherian wrote:
>> Just by remodelling the dt the whole problem can be solved.
>> I am still not convinced why we should not be doing it?
>> Because neither ways its not the exact representation of the H/W.
> Ha. Now I am confused. First I assumed that the musb_am335x module is
> built-in only to duct-tape the bug you are seeing. So this patch never
> made it mainline then.
> The problem is as far as I remember the way the phy-core does things
> and should be fixed. Re-arranging does not help because you can still
> oops the kernel (the same oops you have now) by removing the devices
> manually via sysfs.
Okay...
So, You mean to say if I unbind the phy device  and then try to remove 
musb_am335x module,
then it will oops.
Now I got it...
>
> Sebastian
> --
> To unsubscribe from this list: send the line "unsubscribe linux-omap" in
> the body of a message to majordomo at vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html


-- 
-George
