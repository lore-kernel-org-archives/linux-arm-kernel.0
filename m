From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Tue, 29 Nov 2016 22:36:50 +0100
Subject: [PATCH v7 0/8] drm: sun8i: Add DE2 HDMI video support
In-Reply-To: <cover.1480414715.git.moinejf@free.fr>
References: <cover.1480414715.git.moinejf@free.fr>
Message-ID: <20161129213650.uqcgekodq77wlmxs@lukather>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Nov 29, 2016 at 11:18:35AM +0100, Jean-Francois Moine wrote:
> This patchset series adds HDMI video support to the Allwinner
> sun8i SoCs which include the display engine 2 (DE2).
> The driver contains the code for the A83T and H3 SoCs, and
> some H3 boards, but it could be used/extended for other SoCs
> (A64, H2, H5) and boards (Banana PIs, Orange PIs).

Honestly, I'm getting a bit worried by the fact that you ignore
reviews.

On the important reviews that you got that are to be seen as major
issues that block the inclusion, we have:
  - The fact that the HDMI driver is actually just a designware IP,
    and while you should use the driver that already exists, you just
    duplicated all that code.

  - The fact that you ignored Rob (v6) and I (v5) comment on using OF
    graph to model the connection between the display engine and the
    TCON. Something that Laurent also pointed out in this version.

  - The fact that you ignored that you needed an HDMI connector node
    as a child of the HDMI controller. This has been reported by Rob
    (v6) and yet again in this version by Laurent.

  - And finally the fact that we can't have several display engine in
    parallel, if needs be. This has happened in the past already on
    Allwinner SoCs, so it's definitely something we should consider in
    the DT bindings, since we can't break them.

Until those are fixed, I cannot see how this driver can be merged,
unfortunately.

Maxime

-- 
Maxime Ripard, Free Electrons
Embedded Linux and Kernel engineering
http://free-electrons.com
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 801 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20161129/3fff35b9/attachment.sig>
