From: horms@verge.net.au (Simon Horman)
Date: Sat, 24 Jan 2015 16:55:33 +0900
Subject: [PATCH 0/9] ARM: shmobile: r8a73a4/ape6evm multiplatform
In-Reply-To: <15458901.vhItGblgjS@avalon>
References: <1421758306-24838-1-git-send-email-geert+renesas@glider.be>
 <20150122033907.GO31170@verge.net.au>
 <20150123042304.GE17548@verge.net.au> <15458901.vhItGblgjS@avalon>
Message-ID: <20150124075532.GB4192@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On ?,  1? 23, 2015 at 02:26:16?? +0200, Laurent Pinchart wrote:
> Hi Simon,
> 
> On Friday 23 January 2015 13:23:04 Simon Horman wrote:
> > On Thu, Jan 22, 2015 at 12:39:07PM +0900, Simon Horman wrote:
> > > On Wed, Jan 21, 2015 at 10:59:27AM +0900, Simon Horman wrote:
> > >> On Tue, Jan 20, 2015 at 01:51:37PM +0100, Geert Uytterhoeven wrote:
> > >>> Hi Simon, Magnus,
> > >>> 
> > >>> This patch series transitions the r8a73a4/ape6evm platform to support
> > >>> multiplatform only:
> > >>>   - Add CCF information to DT,
> > >>>   - Disable legacy clock if CCF is used,
> > >>>   - Add Bus State Controller node, and move the Ethernet node to it,
> > >>>   - Remove ape6evm-reference,
> > >>>   - Remove ape6evm-legacy and legacy support code.
> > >>> 
> > >>> This series is based on renesas-drivers-2015-01-19-v3.19-rc5.
> > >>> It depends on renesas-devel-20150119-v3.19-rc5 (code-wise) and
> > >>> clk-shmobile-for-3.20 (functionality-wise), for which I've sent a pull
> > >>> request to Mike Turquette yesterday.
> > >>> 
> > >>> All of this was untested by me due to lack of hardware.
> > >>> As Mike had previously acked the r8a73a4 CCF implementation, it's safe
> > >>> to apply after testing.
> > >> 
> > >> Hi Geert, Hi Ulrich,
> > >> 
> > >> thanks for all your good work in getting this together.
> > >> I have tested this and queued it up for v3.21.
> > >> 
> > >> I plan to push it to my devel branch later today.
> > >> I plan to push it to my next branch and thus linux-next once
> > >> clk-shmobile-for-3.20 appears in a v3.20-rc.
> > > 
> > > For the record: Olof has asked for review comments for the BSC driver and
> > > binding patches. Accordingly I have dropped them, and these patches which
> > > depend on them, from next.
> > 
> > I have now had a chance to re-examine these patches and it seems to me that
> > the first four patches of the series not depend on the BSC driver (or
> > anything else).  With that in mind I have queued them up in a new
> > r8a73a4-ccf-for-v3.21 branch which is present in
> > renesas-devel-20150123-v3.19-rc5.
> > 
> > Please take a moment to see if what I have done makes sense to you.  In
> > particular it would be nicer if these patches could go into 'regular'
> > branches such as dt-for-v3.21 and soc-for-v3.21. However it seems to me
> > that the SoC patch "ARM: shmobile: ape6evm: Disable legacy clock
> > initialization" depends on the following two DT patche " "ARM: shmobile:
> > r8a73a4: Common clock framework DT description".
> 
> I've noticed you have dropped the following patches from your devel branch:
> 
> clk: shmobile: div6: Avoid changing divisor in .disable()
> clk: shmobile: Add r8a7793 support
> clk: shmobile: r8a7793: document CPG clock support
> clk: shmobile: r8a73a4 common clock framework implementation
> clk: shmobile: Add r8a73a4 SoC to MSTP bindings
> clk: shmobile: Add R-Car Gen2 RCAN clock support
> clk: shmobile: Add R-Car Gen2 ADSP clock support
> 
> I don't see those patches queued in Mike Turquette's CCF tree.
>
> How should they be handled, and do they need to be delayed to v3.21 ?

My understanding is that that Geert has sent a pull request to Mike for
those. And that they are targeted at v3.21 via Mike's tree.

I was (perhaps) confusingly carrying that  branch that Geert sent a pull
request for in order to allow me to queue up all of the shmobile side of
r8a73a4 multiplatform. My expectation was that the clk: shmobile changes
would be in Linus's tree before I sent a pull request for the shmobile side
of r8a73a4 multiplatform.

Using the same logic I should probably re-queue up the "clk: shmobile"
changes in my devel branch. But perhaps its best to leave them out to avoid
further confusion.
