From: broonie@kernel.org (Mark Brown)
Date: Thu, 1 Oct 2015 11:21:36 +0100
Subject: [PATCH] arm64: dts: add all hi6220 uart nodes
In-Reply-To: <20151001031552.GC15675@leoy-linaro>
References: <1443558552-5734-1-git-send-email-tyler.baker@linaro.org>
 <1459065.BtzC7pyUYF@wuerfel> <20150930173145.GG15635@sirena.org.uk>
 <CANMBJr7yY1PJChnFSRknqfOLORuWZSEONV+e=M=9heX3i-ADKA@mail.gmail.com>
 <20150930191818.GZ15635@sirena.org.uk>
 <CANMBJr6aU4wPO5HqP-Oh-ND7_DZXSH30ykNHyvDtUp3nQFG6sA@mail.gmail.com>
 <20151001031552.GC15675@leoy-linaro>
Message-ID: <20151001102136.GC12635@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Oct 01, 2015 at 11:15:52AM +0800, Leo Yan wrote:
> On Wed, Sep 30, 2015 at 04:54:51PM -0700, Tyler Baker wrote:
> > On 30 September 2015 at 12:18, Mark Brown <broonie@kernel.org> wrote:

> > > My understanding is that it applies to both with slightly different
> > > driver sets, the slides aren't online yet (!) but if you look at 10:52
> > > or so in the video we should have SD/eMMC on HiKey in v4.1 with thermal
> > > and CPUfreq added in v4.2.  It also looks like there's just some DT
> > > additions needed to enable reset, cpuidle and CPU hotplug using generic
> > > code (mainly the constants for PSCI I expect).

> > I just skimmed the video and I see your point. I'll need to
> > investigate a bit but I'm up for sending some follow up patches to get
> > these drivers functioning. First lets get the UART working :)

> If you think it's necessary, i could send out patches to enable cpuidle
> firstly (actually now PSCI has been enabled yet); for cpufreq and
> thermal features, need wait until mailbox driver has been merged.

It seems sensible to get the DT bits for functionality that is already
supported on the driver side upstream, that way we get the maximum
functionality available as soon as possible and even if other bits get
problems in review users can take advantage of things that are OK.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 473 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20151001/e47c3524/attachment.sig>
