From: leo.yan@linaro.org (Leo Yan)
Date: Wed, 6 May 2015 11:51:20 +0800
Subject: [PATCH v4 5/5] arm64: dts: Add dts files for Hisilicon Hi6220 SoC
In-Reply-To: <5549877C.10408@huawei.com>
References: <1430827599-11560-1-git-send-email-bintian.wang@huawei.com>
 <1430827599-11560-6-git-send-email-bintian.wang@huawei.com>
 <20150505171349.GA30215@leverpostej> <5549877C.10408@huawei.com>
Message-ID: <20150506035120.GA20852@leoy-linaro>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, May 06, 2015 at 11:16:12AM +0800, Bintian Wang wrote:
> On 2015/5/6 1:13, Mark Rutland wrote:
> >[...]
> >
> >>+	psci {
> >>+		compatible = "arm,psci-0.2";
> >>+		method = "smc";
> >>+	};
> >
> >Are all the PSCI 0.2 mandatory features implemented?
>
> The system off/suspend is under development, and system off will
> be released in next months, and system suspend may be released in the
> following two months.

Yes; now for mandatory features, except SYSTEM_OFF others have supported.
for PSCI 0.2, SYSTEM_SUSPEND even is not supported, right?

> So can I keep "arm,psci-0.2" here?
> 
> >Can CPU0 be hot unplugged?
> Yes, CPU0~CPU7 all can be hot unplugged.

Just clarify: now use s/w method to emulate CPU and cluster's low
power state; all cores can be hotplugged [1].

[1] https://github.com/96boards/arm-trusted-firmware;

Thanks,
Leo Yan
