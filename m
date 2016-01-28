From: drjones@redhat.com (Andrew Jones)
Date: Thu, 28 Jan 2016 22:30:44 +0100
Subject: [PATCH v10 00/21] KVM: ARM64: Add guest PMU support
In-Reply-To: <1453866709-20324-1-git-send-email-zhaoshenglong@huawei.com>
References: <1453866709-20324-1-git-send-email-zhaoshenglong@huawei.com>
Message-ID: <20160128213044.GM16453@hawk.localdomain>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jan 27, 2016 at 11:51:28AM +0800, Shannon Zhao wrote:
> From: Shannon Zhao <shannon.zhao@linaro.org>
> 
> This patchset adds guest PMU support for KVM on ARM64. It takes
> trap-and-emulate approach. When guest wants to monitor one event, it
> will be trapped by KVM and KVM will call perf_event API to create a perf
> event and call relevant perf_event APIs to get the count value of event.
> 
> Use perf to test this patchset in guest. When using "perf list", it
> shows the list of the hardware events and hardware cache events perf
> supports. Then use "perf stat -e EVENT" to monitor some event. For
> example, use "perf stat -e cycles" to count cpu cycles and
> "perf stat -e cache-misses" to count cache misses.
>

Hi Shannon,

I just completed my first full review of the series. I'm sorry I didn't
have time to do a full review on an earlier version. I have a few comments,
but most of them are minor. If you'd like to add some r-b's from me, then
here are the patches I can offer them for

1-5,8,9,11-13,16-21

5,8,9,12 had some extra masking on input/outputs that I'm not sure is
necessary.

Thanks,
drew
