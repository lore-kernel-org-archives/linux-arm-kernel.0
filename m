From: shawn.guo@linaro.org (Shawn Guo)
Date: Wed, 5 Sep 2012 11:51:10 +0800
Subject: RCU warning during UBI file system mount
In-Reply-To: <50462190.7090702@grid-net.com>
References: <5042EC5D.1010207@grid-net.com>
 <1346744796.12610.6.camel@sauron.fi.intel.com>
 <20120904144813.GC2593@linux.vnet.ibm.com>
 <50462190.7090702@grid-net.com>
Message-ID: <20120905035108.GV2362@S2101-09.ap.freescale.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Sep 04, 2012 at 08:43:12AM -0700, Subodh Nijsure wrote:
> MX28 is ARM device. I removed following from my config and these
> warnings went away.
> 
> CONFIG_CPU_IDLE=y
> CONFIG_CPU_IDLE_GOV_LADDER=y
> CONFIG_CPU_IDLE_GOV_MENU=y
> 
There is no cpuidle implemented on imx28.  I do not understand how
these options influence the result here.

> I have attached the kernel configuration file I used.
> 
> It doesn't affect specific hw I am working with as device is not
> required to enter idle mode.
> I am Cc-ing linux-arm folks,  in case someone on arm platform
> requires CPU idele &, RCU to work.
> 
I just ran a case with CONFIG_CPU_IDLE and RCU support and failed
to reproduce the warning.  Is this something specific to gpmi-nand
or we can see it with any other imx28 drivers/cases?  Sorry, I do
not have NAND flash set up on my imx28 board.

-- 
Regards,
Shawn
