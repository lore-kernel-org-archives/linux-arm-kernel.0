From: mark.rutland@arm.com (Mark Rutland)
Date: Mon, 20 Feb 2017 11:09:43 +0000
Subject: [PATCH v4 08/11] drivers: perf: hisi: use poll method to avoid
 L3C counter overflow
In-Reply-To: <1487530263-42643-1-git-send-email-anurup.m@huawei.com>
References: <1487530263-42643-1-git-send-email-anurup.m@huawei.com>
Message-ID: <20170220110942.GF9003@leverpostej>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, Feb 19, 2017 at 01:51:03PM -0500, Anurup M wrote:
> The L3 cache PMU use N-N SPI interrupt which has no support
> in kernel mainline.

Could you elaborate on what you mean by this?

I don't understand what is meant here. How exactly are the interrupts
wired up in HW, and what exactly is not supported by Linux?

> So use hrtimer to poll and update event
> counter to avoid overflow condition for L3 cache PMU.
> A interval of 10 seconds is used for the hrtimer.
> The time interval can be configured in the sysfs.

I'm not too keen on giving userspace the ability to control this, since
it gives an awful lot of rope for userspace to tie around itself.

Thanks,
Mark.
