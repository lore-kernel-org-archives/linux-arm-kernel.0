From: amit.kucheria@linaro.org (Amit Kucheria)
Date: Tue, 20 Sep 2011 11:03:20 +0300
Subject: [PATCH v2 0/3] ARM: imx: Add cpuidle for imx platforms
In-Reply-To: <20110920071633.GR31404@pengutronix.de>
References: <1316194070-21889-1-git-send-email-rob.lee@linaro.org>
	<20110920071633.GR31404@pengutronix.de>
Message-ID: <20110920080320.GA2528@matterhorn1>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 11 Sep 20, Sascha Hauer wrote:
> Hi Robert,
> 
> On Fri, Sep 16, 2011 at 12:27:47PM -0500, Robert Lee wrote:
> > This patch series adds a common imx cpuidle driver, some common 
> > mach-mx5 level cpuidle functionality, and an i.MX51 instance of
> > using this driver.
> > 
> > The patch series is based on v3.1-rc2.
> > 
> > Changes since v1:
> > * To address all the problems found during review of v1, a complete
> > re-write was needed.
> 
> Much better than the last version, thanks.
> 
> > 
> > Robert Lee (3):
> >   ARM: imx: Add imx cpuidle driver
> >   ARM: imx: Add cpuidle for mach-mx5
> >   ARM: imx: Add cpuidle for i.MX51
> > 
> >  arch/arm/mach-mx5/Makefile               |    3 +-
> >  arch/arm/mach-mx5/cpu_op-mx51.c          |   35 +++++++-
> 
> Your additions to this file...
> 
> >  arch/arm/mach-mx5/cpu_op-mx51.h          |    1 +
> >  arch/arm/mach-mx5/mm.c                   |    4 +
> >  arch/arm/mach-mx5/system.c               |   35 +++++++
> 
> And this one should go to arch/arm/mach-mx5/cpuidle.c, then we have
> all i.MX5 specific cpuidle stuff together without ifdeffing the code.
> I assume that cpuidle support for i.MX53 will look identically, right?

Yes, let's not separate only for i.MX51. i.MX53 and even i.MX6 might look
similar. They can always tune the exit latency criteria if needed.
