From: jamesjj.liao@mediatek.com (James Liao)
Date: Wed, 15 Jul 2015 17:51:03 +0800
Subject: [PATCH 0/2] Add MT8173 MMPLL change rate support
In-Reply-To: <20150714221319.GQ30412@codeaurora.org>
References: <1436344666-25645-1-git-send-email-jamesjj.liao@mediatek.com>
 <559DC3EF.90401@codeaurora.org> <1436507086.3526.117.camel@mtksdaap41>
 <20150714221319.GQ30412@codeaurora.org>
Message-ID: <1436953863.9416.23.camel@mtksdaap41>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Stephen,

On Tue, 2015-07-14 at 15:13 -0700, Stephen Boyd wrote:
> On 07/10, James Liao wrote:
> > On Wed, 2015-07-08 at 17:44 -0700, Stephen Boyd wrote:
> > > On 07/08/2015 01:37 AM, James Liao wrote:
> > > > MT8173 MMPLL frequency settings are different from common PLLs.
> > > > It needs different post divider settings for some ranges of frequency.
> > > > This patch add support for MT8173 MMPLL frequency setting, includes:
> > > >
> > > > 1. Add div-rate table for PLLs.
> > > > 2. Increase the max ost divider setting from 3 (/8) to 4 (/16).
> > > > 3. Write postdiv and pcw settings at the same time.
> > > >
> > > > James Liao (2):
> > > >   clk: mediatek: Fix PLL registers setting flow
> > > >   clk: mediatek: Add MT8173 MMPLL change rate support
> > > >
> > > 
> > > Are these fixing regressions in 4.2-rc1? I don't see any "Fixes:" tag so
> > > it's not clear and makes me want to defer these until v4.3. Furthermore,
> > > the subject starts with "Add" so it sounds like a new feature.
> > 
> > This patchset is based on 4.1-rc1 but it had been tested on 4.2-rc1.
> > I'll send a new patch which based on 4.2-rc1.
> > 
> > This patchset contains some general PLL fixes and MMPLL set rate
> > support. We can say the last one is also a fix because changing some
> > specific rate on MMPLL may fail in current implementation.
> > 
> > 
> 
> I'm seriously confused. The files these patches touch were never
> in v4.1, so they can't be based on v4.1-rc1 unless you're saying
> they were on top of clk-next when it was based on 4.1-rc1?
> 

This is an old patch which based on 4.1-rc1 and basic clocks support
[1].

Please refer to the newer patch [2] and ignore this one.


[1] https://lkml.org/lkml/2015/4/23/92
[2] https://lkml.org/lkml/2015/7/10/198


Best regards,

James
