From: arnd@arndb.de (Arnd Bergmann)
Date: Thu, 19 Oct 2017 23:39:45 +0200
Subject: [GIT PULL] Renesas ARM64 Based SoC DT Updates for v4.15
In-Reply-To: <cover.1506678250.git.horms+renesas@verge.net.au>
References: <cover.1506678250.git.horms+renesas@verge.net.au>
Message-ID: <CAK8P3a0-c+HvugOmrRr+7sbEe8MOw2wz+s=Q899j42vd8jSBPA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Sep 29, 2017 at 1:52 PM, Simon Horman
<horms+renesas@verge.net.au> wrote:
> ----------------------------------------------------------------
> Renesas ARM64 Based SoC DT Updates for v4.15
>
> * r8a7795 (H3)
>   - Use r8a7795-cpg-mssr and r8a7795-sysc bindings
>     Hardcoded indicies are replaced with symbols now that they are available
>
>   - Drop bogus HDMI node name suffixes
>     Laurent Pinchart says: Node names should not use numerical suffixes if
>     the nodes can be distinguished by unit-address
>
>   - Update PFC node name to pin-controller
>     Shimoda-san says the PFC node name is changed "from e6060000.pfc and
>     pfc at e6060000 to e6060000.pin-controller and pin-controller at e6060000
>     like other Renesas SoCs."
>
> * r8a7795 (H3) ES1.0
>   - Drop extra zero from XHCI unit address
>     This corrects a typo were ee0400000 rather than ee040000 was used
>     as the unit address.
>
> * r8a7796 (M3-W)
>   - Add FDP1 instance
>     Laurent Pinchart says: The r8a7796 has a single FDP1 instance.
>
> * r8a7795 (H3) and r8a7796 (M3-W) SoCs
>   - Add USB3.0 peripheral device nodes
>     Shimoda-san says that this is not enabled on the Salvator-X/XS boards
>     for now as:
>      + we need a special cable (USB type-A to A cross cable).
>      + we can swap the role by renesas_usb3 driver even if we use a normal
>         cable and after usb3.0 host is running, but I think it's a special
>         use case.
>
> * r8a7795 (H3) and r8a7796 (M3-W) ULCB boards
>   - Enable display output
>     Laurent Pinchart says: The DU is already wired up to the HDMI encoder,
>     all we need to do is enable it.
>
> * r8a77995 (D3) Draak board
>   - Enable EthernetAVB and , USB2.0 Host and PHY
>
>   - Add serial console pins.
>     This is safe to do now that r8a77995 PFC driver support is present
>
> * r8a77970 (V3M)
>   - Add basic support for SoC and EtherAVB, [H]SCIF and SYS-DMAC nodes
>     This is a step towards enabling EtherAVB and [H]SCIF with SYS-DMAC
>     in the Eagle board support for which is under review

Thanks for the detailed changelog!

> ----------------------------------------------------------------
> Geert Uytterhoeven (6):
>       arm64: dts: renesas: r8a7795-es1: Drop extra zero from usb unit address
>       arm64: dts: renesas: r8a7795: Drop bogus HDMI node names suffixes
>       arm64: renesas: Add Renesas R8A77970 Kconfig support

That one last commit doesn't seem to belong in here, but I've pulled
it anyway, thanks!

        Arnd
