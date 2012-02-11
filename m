From: tom.leiming@gmail.com (Ming Lei)
Date: Sat, 11 Feb 2012 20:42:22 +0800
Subject: [PATCH] arm: omap4: allow disabling MPU local timer if 32K timer
 is enabled
In-Reply-To: <20120211102644.GD13587@n2100.arm.linux.org.uk>
References: <1328949085-4452-1-git-send-email-tom.leiming@gmail.com>
 <20120211100351.GB13587@n2100.arm.linux.org.uk>
 <CACVXFVNJ=L_H_whTm6AyEc++B=Tw_Jfnzmn-QRYwbbBqiH7H1g@mail.gmail.com>
 <20120211102644.GD13587@n2100.arm.linux.org.uk>
Message-ID: <CACVXFVPzbSodv35RT_+ykRgDN8hQrhdCfiTFqfspJwSgOiWv3w@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, Feb 11, 2012 at 6:26 PM, Russell King - ARM Linux
<linux@arm.linux.org.uk> wrote:
> Have you actually checked the tick rate of your timer in /proc/interrupts?
> Have you checked /proc/timer_list to see what mode the system is in?

After checking, the system works at periodic mode, but I still don't know why
it can't be in one shot mode.

Seems a single clock_event_device can't work well at system with more than
one CPU, so the patch doesn't make sense, please ignore it.


thanks,
-- 
Ming Lei
