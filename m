From: broonie@kernel.org (Mark Brown)
Date: Wed, 30 Sep 2015 20:18:18 +0100
Subject: [PATCH] arm64: dts: add all hi6220 uart nodes
In-Reply-To: <CANMBJr7yY1PJChnFSRknqfOLORuWZSEONV+e=M=9heX3i-ADKA@mail.gmail.com>
References: <1443558552-5734-1-git-send-email-tyler.baker@linaro.org>
 <1459065.BtzC7pyUYF@wuerfel> <20150930173145.GG15635@sirena.org.uk>
 <CANMBJr7yY1PJChnFSRknqfOLORuWZSEONV+e=M=9heX3i-ADKA@mail.gmail.com>
Message-ID: <20150930191818.GZ15635@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Sep 30, 2015 at 11:12:58AM -0700, Tyler Baker wrote:
> On 30 September 2015 at 10:31, Mark Brown <broonie@kernel.org> wrote:

> + Peter as he has been submitting u-boot patches recently for the HiKey.

> Obviously, both UEFI and u-boot can be configured to use either UART,
> and at the moment u-boot defaults to using the on board UART. Whereas
> UEFI is using UART1 on the LS connector. I'm fine with switching the
> console default to use the UART1 on the LS connector as long as there
> is agreement to do so.

Given that UEFI is switching and the requirement for soldering to get to
the on board UART it does seem to make sense, though it will create some
pain for current users.

> > While we're at it there was a recent talk which mentioned a fairly large
> > amount of functionality that's apparently already "upstream" for this
> > device but not included in the DT, assuming that means that driver
> > support is there it would be good to add the corresponding DT.

> Indeed, I think this comment is targeted to toward the d410c though as
> there are drivers for eMMC, and microsd drivers upstream but no DT
> bindings. I do not believe currently this is the case for HiKey.

My understanding is that it applies to both with slightly different
driver sets, the slides aren't online yet (!) but if you look at 10:52
or so in the video we should have SD/eMMC on HiKey in v4.1 with thermal
and CPUfreq added in v4.2.  It also looks like there's just some DT
additions needed to enable reset, cpuidle and CPU hotplug using generic
code (mainly the constants for PSCI I expect).
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 473 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20150930/43e93f7a/attachment.sig>
