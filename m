From: leo.yan@linaro.org (Leo Yan)
Date: Wed, 6 May 2015 19:17:55 +0800
Subject: [PATCH v4 5/5] arm64: dts: Add dts files for Hisilicon Hi6220 SoC
In-Reply-To: <20150506092056.GA31001@leverpostej>
References: <1430827599-11560-1-git-send-email-bintian.wang@huawei.com>
 <1430827599-11560-6-git-send-email-bintian.wang@huawei.com>
 <20150505171349.GA30215@leverpostej> <5549877C.10408@huawei.com>
 <20150506035120.GA20852@leoy-linaro>
 <20150506092056.GA31001@leverpostej>
Message-ID: <20150506111755.GA5590@leoy-linaro>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

hi Mark,

Thanks for detailed reviewing, pls see below inline comments.

On Wed, May 06, 2015 at 10:20:56AM +0100, Mark Rutland wrote:
> On Wed, May 06, 2015 at 04:51:20AM +0100, Leo Yan wrote:
> > On Wed, May 06, 2015 at 11:16:12AM +0800, Bintian Wang wrote:
> > > On 2015/5/6 1:13, Mark Rutland wrote:
> > > >[...]
> > > >
> > > >>+	psci {
> > > >>+		compatible = "arm,psci-0.2";
> > > >>+		method = "smc";
> > > >>+	};
> > > >
> > > >Are all the PSCI 0.2 mandatory features implemented?
> > >
> > > The system off/suspend is under development, and system off will
> > > be released in next months, and system suspend may be released in the
> > > following two months.
> > 
> > Yes; now for mandatory features, except SYSTEM_OFF others have supported.
> 
> Ok. Do you mean in the next month, or in a number of months?

We will finish it in May; the mainly work is to hook this API w/t PMIC
to power down system.

> > for PSCI 0.2, SYSTEM_SUSPEND even is not supported, right?
> 
> SYSTEM_SUSPEND was introduced in PSCI 1.0, and is optional.
> 
> So long as PSCI_VERSION reports 0.2 or PSCI_FEATURES reports
> NOT_SUPPORTED for SYSTEM_SUSPEND, it's ok to not implement.
> 
> I guess PSCI_VERSION reports PSCI 0.2?

This is depend on ARM trusted firmware's implementation, now we are
using ATFv1.1, so it will declare to support PSCI 1.0; pls see below
boot log:

psci: probing for conduit method from DT.
psci: PSCIv1.0 detected in firmware.
psci: Using standard PSCI v0.2 function IDs

> > > So can I keep "arm,psci-0.2" here?
> > > 
> > > >Can CPU0 be hot unplugged?
> > > Yes, CPU0~CPU7 all can be hot unplugged.
> > 
> > Just clarify: now use s/w method to emulate CPU and cluster's low
> > power state; all cores can be hotplugged [1].
> 
> So long as CPUs brought online are reset appropriately, and "offline"
> CPUs can't bring down the system somehow, that should be fine. For now
> the important part is the interface.

Thanks for confirmation.

Thanks,
Leo Yan
