From: lost.distance@yahoo.com (Paul Parsons)
Date: Thu, 15 Mar 2012 16:55:26 +0000 (GMT)
Subject: [GIT PULL][for v3.4] pull request from board-specific branch in
 arch-pxa
In-Reply-To: <201203151604.58969.arnd@arndb.de>
Message-ID: <1331830526.23927.YahooMailClassic@web29014.mail.ird.yahoo.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

--- On Thu, 15/3/12, Arnd Bergmann <arnd@arndb.de> wrote:
> On Wednesday 14 March 2012, Haojian
> Zhuang wrote:
> > First, please help to revert one commit
> 43de6a7dda6e9a7345e2 on
> > arnd/pxa/board branch of arm-soc.git first. Since this
> commit is
> > duplicated, and it's already merged into v3.3-rc7. I'm
> sorry on
> > inconvenience.
> > 
> > commit 43de6a7dda6e9a7345e218e688f2092f991126f0
> > Author: Haojian Zhuang <haojian.zhuang@marvell.com>
> > Date:???Tue Feb 28 10:57:48 2012 +0800
> > 
> >? ???ARM: pxa: add dummy clock for
> pxa25x and pxa27x
> > 
> 
> I need clarification on this:
> 
> I can see the clock was added in 389eda15e "ARM: pxa: add
> clk support in
> gpio driver" as well as 7557c175f6 "ARM: pxa: add dummy
> clock for sa1100-rtc",
> but removed in a55b5ada "Revert "ARM: pxa: add dummy clock
> for sa1100-rtc""
> and then added again in bbdc818b2 "ARM: pxa: add dummy clock
> for pxa25x
> and pxa27x". I want to make sure I'm not making the mess any
> bigger than
> it already is. So you want the dummy clocks for pxa25x and
> pxa27x removed
> again, never to come back, right?

The dummy clocks for pxa25x and pxa27x need to be present. If the dummy
clock for pxa27x is not present, my hx4700 hangs on boot.

Consequently linux-3.3-rc7 is correct.

Paul
