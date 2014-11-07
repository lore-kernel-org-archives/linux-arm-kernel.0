From: acourbot@nvidia.com (Alexandre Courbot)
Date: Fri, 7 Nov 2014 18:07:24 +0900
Subject: [PATCH 0/3] Add support for Tegra Activity Monitor
In-Reply-To: <1414594232-15684-1-git-send-email-tomeu.vizoso@collabora.com>
References: <1414594232-15684-1-git-send-email-tomeu.vizoso@collabora.com>
Message-ID: <545C8BCC.3090908@nvidia.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 10/29/2014 11:50 PM, Tomeu Vizoso wrote:
> Hello,
>
> these patches implement support for setting the rate of the EMC clock based on
> stats collected from the ACTMON, a piece of hw in the Tegra124 that counts
> memory accesses (among others).
>
> It depends on the following in-flight patches:
>
> * MC driver: http://thread.gmane.org/gmane.linux.ports.tegra/19623
> * EMC driver: http://thread.gmane.org/gmane.linux.ports.arm.kernel/365125
> * CPUFreq driver: http://thread.gmane.org/gmane.linux.kernel/1812962
>
> I have pushed a branch here for testing:

I am not too familiar with DVFS, but after going through this series it 
really seems to me that this could use devfreq. In its current form this 
driver mixes control and policy and lacks flexibility, preventing e.g. 
to switch to a performance or power-saving profile. Could you study the 
feasibility of using devfreq for this?

I also wonder if this driver could not be made more flexible generally 
speaking - right now it is hardcoded that you can only control EMC 
frequency with it. I can imagine that we could want to control several 
clocks using the same counter information, and that e.g. a notifier 
block might help with that. But let's keep that for later - whether to 
use devfreq or not seems to be the most important question for now.
