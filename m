From: lorenzo.pieralisi@arm.com (Lorenzo Pieralisi)
Date: Mon, 29 Sep 2014 12:08:04 +0100
Subject: [PATCH v8 6/8] drivers: cpuidle: CPU idle ARM64 driver
In-Reply-To: <5415C968.90303@gmail.com>
References: <1409585324-3678-1-git-send-email-lorenzo.pieralisi@arm.com>
 <1409585324-3678-7-git-send-email-lorenzo.pieralisi@arm.com>
 <20140903173740.GJ1824@e102568-lin.cambridge.arm.com>
 <20140904160320.GB22354@arm.com>
 <20140904172909.GA14822@e102568-lin.cambridge.arm.com>
 <20140905092120.GG13515@arm.com>
 <20140905153457.GA26306@e102568-lin.cambridge.arm.com>
 <54115D16.30206@linaro.org>
 <20140911085727.GA25773@e102568-lin.cambridge.arm.com>
 <5415C968.90303@gmail.com>
Message-ID: <20140929110804.GC2165@e102568-lin.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, Sep 14, 2014 at 05:59:20PM +0100, Tomasz Figa wrote:

[...]

> About the patch 8 alone, somebody would have to test it. Maybe Bart or
> Krzysztof could find some time to look at this? Other than that, I'm not
> quite sure about entry latency you specified. It would look like
> entering the state takes longer time than leaving, which I believe is
> not the case. However I can't find any place in the code which would use
> entry latency, so it might not be that important for now.

I added that entry latency value because I thought that when entering that
idle state the CPU had to flush the outercache, which I do not think that's
what's really happening on Exynos.

Since Bart's patch to define cpu nodes in DT is making it to the
mainline, this leaves us time to find out what that entry-latency-us value
should be and patch the dts accordingly (Exynos CPUidle DT changes are
not making it for this cycle, so we have time to update the patch
accordingly).

entry-latency-us is used to compute CPUidle exit_latency so it has to be
correct, and I rely on Samsung guys to provide me with that value, or
I will ask them to set it properly for me.

Thanks,
Lorenzo
