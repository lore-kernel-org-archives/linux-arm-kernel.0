From: imirkin@alum.mit.edu (Ilia Mirkin)
Date: Tue, 9 Oct 2018 13:56:04 -0400
Subject: [PATCH v2 15/29] drm/bridge/synopsys: dw-hdmi: Enable workaround
 for v2.12a
In-Reply-To: <3616158.EzHeIcd69b@avalon>
References: <20181007093905.11253-1-jernej.skrabec@siol.net>
 <20181007093905.11253-16-jernej.skrabec@siol.net> <3616158.EzHeIcd69b@avalon>
Message-ID: <CAKb7Uvgmv4-t0g=b-Xsimn9AiRL1L4sQ51vu5xMTFKNdDC9bLw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Oct 9, 2018 at 1:40 PM Laurent Pinchart
<laurent.pinchart@ideasonboard.com> wrote:
>
> Hi Jernej,
>
> Thank you for the patch.
>
> On Sunday, 7 October 2018 12:38:51 EEST Jernej Skrabec wrote:
> > It turns out that even new DW HDMI controllers exhibits same magenta
> > line issues as older versions.
> >
> > Enable workaround for v2.12a.
>
> This doesn't affect the platforms I maintain, so I can't really test this, but
> I'm wondering whether there could be other platforms using a v2.12a DW HDMI
> that wouldn't need the workaround.
>
> My platforms use a previous version, namely v2.01a. The workaround for that
> version has been enabled by
>
> commit 9c305eb442f3b371fc722ade827bbf673514123e
> Author: Neil Armstrong <narmstrong@baylibre.com>
> Date:   Fri Feb 23 12:44:37 2018 +0100
>
>     drm: bridge: dw-hdmi: Fix overflow workaround for Amlogic Meson GX SoCs
>
> I haven't paid too much attention to the patch back then, and have now double-
> checked the HDMI output on R-Car Gen3. Enabling the workaround doesn't cause
> any regression, and reverting the commit doesn't cause any issue either. I
> thus wonder whether we shouldn't enable the workaround with count = 1 in the
> default case instead of adding new IP core versions to the list. It would be
> nice if someone from Synopsys could comment on this.

I hope this comment isn't *incredibly* off-topic, but we encountered a
similar issue with NVIDIA (and I believe AMD) hardware a while back,
related to HDMI. This was due to infoframes not being sent, but
(perhaps) HDMI Audio being enabled.

This was a single vertical(!) line. It was described as "purple", but
not sure that's distinguishable from "magenta" by most people. [ Fixed
by a522946174 on nouveau, sample bug report
https://bugs.freedesktop.org/show_bug.cgi?id=79912 ]

Cheers,

  -ilia
