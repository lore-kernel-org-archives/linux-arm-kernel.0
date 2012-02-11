From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Sat, 11 Feb 2012 10:26:44 +0000
Subject: [PATCH] arm: omap4: allow disabling MPU local timer if 32K
 timer is enabled
In-Reply-To: <CACVXFVNJ=L_H_whTm6AyEc++B=Tw_Jfnzmn-QRYwbbBqiH7H1g@mail.gmail.com>
References: <1328949085-4452-1-git-send-email-tom.leiming@gmail.com>
 <20120211100351.GB13587@n2100.arm.linux.org.uk>
 <CACVXFVNJ=L_H_whTm6AyEc++B=Tw_Jfnzmn-QRYwbbBqiH7H1g@mail.gmail.com>
Message-ID: <20120211102644.GD13587@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, Feb 11, 2012 at 06:19:41PM +0800, Ming Lei wrote:
> On Sat, Feb 11, 2012 at 6:03 PM, Russell King - ARM Linux
> <linux@arm.linux.org.uk> wrote:
> > On Sat, Feb 11, 2012 at 04:31:25PM +0800, Ming Lei wrote:
> >> With 32K gp timer, tick can be driven and system can run well, so
> >> allow MPU local timer to be disabled if someone requires it, otherwise
> >> MPU local timer is always chosen as the default clock_event_device.
> >
> > The point being?
> 
> IMO, 32K gp timer may be more energy-saving than MPU local timer
> because gp timer has much less clock frequency and only half interrupts
> generated in tick mode compared with mpu local timer.
> 
> >
> > What if you want to use NO_HZ?
> 
> 32K gp timer supports oneshot mode, so it should support NO_HZ.  In my test
> .config, NO_HZ is enabled and system can run well.

Have you actually checked the tick rate of your timer in /proc/interrupts?
Have you checked /proc/timer_list to see what mode the system is in?
