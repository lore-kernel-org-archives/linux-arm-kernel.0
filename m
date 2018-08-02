From: maxi.jourdan@wanadoo.fr (Maxime Jourdan)
Date: Thu, 2 Aug 2018 15:14:30 +0200
Subject: [PATCH 1/4] soc: amlogic: add meson-canvas driver
In-Reply-To: <36fcadd3-074d-7c11-6ca5-b44aecaa3639@baylibre.com>
References: <20180801185128.23440-1-maxi.jourdan@wanadoo.fr>
 <20180801185128.23440-2-maxi.jourdan@wanadoo.fr>
 <36fcadd3-074d-7c11-6ca5-b44aecaa3639@baylibre.com>
Message-ID: <CAHStOZ4DV8FbAgzMKhnbLOOPj7Gm8+5=KxMSGL6J1D00Ejk42g@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Neil,

2018-08-02 10:38 GMT+02:00 Neil Armstrong <narmstrong@baylibre.com>:
> Please switch to the spdx header format here and in the .h.

> In the DRM driver these are updated in IRQ context, we should make sure we don't sleep
> in interrupt context if IRQ occurs when the VDEC updates it's canvases.
>
> Could you switch to spin_lock_irqsave() instead ?

Will do.

> Can you add the endian defines ?
>
> #define MESON_CANVAS_ENDIAN_SWAP16      0x1
> #define MESON_CANVAS_ENDIAN_SWAP32      0x3
> #define MESON_CANVAS_ENDIAN_SWAP64      0x7
> #define MESON_CANVAS_ENDIAN_SWAP128     0xf
>
> the SWAP64 is the one used in the VDEC and DRM Overlays.

Sure. Maybe I should push the flags (0x1, 0x2, 0x4, 0x8) rather than
the combinations?
Or both, since the combinations are more likely to be used in practice
more than the single flags.

> I rebased my DRM Overlay patch on top of this and :
> Tested-by: Neil Armstrong <narmstrong@baylibre.com>
>
> You can keep this tag on future versions.

Thanks!
