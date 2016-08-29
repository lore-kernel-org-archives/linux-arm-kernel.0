From: carlo@caione.org (Carlo Caione)
Date: Mon, 29 Aug 2016 21:50:30 +0200
Subject: [RFC PATCH 0/3] ARm64: amlogic: Introduce common GX family dtsi
In-Reply-To: <2983d731-82fd-63fc-7541-8c1d6a929416@suse.de>
References: <1472457371-1305-1-git-send-email-narmstrong@baylibre.com>
 <CAOQ7t2YGbASh7v25wgDspKNWgFOcRsikJs_WZptn+LkVXmaHig@mail.gmail.com>
 <2983d731-82fd-63fc-7541-8c1d6a929416@suse.de>
Message-ID: <20160829195030.GA10797@localhost>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 29/08/16 20:38, Andreas F?rber wrote:
> Am 29.08.2016 um 10:01 schrieb Carlo Caione:
> > On Mon, Aug 29, 2016 at 9:56 AM, Neil Armstrong <narmstrong@baylibre.com> wrote:
> >> The new Amlogic GLX SoCs (S905X and S905D) are part of the Meson GX family so
> >> they share some basic characteritics that can be described in a common GX
> >> dtsi file used by the Meson GXBB and Meson GXL dtsi.
> >>
> >> This patchset introduces the common dtsi and switches the GLX and GXBB to use
> >> the common dtsi, the GXBB dtsi is reformated to handle this situation.
> >>
> >> This patchset depends on Carlo Caione "ARM64: dts: amlogic: Add basic support for Amlogic S905X" [1]
> >>
> >> [1] http://lkml.kernel.org/r/1472382113-10754-1-git-send-email-carlo at caione.org
> >>
> >> Neil Armstrong (3):
> >>   ARM64: dts: amlogic: Add Meson GX Family common dtsi
> >>   ARM64: dts: amlogic: Switch Meson GXL dtsi to use common GX dtsi
> >>   ARM64: dts: amlogic: Switch Meson GXBB dtsi to use common GX dtsi
> > 
> > FWIW
> > Acked-by: Carlo Caione <carlo@endlessm.com>
> 
> Adding an unused .dtsi duplicating GXBB makes me uneasy.

S905x (GXL) is different from S905 (GXBB), it's unused now but in the
future we can expect something different in the two DTSI.

> Any chance we can simplify this to at most two steps?
> 1) Move code from gxbb to gx (1/3 + 3/3)
> 2) Add gxl using gx ("Add basic support for Amlogic S905X" + 2/3)

fine by me.

> Alternatively:
> 1) "Add basic support for Amlogic S905X"
> 2) Factor out common bits (1/3 + 2/3 + 3/3)

how is this different from this patchset?

> As for bike-shedding, is there a GX family as well or could we drop
> -common? .dtsi is always something common - compare Exynos or i.MX.
> Since there are meson8b and meson8 I was anticipating that after gxbb
> would come gx, not gxl.

AFAIK we have:
- GXBB
- GXL
- GXM
- GXTVBB

> Do you know what the L in GXL is for? Should we consider renaming gxbb
> to gxb, and then also insert -s905 as suggested by Kevin, for symmetry?

Yes, that make sense.

Cheers,

-- 
Carlo Caione
