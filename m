From: arnd@arndb.de (Arnd Bergmann)
Date: Sat, 19 Apr 2014 13:59:35 +0200
Subject: [PATCH v4 00/21] ARM: support for ICP DAS LP-8x4x (with dts)
In-Reply-To: <534FCA5D.1020606@zonque.org>
References: <1387309071-22382-1-git-send-email-ynvich@gmail.com>
 <1397736755.16539.15.camel@host5.omatika.ru> <534FCA5D.1020606@zonque.org>
Message-ID: <201404191359.36203.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thursday 17 April 2014, Daniel Mack wrote:
> On 04/17/2014 02:12 PM, Sergei Ianovich wrote:
> > On Thu, 2014-04-17 at 12:38 +0200, Daniel Mack wrote
> > I have all the
> > reasons to believe, that LP-8x4x support would already have be merged,
> > if I didn't try to use DT.
> 
> That might be, but that's not the point. We want progress here, and that
> means we occasionally have to get rid of legacy.

In most cases, I would strongly support that statement. However, for PXA
in particular, my opinion is that progress is not the highest priority
as I see no realistic hope of converting all the existing machines over
to use DT and change the platform to "multiplatform" support. Anything
more modern than PXA I hope we can eventually get at least done for
multiplatform, same for a few of the older and simpler platforms.

Then again, I'm certainly not stopping you from trying to use add
modern platforms to PXA.

One of the ideas I had earlier was to extend mach-mmp enough to
run any fully DT-enabled PXA machines and leave mach-pxa for the
old ATAGS support and stuff like the legacy DMA support.
However, I don't think we should try that as long as mach-mmp is
lacking some essential DT support, e.g. for the clocks that were
only partially converted to use the common clock framework.

> > if so
> > B. We need to thinks whether it's acceptable to kill support for video
> > capture.
> 
> We can't. As I said, for this particular driver, we can keep the old API
> around. We can even make it depend on !CONFIG_DMA_ENGINE, so if anyone
> actually wants to use it with DT-enabled boards, we finally have a user
> and things can be fixed up. Similar for other drivers we can't test
> ourselves.

Sounds good to me.

> > In short:
> > 
> > if (A && B)
> >   we drop old DMA
> > else
> >   we take my patch #7
> 
> If A works, there's no need to for patch #7, right? If A doesn't work,
> we have to check why and fix it.
> 
> Arnd, any oppinion on this?

No strong opinion, I wouldn't object patch #7 if there is a strong reason
to not use the dmaengine driver for PXA like I would object doing it for
MMP. Then again, I see that you and recently also Laurent are driving a
lot of good work on PXA, and if neither the arm-soc maintainers nor the
three maintainers listed for mach-pxa have a strong opinion, I'd rather
leave it up to your judgement.

	Arnd
