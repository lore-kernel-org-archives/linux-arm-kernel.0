From: sbkim73@samsung.com (Sangbeom Kim)
Date: Thu, 02 Jun 2011 09:11:39 +0900
Subject: [PATCH 4/5] ARM: S3C6410: Support 800MHz operation in cpufreq
In-Reply-To: <20110601104042.GA15387@opensource.wolfsonmicro.com>
References: <20110601094313.GA23122@opensource.wolfsonmicro.com>
	<1306921493-30911-1-git-send-email-broonie@opensource.wolfsonmicro.com>
	<1306921493-30911-4-git-send-email-broonie@opensource.wolfsonmicro.com>
	<037201cc2046$f5cc53b0$e164fb10$@com>
	<20110601104042.GA15387@opensource.wolfsonmicro.com>
Message-ID: <038c01cc20b9$a55a5120$f00ef360$@com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jun 1, 2011 at 7:41 PM, Mark Brown
> The fact that the chip is only on limited distribution isn't really an
> issue for supporting it in mainline - many CPUs currently supported in
> Linux, including some Samsung ones, are only available to certain
> customers.
As you said, limited distribution isn't issue,
Issue is that all s3c6410 can't support 800Mhz.
Even if some s3c6410 processor unable to support 800Mhz,
In some cases, It seems to work on 800Mhz.
But System suddenly can be dead after few days working.(system hang up)
So, If some developer want use 800Mhz, They should exactly know  that
their s3c6410 can support 800Mhz or not.
I just want to say this.
800Mhz s3c6410 can be distinguished by checking laser mark.

> Similarly, stable power supplies are a basic system design thing that
> we shouldn't be worrying about here.
Even if 6410 can support 800Mhz, If power is unstable, system can be dead.
It is not 6410 problem. It is board problem.
When system hang up happened, In the most cases, regulator give unstable
VDD_ARM
(Even if regulator register setting is right)
You can just say that I don't care about that.
But System hang up isn't simple problem.
I want developer to know that If They try to develop 800Mhz 6410,
They should consider many things like board design, 
selecting regulator, support 800Mhz etc.
So It is more desirable to add some comment for using 800Mhz
