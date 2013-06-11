From: nicolas.pitre@linaro.org (Nicolas Pitre)
Date: Tue, 11 Jun 2013 14:42:30 -0400 (EDT)
Subject: [PATCH 0/2] MCPM backend for Virtual Express TC2
In-Reply-To: <1370940110.3393.2.camel@linaro1.home>
References: <1370587152-4630-1-git-send-email-nicolas.pitre@linaro.org>
 <1370940110.3393.2.camel@linaro1.home>
Message-ID: <alpine.LFD.2.03.1306111407250.18597@syhkavp.arg>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, 11 Jun 2013, Jon Medhurst (Tixy) wrote:

> On Fri, 2013-06-07 at 02:39 -0400, Nicolas Pitre wrote:
> > This is the MCPM backend enabling SMP secondary boot and CPU hotplug
> > on the VExpress TC2 big.LITTLE platform.  The method to allow CPU suspend
> > is also implemented.
> 
> Are we leaving out for now Lorenzo's patch "ARM: TC2: reset CPUs
> spuriously woken up on cluster power up"?

I don't see spurious wake-ups with only hotplug operations.

So we'll have to reconsider if that patch is still needed once we merge
the cpuidle driver.  It certainly won't go into mainline in its current 
form in any case.

I do hope it is not required though -- that should be the job of the 
firmware.


Nicolas
