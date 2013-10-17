From: simon.guinot@sequanux.org (Simon Guinot)
Date: Thu, 17 Oct 2013 09:50:05 +0200
Subject: [PATCH v2] clk: armada-370: fix tclk frequencies
In-Reply-To: <525BBF75.5010305@free-electrons.com>
References: <1380794702-6191-1-git-send-email-simon.guinot@sequanux.org>
 <20131003122307.GV31178@titan.lakedaemon.net>
 <20131009073633.GH1356@kw.sim.vm.gnt>
 <20131014085323.GL1356@kw.sim.vm.gnt>
 <525BBF75.5010305@free-electrons.com>
Message-ID: <20131017075005.GA23849@kw.sim.vm.gnt>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Oct 14, 2013 at 11:55:01AM +0200, Gregory CLEMENT wrote:
> On 14/10/2013 10:53, Simon Guinot wrote:
> > On Wed, Oct 09, 2013 at 09:36:33AM +0200, Simon Guinot wrote:
> >> On Thu, Oct 03, 2013 at 08:23:07AM -0400, Jason Cooper wrote:
> >>> Simon,
> >>>
> >>> On Thu, Oct 03, 2013 at 12:05:02PM +0200, Simon Guinot wrote:
> >>>> This patch fixes the tclk frequency array for the Armada-370 SoC.
> >>>> This bug has been introduced by commit 6b72333d
> >>>> ("clk: mvebu: add Armada 370 SoC-centric clock init").
> >>>>
> >>>> A wrong tclk frequency affects the following drivers: mvsdio, mvneta,
> >>>> i2c-mv64xxx and mvebu-devbus. This list may be incomplete.
> >>>>
> >>>> About the mvneta Ethernet driver, note that the tclk frequency is used
> >>>> to compute the Rx time coalescence. Then, this bug harms the coalescence
> >>>> configuration and also degrades the networking performances with the
> >>>> default values.
> >>>>
> >>>> Signed-off-by: Simon Guinot <simon.guinot@sequanux.org>
> >>>> Cc: Andrew Lunn <andrew@lunn.ch>
> >>>> Cc: Gregory CLEMENT <gregory.clement@free-electrons.com>
> >>>> Cc: Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>
> >>>> Cc: Jason Cooper <jason@lakedaemon.net>
> >>>> Cc: stable at vger.kernel.org
> >>>> ---
> >>>>  drivers/clk/mvebu/armada-370.c |    4 ++--
> >>>>  1 file changed, 2 insertions(+), 2 deletions(-)
> >>>
> >>> Much better, thanks!
> >>>
> >>> Acked-by: Jason Cooper <jason@lakedaemon.net>
> >>>
> >>> This can be applied to v3.11 onwards.
> >>
> >> Hi Mike,
> >>
> >> Please consider applying this patch.
> > 
> > Ping ?
> 
> Mike,
> 
> this bug could be very annoying. We had some issue recently with i2c,
> and I am pretty sure it was caused by this wrong rate.
> So it would be nice to have this fix in 3.12, and then on the stable
> branches.
> 
> Of course you can also add my:
> Acked-by: Gregory CLEMENT <gregory.clement@free-electrons.com>

Well, it seems that Mike is not available this days.

Given that this patch is a trivial one-liner, maybe that someone else
can pick it ?

Thanks in advance.

Simon
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 198 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20131017/69bd1a63/attachment.sig>
