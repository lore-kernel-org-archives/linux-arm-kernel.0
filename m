From: linux@roeck-us.net (Guenter Roeck)
Date: Thu, 18 Jun 2015 08:30:03 -0700
Subject: [PATCH 01/44] kernel: Add support for poweroff handler call chain
In-Reply-To: <55821936.4040704@codeaurora.org>
References: <1412659726-29957-1-git-send-email-linux@roeck-us.net>
 <1412659726-29957-2-git-send-email-linux@roeck-us.net>
 <55821936.4040704@codeaurora.org>
Message-ID: <20150618153003.GA19224@roeck-us.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jun 17, 2015 at 06:04:54PM -0700, Stephen Boyd wrote:
[ ... ]
> 
> What happened to this series? I want to add shutdown support to my
> platform and I need to write a register on the PMIC in one driver to
> configure it for shutdown instead of restart and then write an MMIO
> register to tell the PMIC to actually do the shutdown in another driver.
> It seems that the notifier solves this case for me, albeit with the
> slight complication that I need to order the two with some priority.
> 
Can you use the .shutdown driver callback instead ?

I see other drivers use that, and check for system_state == SYSTEM_POWER_OFF
to power off the hardware.

Guenter
