From: simon.guinot@sequanux.org (Simon Guinot)
Date: Tue, 29 Oct 2013 11:29:04 +0100
Subject: [PATCH v2] clk: armada-370: fix tclk frequencies
In-Reply-To: <20131023104534.11662.42256@quantum>
References: <1380794702-6191-1-git-send-email-simon.guinot@sequanux.org>
 <20131017123159.GA22434@titan.lakedaemon.net>
 <20131023104534.11662.42256@quantum>
Message-ID: <20131029102904.GD23849@kw.sim.vm.gnt>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Oct 23, 2013 at 03:45:34AM -0700, Mike Turquette wrote:
> Quoting Jason Cooper (2013-10-17 05:31:59)
> > Mike,
> > 
> > I going to go ahead a take this through my tree.  I'll hold it off until
> > my last pull request for the merge window (I'm guessing about a week).
> > If you object, just let me know before then and I'll drop it.
> > 
> > 
> > On Thu, Oct 03, 2013 at 12:05:02PM +0200, Simon Guinot wrote:
> > > This patch fixes the tclk frequency array for the Armada-370 SoC.
> > > This bug has been introduced by commit 6b72333d
> > > ("clk: mvebu: add Armada 370 SoC-centric clock init").
> > > 
> > > A wrong tclk frequency affects the following drivers: mvsdio, mvneta,
> > > i2c-mv64xxx and mvebu-devbus. This list may be incomplete.
> > > 
> > > About the mvneta Ethernet driver, note that the tclk frequency is used
> > > to compute the Rx time coalescence. Then, this bug harms the coalescence
> > > configuration and also degrades the networking performances with the
> > > default values.
> > > 
> > > Signed-off-by: Simon Guinot <simon.guinot@sequanux.org>
> > > Cc: Andrew Lunn <andrew@lunn.ch>
> > > Cc: Gregory CLEMENT <gregory.clement@free-electrons.com>
> > > Cc: Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>
> > > Cc: Jason Cooper <jason@lakedaemon.net>
> > > Cc: stable at vger.kernel.org
> > > ---
> > >  drivers/clk/mvebu/armada-370.c |    4 ++--
> > >  1 file changed, 2 insertions(+), 2 deletions(-)
> > 
> > Applied to mvebu/drivers for v3.13 and flagged for stable going back to
> > v3.11.  Also added Gregory's Ack.
> 
> Worked it out with Jason face to face. I've added to clk-fixes with ACKs
> and will send out this week.

Hi Mike,

Please, don't forget to send out :)

Thanks,

Simon
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 198 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20131029/d779ecb9/attachment-0001.sig>
