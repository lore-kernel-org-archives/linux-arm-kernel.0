From: u.kleine-koenig@pengutronix.de (Uwe =?iso-8859-1?Q?Kleine-K=F6nig?=)
Date: Mon, 24 Feb 2014 00:17:55 +0100
Subject: [patch 09/26] arm: mmp: Remove pointless fiddling with irq
 internals
In-Reply-To: <20140223212737.214342433@linutronix.de>
References: <20140223212703.511977310@linutronix.de>
 <20140223212737.214342433@linutronix.de>
Message-ID: <20140223231755.GA27579@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Thomas,

On Sun, Feb 23, 2014 at 09:40:13PM -0000, Thomas Gleixner wrote:
> The pm-mmp2 and pm-pxa910 power management related irq_set_wake
> callbacks fiddle pointlessly with the irq actions for no reason except
> for lack of understanding how the wakeup mechanism works.
> 
> On supsend the core disables all interrupts lazily, i.e. it does not
> mask them at the irq controller level. So any interrupt which is
> firing during supsend will mark the corresponding interrupt line as
s/supsend/suspend/ twice
> pending. Just before the core powers down it checks whether there are
> interrupts pending from interrupt lines which are marked as wakeup
> sources and if so it aborts the resume and resends the interrupts.
It's the suspend that is aborted, not the resume.

Other than that your change looks fine.

Uwe

-- 
Pengutronix e.K.                           | Uwe Kleine-K?nig            |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
