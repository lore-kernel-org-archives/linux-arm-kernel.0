From: josephl@nvidia.com (Joseph Lo)
Date: Wed, 16 Jan 2013 11:17:17 +0800
Subject: [PATCH V2 2/6] ARM: tegra20: cpuidle: add powered-down state
 for secondary CPU
In-Reply-To: <20130115113427.GC26424@e102568-lin.cambridge.arm.com>
References: <1354701715-24150-1-git-send-email-josephl@nvidia.com>
 <1354701715-24150-3-git-send-email-josephl@nvidia.com>
 <20121205105010.GA12999@e102568-lin.cambridge.arm.com>
 <1357888829.2034.39.camel@jlo-ubuntu-64.nvidia.com>
 <20130111122417.GE30538@e102568-lin.cambridge.arm.com>
 <1358218844.8513.30.camel@jlo-ubuntu-64.nvidia.com>
 <20130115113427.GC26424@e102568-lin.cambridge.arm.com>
Message-ID: <1358306237.8826.7.camel@jlo-ubuntu-64.nvidia.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, 2013-01-15 at 19:34 +0800, Lorenzo Pieralisi wrote:
> On Tue, Jan 15, 2013 at 03:00:44AM +0000, Joseph Lo wrote:
> > On Fri, 2013-01-11 at 20:24 +0800, Lorenzo Pieralisi wrote:
> > > On Fri, Jan 11, 2013 at 07:20:29AM +0000, Joseph Lo wrote:
> > > > On Wed, 2012-12-05 at 18:50 +0800, Lorenzo Pieralisi wrote:
> > > > > On Wed, Dec 05, 2012 at 10:01:49AM +0000, Joseph Lo wrote:
> > > > You did mention there is an ARM generic locking scheme for MMU/coherency
> > > > off case before. Do you mean the patch below?
> > > > 
> > > > https://patchwork.kernel.org/patch/1957911/
> > > > https://patchwork.kernel.org/patch/1957901/
> > > 
> > > Those are used for first-man election when multiple CPUs come out of
> > > idle at once.
> > > 
> > > You should have a look at the entire series and in particular:
> > > 
> > > https://patchwork.kernel.org/patch/1957891/
> > > https://patchwork.kernel.org/patch/1957951/
> > > 
> > > > I gave it a review today. Looks it can't fit our usage for CPU idle
> > > > powered-down mode on Tegra20.
> > > > 
> > > > The generic mechanism only can be used when CPUs in non coherent world.
> > > > But our usage needs the mechanism could be used in both coherent and non
> > > > coherent case. OK. The case is we need to sync the status about the CPU1
> > > > was ready to power down. In this case, the CPU0 is still in coherent
> > > > world but the CPU1 isn't. So we need the locking scheme could be still
> > > > safe in this situation.
> > > 
> > > I know, I implemented something of that sort for an A9 based development
> > > platform, that's why I pointed you to this new patchset.
> > > 
> > > Have a look at the series, it should do what you want.
> > > 
> > Hi Lorenzo,
> > 
> > May I upstream this stuff first? I can promise to you I will re-work a
> > common CPUs and cluster power sync wrappers (platform_power_ops) for all
> > Tegra series that based on the generic framework. Because we didn't have
> > this work in Tegra tree yet and we indeed need it for supporting cluster
> > power down and switching.
> > 
> > But it need lots of time for re-work, testing and verification. And I
> > have lots of patches that need the function of cpu suspend that be
> > introduced in this patch series to support platform suspend for Tegra.
> > 
> > So I am asking the permission here for upstream this series first and I
> > will continue the job to come out a common CPUs and cluster power sync
> > wrappers for Tegra that we indeed need it to support cluster power down
> > and switching.
> 
> I understand that and you should not ask me permission :-) since I am
> not a maintainer. I just wanted to save you some effort, you will end
> up rewriting the whole thing anyway IMHO and I think the power API would
> have saved you time if it were there before.
> 
I think we are always taking care the comments from the community. And
it's really worth for us to reconsider the code design and re-use the
common framework to reduce the effort.
> 
> If you need help to integrate the power API please do ask questions.
> 
Thanks again.

Joseph
