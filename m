From: tomi.valkeinen@ti.com (Tomi Valkeinen)
Date: Tue, 15 Nov 2011 09:06:36 +0200
Subject: [GIT PULL] ARM: OMAP: DSS hwmod/reset fixes for 3.2
In-Reply-To: <20111114220423.GQ31337@atomide.com>
References: <alpine.DEB.2.00.1110061806150.4611@utopia.booyaka.com>
 <20111105003550.GM31337@atomide.com>
 <alpine.DEB.2.00.1111080049470.12394@utopia.booyaka.com>
 <1320746911.1907.47.camel@deskari>
 <alpine.DEB.2.00.1111080329300.8313@utopia.booyaka.com>
 <1320754489.1907.50.camel@deskari> <20111114204649.GL31337@atomide.com>
 <alpine.DEB.2.00.1111141438290.19654@utopia.booyaka.com>
 <20111114220423.GQ31337@atomide.com>
Message-ID: <1321340796.1895.8.camel@deskari>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, 2011-11-14 at 14:04 -0800, Tony Lindgren wrote:
> * Paul Walmsley <paul@pwsan.com> [111114 13:05]:
> > On Mon, 14 Nov 2011, Tony Lindgren wrote:
> > 
> > > I suggest we only merge the ones with "fix" in the subject during the -rc
> > > cycle. The others add new features for the reset, so they should wait until
> > > v3.3 merge window.
> > 
> > Most of the other patches in the branch discuss what they fix in the patch 
> > descriptions, rather than the subject lines.  Do you want the subject 
> > lines rewritten to highlight this?
> 
> Well we should only merge major bugs and regressions during the -rc cycle.
> It seems that at least "OMAP: HWMOD: Unify DSS resets for OMAPs" has high
> flame potential based on that? Maybe we should wait until the next merge
> window to start removing some of these workarounds?

I'm not sure what you mean...

The "Unify DSS resets..." patch itself fixes only a minor bug: "This
causes causes the HWMOD reset to fail for dss_dispc and dss_rfbi". But
it makes the next patch, "Ensure DSS works correctly...", possible. And
that patch fixes a bigger bug, DSS or the whole device hanging if the
bootloader had enabled the display (which I believe is the default on
the shipped beagles/pandas).

There's one patch in the series that is not a fix, though: "ARM: OMAP4:
HWMOD: remove extra clocks". I'm fine with queuing that for the next
merge window. But most of the patches have now somehow missed two merge
windows, and I'd really like to get them in.

 Tomi

-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: This is a digitally signed message part
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20111115/a4c8aab2/attachment.sig>
