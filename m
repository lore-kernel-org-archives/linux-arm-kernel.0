From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Sat, 25 Aug 2012 08:52:21 +0100
Subject: Shutdown problem in SMP system happened on Tegra20
In-Reply-To: <20120825073624.GI31998@S2101-09.ap.freescale.net>
References: <A7051F87A141B744BCAF487D48E5B3BDF5BA982848@HKMAIL02.nvidia.com>
 <20120824182133.GB18957@n2100.arm.linux.org.uk>
 <20120825073624.GI31998@S2101-09.ap.freescale.net>
Message-ID: <20120825075221.GH18957@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, Aug 25, 2012 at 03:36:27PM +0800, Shawn Guo wrote:
> On Fri, Aug 24, 2012 at 07:21:33PM +0100, Russell King - ARM Linux wrote:
> > Why not just ensure that CONFIG_PM_SLEEP_SMP is enabled if your platform
> > requires that the lowest CPU number be the CPU dealing with reboot?
> 
> I have CONFIG_PM_SLEEP_SMP enabled for imx6q, but still see the imx6q
> restart hook running on cpu1 than cpu0.  It seems that
> disable_nonboot_cpus is only called in kernel_power_off but never
> kernel_restart.  We should probably patch kernel_restart or
> machine_restart to have disable_nonboot_cpus called? 

Remember that this path gets called from IRQ context which makes calling
functions which sleep very dodgy.
