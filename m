From: richard.zhao@linaro.org (Richard Zhao)
Date: Wed, 21 Dec 2011 22:19:11 +0800
Subject: [PATCH V3 4/7] cpufreq: add generic cpufreq driver
In-Reply-To: <CAPXgP10CGxfEJ4jK2MkKt0-nAWgiawDERyA1N4wHvMCJfE3oDg@mail.gmail.com>
References: <1324264903-15395-1-git-send-email-richard.zhao@linaro.org>
 <20111221012046.GE15863@b20223-02.ap.freescale.net>
 <20111221092739.GI15863@b20223-02.ap.freescale.net>
 <201112210943.34310.arnd@arndb.de>
 <CAPXgP10FCrqdTg++46m4+xxM9tw1ZrKc8wz=JkKjCHJ0hQPtng@mail.gmail.com>
 <20111221121246.GB15309@opensource.wolfsonmicro.com>
 <CAPXgP10CGxfEJ4jK2MkKt0-nAWgiawDERyA1N4wHvMCJfE3oDg@mail.gmail.com>
Message-ID: <20111221141907.GA1777@richard-laptop>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Dec 21, 2011 at 01:49:07PM +0100, Kay Sievers wrote:
> On Wed, Dec 21, 2011 at 13:12, Mark Brown
> <broonie@opensource.wolfsonmicro.com> wrote:
> > On Wed, Dec 21, 2011 at 12:44:57PM +0100, Kay Sievers wrote:
> >
> >> We will convert all classes to buses over time time, and have a single
> >> type of device and a single type of subsystem.
> >
> > Are there any conversions that have been done already that I can look at
> > for reference?
> 
> The first step is the conversion from 'sys_device' to 'device', which is here:
>   http://git.kernel.org/?p=linux/kernel/git/kay/patches.git;a=tree
> 
> That should hit the tree soon, if all works according to plan. All
> sys_devices and sysdev classes will be gone for forever.
Even cpu node is device, I still need to find a way to get it.  I think it's
better have another patch to fix the regulator dt binding in cpu node. I'll
not include it in this patch series.

Richard
> 
> The 'class' to 'bus' work is simpler, because the logic in both of
> them is very similar and both use the same 'struct device' already.
> 
> We'll need to add some convenience APIs to bus, and add code to make
> sure the converted stuff has compat symlinks in /sys/class when
> needed. Then we can convert-over one 'struct class' to 'struct
> bus_type' after the other until 'struct class' can be deleted.
> 
> This work has not yet started, because we are busy with the sys_device
> stuff at the moment.
> 
> No new stuff should use 'struct class' or 'struct sys_device', they
> should all start right away with 'struct bus_type'.
> 
> Kay
