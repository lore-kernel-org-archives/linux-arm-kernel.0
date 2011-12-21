From: broonie@opensource.wolfsonmicro.com (Mark Brown)
Date: Wed, 21 Dec 2011 12:11:10 +0000
Subject: [PATCH V3 4/7] cpufreq: add generic cpufreq driver
In-Reply-To: <201112210943.34310.arnd@arndb.de>
References: <1324264903-15395-1-git-send-email-richard.zhao@linaro.org>
 <20111221012046.GE15863@b20223-02.ap.freescale.net>
 <20111221092739.GI15863@b20223-02.ap.freescale.net>
 <201112210943.34310.arnd@arndb.de>
Message-ID: <20111221121108.GA15309@opensource.wolfsonmicro.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Dec 21, 2011 at 09:43:34AM +0000, Arnd Bergmann wrote:
> On Wednesday 21 December 2011, Richard Zhao wrote:

> > Mark, cpu node is not a struct device, sys_device instead. I can not find
> > regulator via device/dt node. Can I still use the string to get regulator
> > after converting to DT?

> I believe Kay and Greg have the plan to unify "class" and "bus" in sysfs, which
> implies turning sys_device into a derived class of device instead of kobject.
> If that understanding is correct, we might as well do that now so we can
> attach a device_node to a sys_device.

> Kay, does this make sense?

I'm noy Kay but I think even if it's not what we end uo doing internally
it's a sensible design for the device tree representation.
