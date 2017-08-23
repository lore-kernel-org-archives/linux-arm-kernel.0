From: sudeep.holla@arm.com (Sudeep Holla)
Date: Wed, 23 Aug 2017 10:17:06 +0100
Subject: [PATCH] doc: coresight: correct usage for '/dev/cpu_dma_latency'
In-Reply-To: <1503472998-9009-1-git-send-email-leo.yan@linaro.org>
References: <1503472998-9009-1-git-send-email-leo.yan@linaro.org>
Message-ID: <c6d08eff-d92e-9cd2-5c33-1bf67711471c@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



On 23/08/17 08:23, Leo Yan wrote:
> In the coresight CPU debug document it suggests to use 'echo' command
> to set latency request to /dev/cpu_dma_latency so can disable all CPU
> idle states, but in fact this doesn't work.
> 
> This is because when the command 'echo' exits, it releases the device
> node's file descriptor and the kernel release function removes the QoS
> constraint; finally when the command 'echo' finished there have no
> constraint imposed on cpu_dma_latency.
> 
> This patch changes to use 'exec' to access '/dev/cpu_dma_latency', the
> command 'exec' can avoid the file descriptor to be closed so we can
> keep the constraint on cpu_dma_latency.
> 
> This patch also corrects the description when set latency = 0uS, in
> this case the idle state0 still can be selected by CPUIdle governor so
> this means on ARM platform the 'WFI' state is still enabled, but all
> other deeper states have been disabled so CPUs will not be powered off.
> 


IMO, we should just refer to cpuidle and PM QoS documents from here so
that any updates or changes in those documents are observed. Having a
copy of the text may result in it getting obsolete.

-- 
Regards,
Sudeep
