From: dbaryshkov@gmail.com (Dmitry Eremin-Solenikov)
Date: Tue, 28 Jun 2011 12:23:58 +0000 (UTC)
Subject: [RFC] implement a generic PWM framework - once again
References: <1309255368-9775-1-git-send-email-s.hauer@pengutronix.de>
Message-ID: <iuch4t$6ba$1@dough.gmane.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

Sascha Hauer wrote:

> Hi All,
>
> The following implements a generic pwm framework and adds a user
> for it. I already posted this series back in January. Based on
> the comments I received I added some details about the motivation
> for adding such a framework and not using the led or hwmon framework
> to patch 1/2.
> I also added some documentation to Documentation/pwm.txt.
>
> This patch does not change the user API for PWMs, in particular
> it does not enforce any sleep/nonsleep context to the PWM users.
> The patch merely puts the status quo into a core wrapper to be able
> to register multiple PWM drivers in the system. Improvements to
> the API can still be made later once we have at least a place
> in the kernel to collect the existing PWM drivers.

Just a small question: on PXA (just for example) PWMs are registered
from arch/arm via arch_initcall. Will your subsystem work for such early
registration (of course after moving PXA driver to drivers/pwm)?

-- 
With best wishes
Dmitry
