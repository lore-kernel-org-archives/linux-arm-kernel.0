From: alexandre.belloni@free-electrons.com (Alexandre Belloni)
Date: Mon, 16 Mar 2015 20:17:42 +0100
Subject: PM: knowing the system state in the device callback
Message-ID: <20150316191742.GI4560@piout.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

I'm trying to get rid of at91_suspend_entering_slow_clock() which is
exposing the platform suspend_state_t to the devices. From what I
understand, whenever suspend_state_t is PM_SUSPEND_MEM or
PM_SUSPEND_STANDBY, the pm_message_t passed to the device driver is
always PM_EVENT_SUSPEND.

The requirement is to know whether we are going to cut the master clock
and in that case, avoid calling enable_irq_wake() because we will not be
able to wakeup from the device.

Is there a better way to do that? Or should I implement a similar
function in the pm core (which I guess would already be there if
really needed)?

Regards,

-- 
Alexandre Belloni, Free Electrons
Embedded Linux, Kernel and Android engineering
http://free-electrons.com
