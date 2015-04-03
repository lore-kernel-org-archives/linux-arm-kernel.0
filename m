From: jason@lakedaemon.net (Jason Cooper)
Date: Fri, 3 Apr 2015 16:04:29 +0000
Subject: [PATCH 4/5] irqchip: armada-370-xp: Allow using wakeup source
In-Reply-To: <551EB403.9030607@free-electrons.com>
References: <1427724278-12379-1-git-send-email-gregory.clement@free-electrons.com>
 <1427724278-12379-5-git-send-email-gregory.clement@free-electrons.com>
 <20150402232316.GJ24598@io.lakedaemon.net>
 <551E3EA3.8010409@free-electrons.com>
 <20150403142922.GL24598@io.lakedaemon.net>
 <551EB403.9030607@free-electrons.com>
Message-ID: <20150403160429.GA7873@io.lakedaemon.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Apr 03, 2015 at 05:38:43PM +0200, Gregory CLEMENT wrote:
> On 03/04/2015 16:29, Jason Cooper wrote:
> > On Fri, Apr 03, 2015 at 09:17:55AM +0200, Gregory CLEMENT wrote:
> >> Hi Jason,
> >>
> >> On 03/04/2015 01:23, Jason Cooper wrote:
> >>> On Mon, Mar 30, 2015 at 04:04:37PM +0200, Gregory CLEMENT wrote:
> >>>> On the Armada 370/XP SoCs, in standby mode the SoC stay powered and it
> >>>> is possible to wake-up from any interrupt sources. This patch adds
> >>>> flag to the MPIC irqchip driver to let linux know this.
> >>>>
> >>>> Signed-off-by: Gregory CLEMENT <gregory.clement@free-electrons.com>
> >>>> ---
> >>>>  drivers/irqchip/irq-armada-370-xp.c | 1 +
> >>>>  1 file changed, 1 insertion(+)
> >>>
> >>> Applied to irqchip/mvebu
> >>
> >> Thanks!
> >>
> >> Do you agree to take also the patch 3?
> > 
> > hmmm...
> > 
> >> It modifies a file in mach-mvebu (board-v7.c) but it depends on a patch
> >> located in irqchip: "irqchip: gic: Add an entry point to set up irqchip flags"
> > 
> > Yeah, I saw that.  Do you forsee any merge conflicts with mvebu?  The reason I
> 
> There is only two patches which modify the same file, but they don't touch the
> same chunk. So the only impact would be the line numbers which could not be
> different. In order to be sure I've just tried to apply first this patch and then
> these 2 other ones: there was no problem at all.
> 
> > ask is that it looks like I'm going to be sending directly to Linus this
> > cycle.  I'd really prefer to hold off a cycle on that patch.  I'm not
> > 100% certain my second PR (stacked domain/DT break) is going to get
> > accepted.  Which is what this patch depends on.
> > 
> > thoughts?
> 
> This patch can wait if needed as this patch alone is not enough to to be able
> to use standby and I am not sure at all that I the other part of the series will
> be merged in 4.1.

Ok, let's hold off then.  btw - I just ran through Thomas' slides on DT
ABI/fantasy.  Very good work.  I hope to see the video some day.  :-)

thx,

Jason.
