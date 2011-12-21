From: arnd@arndb.de (Arnd Bergmann)
Date: Wed, 21 Dec 2011 09:43:34 +0000
Subject: [PATCH V3 4/7] cpufreq: add generic cpufreq driver
In-Reply-To: <20111221092739.GI15863@b20223-02.ap.freescale.net>
References: <1324264903-15395-1-git-send-email-richard.zhao@linaro.org>
 <20111221012046.GE15863@b20223-02.ap.freescale.net>
 <20111221092739.GI15863@b20223-02.ap.freescale.net>
Message-ID: <201112210943.34310.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wednesday 21 December 2011, Richard Zhao wrote:
> On Wed, Dec 21, 2011 at 09:20:46AM +0800, Richard Zhao wrote:

> > > > > You also need to define how the core supplies get looked up.
> > > 
> > > > It's pure software. platform uses this driver have to define "cpu" consumer.
> > > 
> > > You still need to define this in the binding.
> > You mean regulator DT binding? already in ? I'll check it.
> Mark, cpu node is not a struct device, sys_device instead. I can not find
> regulator via device/dt node. Can I still use the string to get regulator
> after converting to DT?

I believe Kay and Greg have the plan to unify "class" and "bus" in sysfs, which
implies turning sys_device into a derived class of device instead of kobject.
If that understanding is correct, we might as well do that now so we can
attach a device_node to a sys_device.

Kay, does this make sense?

	Arnd
