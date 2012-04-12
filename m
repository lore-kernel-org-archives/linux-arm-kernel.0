From: shawn.guo@linaro.org (Shawn Guo)
Date: Thu, 12 Apr 2012 21:11:59 +0800
Subject: [PATCH 00/13] common clk framework misc fixes
In-Reply-To: <201204121114.38825.arnd.bergmann@linaro.org>
References: <1334192572-12499-1-git-send-email-mturquette@linaro.org>
 <201204121114.38825.arnd.bergmann@linaro.org>
Message-ID: <20120412131155.GI2445@S2101-09.ap.freescale.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Apr 12, 2012 at 11:14:38AM +0000, Arnd Bergmann wrote:
> On Thursday 12 April 2012, Mike Turquette wrote:
> > This series collects many of the fixes posted for the recently merged
> > common clock framework as well as some general clean-up.  Most of the
> > code classifies as a clean-up moreso than a bug fix; hopefully this is
> > not a problem since the common clk framework is new code pulled for 3.4.
> > 
> > Patches are based on v3.4-rc2 and can be pulled from:
> > git://git.linaro.org/people/mturquette/linux.git v3.4-rc2-clk-fixes
> > 
> > Please let me know I missed any critical fixes that were posted to the
> > list already.
> > 
> > Arnd & Olof, if there are no objections to these changes can this get
> > pulled through the arm-soc tree?
> 
> I think pulling it in through the arm-soc tree is still ok, but it's
> borderline because of the size and patch 13 is probably too big,
> in addition to the comments that were made there.
> 
> Let's pull patches 1 through 12 in to a separate series that we don't
> mix with the other bug fixes. Mike, please send a pull request with the
> Acks added in.
> 
I just appended 3 more patches to the series.  Patches #1 and #2 change
the interface between clk core and clk drivers - clk_ops a little bit,
(this is something Mike acked a couple of weeks ago, but missed from
the series) and patch #3 is a critical bug fix.  So unless we can send
the whole series for -rc, I'd vote we send none of them for -rc.
Instead, we can stabilize it somewhere and ask all the clk driver
porting base on that.

Sending part of the cleanup/fixup and leaving the other that could
require changes on clk drivers out is a bad idea to me.

-- 
Regards,
Shawn
