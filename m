From: shawn.guo@linaro.org (Shawn Guo)
Date: Sun, 6 Apr 2014 20:19:46 +0800
Subject: L2 cache suspend/resume
In-Reply-To: <20140406114652.GQ7528@n2100.arm.linux.org.uk>
References: <20140405112700.GJ7528@n2100.arm.linux.org.uk>
 <20140406114033.GC24260@dragon>
 <20140406114652.GQ7528@n2100.arm.linux.org.uk>
Message-ID: <20140406121944.GE24260@dragon>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, Apr 06, 2014 at 12:46:52PM +0100, Russell King - ARM Linux wrote:
> > For imx, the L2 power and therefore the memory array is retained in
> > suspend.  We do not want to call outer_disable() to have these data
> > flushed, and need to restore L2 controller before MMU is enabled.
> 
> Okay, any objection then to separating out the L2 resume code into an
> early L2 resume helper in arch/arm/mm ?

Move platform code into core is always a nice thing for platform
maintainers, so no objection from me :)

Shawn
