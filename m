From: daniel.lezcano@linaro.org (Daniel Lezcano)
Date: Wed, 16 May 2018 01:00:14 +0200
Subject: [GIT PULL] arm64: defconfig: hisilicon config updates for v4.18
In-Reply-To: <20180515203755.esjnphfep5ep7wbe@localhost>
References: <5AF5A94A.4080308@hisilicon.com>
 <20180514201445.6sglddhalvclu36v@localhost>
 <20180515082811.GL29062@mai>
 <20180515203755.esjnphfep5ep7wbe@localhost>
Message-ID: <20180515230014.GS29062@mai>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, May 15, 2018 at 01:37:55PM -0700, Olof Johansson wrote:
> On Tue, May 15, 2018 at 10:28:11AM +0200, Daniel Lezcano wrote:
> > On Mon, May 14, 2018 at 01:14:45PM -0700, Olof Johansson wrote:
> > > Hi Wei,
> > > 
> > > On Fri, May 11, 2018 at 03:31:38PM +0100, Wei Xu wrote:
> > > > Hi Arnd, Hi Olof,
> > > > 
> > > > Please help to pull the following changes.
> > > > 
> > > > About the CLOCK_STUB and the MAILBOX consolidate patch,
> > > > Jassi and Stephen have acked it.
> > > > Could you let me know how to handle this kind case
> > > > if it is not OK to be in this pull?
> > > 
> > > I don't think there's any need to group the Kconfig changes with the defconfig
> > > updates here, is there?
> > 
> > I don't have the patches history, but likely this patch should come together with:
> > 
> > https://patchwork.kernel.org/patch/10399799/
> > https://patchwork.kernel.org/patch/10399801/
> > 
> > Otherwise the compilation options won't be consistent with what is enabled in
> > the DT.
> 
> As long as neither side regresses due to the changes, there should be no
> problem. Just because a DT node is added in the tree there's no need to
> configure the driver. Or am I missing some aspect of it here?

Actually, the DT node being added do not introduce regressions.

However it is expected by adding the clock stub and the mailbox to have the
cpufreq working which is not necessarily the case because the config may be
inconsistent, so the cpufreq may be working on some config if the user had the
options for the clock and the mailbox enabled but these options can disappear
and not come back because of this Kconfig inconsistencies.

>From my point of view, by adding those DT nodes, it makes sense to give a
consolidated Kconfig coming together and ensuring the drivers are enabled when
the node is parsed.

On the other side, the patch is simple enough to be split and submitted in
separated trees, hoping the maintainer Wu Xei and the branch users keep in mind
if the board does not boot or has inconsistent behavior they will have to
double check the options are enabled for the clock stub and the mailbox.

I don't have a strong opinion on this actually, whatever the decision is, I
will be fine with resubmitting the patch to the different trees, or keep it as
is and merge it through the hisi tree.

  -- Daniel

-- 

 <http://www.linaro.org/> Linaro.org ? Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog
