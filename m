From: horms@verge.net.au (Simon Horman)
Date: Wed, 26 Apr 2017 10:56:10 +0200
Subject: [PATCH/RFC 0/5] arm64: dts: renesas: Break out common board
 support
In-Reply-To: <CAMuHMdXbe=rkeS+-teg7nqbjULWY0_5pBO1XEzCGdYA4gB57oA@mail.gmail.com>
References: <1492779321-23939-1-git-send-email-geert+renesas@glider.be>
 <20170426080642.GK25517@verge.net.au>
 <CAMuHMdXbe=rkeS+-teg7nqbjULWY0_5pBO1XEzCGdYA4gB57oA@mail.gmail.com>
Message-ID: <20170426085610.GM25517@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Apr 26, 2017 at 10:11:55AM +0200, Geert Uytterhoeven wrote:
> Hi Simon,
> 
> CC Vladimir (which I forgot to CC initially, sorry for that)
> 
> On Wed, Apr 26, 2017 at 10:06 AM, Simon Horman <horms@verge.net.au> wrote:
> > On Fri, Apr 21, 2017 at 02:55:16PM +0200, Geert Uytterhoeven wrote:
> >> The Renesas Salvator-X and ULCB development board can be equipped with
> >> either an R-Car H3 or M3-W SiP, which are pin-compatible.  All boards
> >> use separate DTBs, but currently there's no sharing of board-specific
> >> devices in DTS.
> >>
> >> This series reduces duplication by extracting common board support into
> >> their own .dtsi files.  As the level of support varies across boards and
> >> SoCs, this requires the addition of a few external clocks and
> >> placeholder devices on R-Car M3-W, so the common board support DTS can
> >> refer to them.
> >>
> >>   - Patches 1 and 2 add the external audio and PCIe bus clocks on R-Car
> >>     M3-W, which are present in r8a7795.dtsi, and used in
> >>     r8a7795-salvator-x.dts,
> >>   - RFC patch 3 adds placeholders for devices that are not yet supported
> >>     and/or tested on R-Car M3-W, but used on R-Car H3,
> >>   - RFC patch 4 extracts common Salvator-X board support,
> >>   - RFC patch 5 extracts common ULCB board support.
> >>
> >> For R-Car H3 based boards, there are no functional changes.
> >> For R-Car M3-W based boards, some new devices are now described in DT.
> >>
> >> Dependencies:
> >>   - renesas-devel-20170420-v4.11-rc7,
> >>   - Patches 1 and 2 can be applied as-is,
> >>   - Patches 4 and 5 depend on "[PATCH 0/8] arm64: dts: renesas: Break
> >>     out R-Car H3 and M3-W SiP"
> >>     (http://www.spinics.net/lists/devicetree/msg173820.html).
> >>
> >> DTB changes have been inspected using scripts/dtc/dtx_diff.
> >> This has been tested on Salvator-X (both H3 and M3-W).
> >> This has not been tested on H3ULCB and M3ULCB due to lack of hardware.
> >>
> >> Thanks for your comments!
> >
> > Thanks for tackling this important problem. I have looked over the changes
> > and they seem nice to me. I would, however, be more comfortable applying
> > them if they were rested on the ULCB boards.
> 
> tested?

Yes, tested :)

> I've pushed a branch for testing to topic/rcar3-dtsi-sharing in
> git://git.kernel.org/pub/scm/linux/kernel/git/geert/renesas-drivers.git.
