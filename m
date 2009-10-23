From: davidb@quicinc.com (David Brown)
Date: Fri, 23 Oct 2009 11:43:37 -0700
Subject: [PATCH] Use Normal uncached memory rather than Strongly
	Ordered on ARMv6+
In-Reply-To: <1256316861.6564.154.camel@pc1117.cambridge.arm.com>
References: <20091023094121.21605.39568.stgit@pc1117.cambridge.arm.com>
	<20091023100639.GA19437@n2100.arm.linux.org.uk>
	<1256293374.6564.27.camel@pc1117.cambridge.arm.com>
	<20091023103420.GC19437@n2100.arm.linux.org.uk>
	<1256295591.6564.42.camel@pc1117.cambridge.arm.com>
	<20091023113001.GA22853@n2100.arm.linux.org.uk>
	<1256299512.6564.74.camel@pc1117.cambridge.arm.com>
	<20091023123600.GB22853@n2100.arm.linux.org.uk>
	<1256316861.6564.154.camel@pc1117.cambridge.arm.com>
Message-ID: <20091023184336.GA31494@huya.quicinc.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Oct 23, 2009 at 09:54:21AM -0700, Catalin Marinas wrote:

> But if we have arch_is_coherent() enabled (possibly with hardware
> support like ARM's ACP), we need the drivers to have barriers anyway
> since we would use normal cached memory (and ordering isn't guaranteed).
> Of course, one has to go through the drivers used with a platform and
> check them but we already have a precedent.

Our Scorpion target definitely needs barriers in the drivers.
There aren't any devices available externally, yet, but we can
test things internally.

David
