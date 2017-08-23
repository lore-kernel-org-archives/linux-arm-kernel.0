From: leo.yan@linaro.org (Leo Yan)
Date: Wed, 23 Aug 2017 19:08:10 +0800
Subject: [PATCH] doc: coresight: correct usage for '/dev/cpu_dma_latency'
In-Reply-To: <c6d08eff-d92e-9cd2-5c33-1bf67711471c@arm.com>
References: <1503472998-9009-1-git-send-email-leo.yan@linaro.org>
 <c6d08eff-d92e-9cd2-5c33-1bf67711471c@arm.com>
Message-ID: <20170823110810.GA28579@leoy-linaro>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Sudeep,

On Wed, Aug 23, 2017 at 10:17:06AM +0100, Sudeep Holla wrote:
> 
> On 23/08/17 08:23, Leo Yan wrote:
> > In the coresight CPU debug document it suggests to use 'echo' command
> > to set latency request to /dev/cpu_dma_latency so can disable all CPU
> > idle states, but in fact this doesn't work.
> > 
> > This is because when the command 'echo' exits, it releases the device
> > node's file descriptor and the kernel release function removes the QoS
> > constraint; finally when the command 'echo' finished there have no
> > constraint imposed on cpu_dma_latency.
> > 
> > This patch changes to use 'exec' to access '/dev/cpu_dma_latency', the
> > command 'exec' can avoid the file descriptor to be closed so we can
> > keep the constraint on cpu_dma_latency.
> > 
> > This patch also corrects the description when set latency = 0uS, in
> > this case the idle state0 still can be selected by CPUIdle governor so
> > this means on ARM platform the 'WFI' state is still enabled, but all
> > other deeper states have been disabled so CPUs will not be powered off.
> > 
> 
> 
> IMO, we should just refer to cpuidle and PM QoS documents from here so
> that any updates or changes in those documents are observed. Having a
> copy of the text may result in it getting obsolete.

Agree, we should point to below docs:
Documentation/power/pm_qos_interface.txt, section 'From user mode';
Documentation/cpuidle/sysfs.txt;

Thanks for good suggestion.

> -- 
> Regards,
> Sudeep
