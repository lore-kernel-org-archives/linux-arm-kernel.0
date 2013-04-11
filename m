From: olof@lixom.net (Olof Johansson)
Date: Thu, 11 Apr 2013 00:03:17 -0700
Subject: [PATCHv2 00/10] ARM: sunxi: Architecture cleanups and rework
In-Reply-To: <20130408170331.14359.52789@quantum>
References: <1364289198-11589-1-git-send-email-maxime.ripard@free-electrons.com>
 <51555CCF.2090005@free-electrons.com>
 <20130402183100.GM25867@quad.lixom.net>
 <515F0743.4010509@free-electrons.com>
 <20130408170331.14359.52789@quantum>
Message-ID: <20130411070317.GC31465@quad.lixom.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Apr 08, 2013 at 10:03:31AM -0700, Mike Turquette wrote:
> Quoting Maxime Ripard (2013-04-05 10:17:55)
> > Le 02/04/2013 20:31, Olof Johansson a ?crit :
> > > On Fri, Mar 29, 2013 at 10:20:15AM +0100, Maxime Ripard wrote:
> > >> Hi Mike,
> > >>
> > >> Le 26/03/2013 10:13, Maxime Ripard a ?crit :
> > >>> Hi,
> > >>>
> > >>> This patchset is a serie of various cleanups and reworks in the sunxi
> > >>> architecture to prepare a clean landing for the next Allwinner SoC, the
> > >>> A31 (sun6i).
> > >>>
> > >>> The A31 is significantly different from the previous Allwinner SoC we
> > >>> supported, the A10 and A13, to no longer make the generic sunxi prefix
> > >>> we used in most compatible string relevant, while it should really have
> > >>> been sun4i in the first place.
> > >>>
> > >>> This set is also the occasion to cleanup the timer and irq code by
> > >>> switching to the recently introduced clocksource and irqchip
> > >>> infrastructures.
> > >>>
> > >>> This set depends on the UART patches I sent previously.
> > >>
> > >> I was meaning to take this branch, but some of the drivers changes in it
> > >> depends on the clock patches that Emilio sent and that are in clk-next.
> > >> Is it ok to merge clk-next into my branch?
> > > 
> > > All of of a <subsystem>-next branch is usually asking for trouble, since it'll
> > > cause all sorts of pain if the other maintianer is rebasing his for-next
> > > branch.
> > > 
> > > Best is to get those patches on just a minimal topic branch (that is still
> > > bisectable) that is shared between the trees.
> > > 
> > > Mike?
> > 
> > Mike, could you comment on that? I'd very much like to see this patches
> > come into 3.10.
> > 
> 
> Sorry for not seeing this earlier.  This thread ended up in my mail
> killfile somehow.
> 
> I have already merged the patches that this series depends on into my
> immutable clk-for-3.10 branch.  Unfortunately that means that they
> cannot be separated out into a shared topic branch.  However
> clk-for-3.10 is immutable and will never be rebased, so it is safe to
> pull in as a dependency.
> 
> Does that solve the issue adequately?

Yes.

> Just for reference, the clk-for-3.x branch is always a subset of
> clk-next.  Once some patches from clk-next have had some cycles in
> linux-next and enough time has passed since being merged without any
> regressions or other issues I migrate them over into clk-for-3.x.
> clk-next itself is typically just clk-for-3.x with between 3 and 10
> patches on top that may be dropped or rebased or merged into
> clk-for-3.x.

We have been burned by other maintainers that normally have stable branches
rebasing them since they thought nobody was looking and they had to fix
something. :-) So even for these cases I want to see a three-way handshake.
Like we just had.


-Olof
