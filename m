From: broonie@opensource.wolfsonmicro.com (Mark Brown)
Date: Thu, 2 Jun 2011 09:28:31 +0100
Subject: [PATCH 4/5] ARM: S3C6410: Support 800MHz operation in cpufreq
In-Reply-To: <038c01cc20b9$a55a5120$f00ef360$@com>
References: <20110601094313.GA23122@opensource.wolfsonmicro.com>
	<1306921493-30911-1-git-send-email-broonie@opensource.wolfsonmicro.com>
	<1306921493-30911-4-git-send-email-broonie@opensource.wolfsonmicro.com>
	<037201cc2046$f5cc53b0$e164fb10$@com>
	<20110601104042.GA15387@opensource.wolfsonmicro.com>
	<038c01cc20b9$a55a5120$f00ef360$@com>
Message-ID: <20110602082830.GA3085@opensource.wolfsonmicro.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Jun 02, 2011 at 09:11:39AM +0900, Sangbeom Kim wrote:

> I just want to say this.
> 800Mhz s3c6410 can be distinguished by checking laser mark.

It's really unfortunate that there's no software visible method I'm
aware of :/

> > Similarly, stable power supplies are a basic system design thing that
> > we shouldn't be worrying about here.

> Even if 6410 can support 800Mhz, If power is unstable, system can be dead.
> It is not 6410 problem. It is board problem.
> When system hang up happened, In the most cases, regulator give unstable
> VDD_ARM

Yes, this is very much the case with any board design - the regulators
need to be able to both sustain the full rate current draw and rapidly
respond to changes in load and voltage in order to make a viable system.
In the case of voltage changes we've got some support in the regulator
API for ramp delays which should allow us to cope with regulators that
are slow to implement voltage changes but for transient response there's
really nothing doing except for good hardware design.

I'm not sure it's a particular concern for the 800MHz part above others
simply because it's such a universal issue.
