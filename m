From: m.szyprowski@samsung.com (Marek Szyprowski)
Date: Fri, 17 Sep 2010 13:45:36 +0200
Subject: [PATCH] regulator: Add support samsung power domain
In-Reply-To: <20100917113050.GA4322@rakim.wolfsonmicro.main>
References: <1284717532-9992-1-git-send-email-kgene.kim@samsung.com>
	<20100917113050.GA4322@rakim.wolfsonmicro.main>
Message-ID: <007b01cb565d$db4376d0$91ca6470$%szyprowski@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello,

On Friday, September 17, 2010 1:31 PM Mark Brown wrote:

> Another option to consider here is using runtime PM - other platforms
> seem to be going down that route, and are using it to also factor clock
> management for the IP blocks out (so that the block's clocks get enabled
> and disabled automatically when the block is active without needing any
> code in the driver).

The approach with merging power domains with clocks have some disadvantages.
In some cases the clock gating and power gating should be distinguished.
Just assume an IP like a video codec. It has it's own internal state machine.
It gets reset when the ip is power gated, but it is preserved during clock
gating. The driver might want to do a clock gating when it is waiting for a
new frame to decode, but should do power gating only when the device has
been closed. Having a set of fake clocks just for power gating imho doesn't
look good.

Best regards
--
Marek Szyprowski
Samsung Poland R&D Center
