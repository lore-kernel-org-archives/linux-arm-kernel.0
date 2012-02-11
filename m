From: tom.leiming@gmail.com (Ming Lei)
Date: Sat, 11 Feb 2012 18:19:41 +0800
Subject: [PATCH] arm: omap4: allow disabling MPU local timer if 32K timer
 is enabled
In-Reply-To: <20120211100351.GB13587@n2100.arm.linux.org.uk>
References: <1328949085-4452-1-git-send-email-tom.leiming@gmail.com>
 <20120211100351.GB13587@n2100.arm.linux.org.uk>
Message-ID: <CACVXFVNJ=L_H_whTm6AyEc++B=Tw_Jfnzmn-QRYwbbBqiH7H1g@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, Feb 11, 2012 at 6:03 PM, Russell King - ARM Linux
<linux@arm.linux.org.uk> wrote:
> On Sat, Feb 11, 2012 at 04:31:25PM +0800, Ming Lei wrote:
>> With 32K gp timer, tick can be driven and system can run well, so
>> allow MPU local timer to be disabled if someone requires it, otherwise
>> MPU local timer is always chosen as the default clock_event_device.
>
> The point being?

IMO, 32K gp timer may be more energy-saving than MPU local timer
because gp timer has much less clock frequency and only half interrupts
generated in tick mode compared with mpu local timer.

>
> What if you want to use NO_HZ?

32K gp timer supports oneshot mode, so it should support NO_HZ.  In my test
.config, NO_HZ is enabled and system can run well.

thanks,
-- 
Ming Lei
