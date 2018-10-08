From: geert@linux-m68k.org (Geert Uytterhoeven)
Date: Mon, 8 Oct 2018 09:47:29 +0200
Subject: [PATCH 29/36] dt-bindings: arm: Convert Renesas board/soc
 bindings to json-schema
In-Reply-To: <20181005165848.3474-30-robh@kernel.org>
References: <20181005165848.3474-1-robh@kernel.org>
 <20181005165848.3474-30-robh@kernel.org>
Message-ID: <CAMuHMdU=rBV4b3EcenvtMPevx14pvTDcnQ7VDg02VZFiFuU-uw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Rob,

On Fri, Oct 5, 2018 at 6:59 PM Rob Herring <robh@kernel.org> wrote:
> Convert Renesas SoC bindings to DT schema format using json-schema.
>
> Cc: Simon Horman <horms@verge.net.au>
> Cc: Magnus Damm <magnus.damm@gmail.com>
> Cc: Mark Rutland <mark.rutland@arm.com>
> Cc: linux-renesas-soc at vger.kernel.org
> Cc: devicetree at vger.kernel.org
> Signed-off-by: Rob Herring <robh@kernel.org>

Thanks for your patch!

Note that this will need a rebase, as more SoCs/boards have been added
in -next.

> --- /dev/null
> +++ b/Documentation/devicetree/bindings/arm/shmobile.yaml
> @@ -0,0 +1,205 @@
> +# SPDX-License-Identifier: None

The old file didn't have an SPDX header, so it was GPL-2.0, implicitly?

> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/bindings/arm/shmobile.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Renesas SH-Mobile, R-Mobile, and R-Car Platform Device Tree Bindings
> +
> +maintainers:
> +  - Geert Uytterhoeven <geert+renesas@glider.be>

Simon Horman <horms@verge.net.au> (supporter:ARM/SHMOBILE ARM ARCHITECTURE)
Magnus Damm <magnus.damm@gmail.com> (supporter:ARM/SHMOBILE ARM ARCHITECTURE)

You had it right in the CC list, though...

> +      - description: RZ/G1M (R8A77430)
> +        items:
> +          - enum:
> +              # iWave Systems RZ/G1M Qseven Development Platform (iW-RainboW-G20D-Qseven)
> +              - iwave,g20d
> +          - const: iwave,g20m
> +          - const: renesas,r8a7743
> +
> +      - items:
> +          - enum:
> +              # iWave Systems RZ/G1M Qseven System On Module (iW-RainboW-G20M-Qseven)
> +              - iwave,g20m
> +          - const: renesas,r8a7743
> +
> +      - description: RZ/G1N (R8A77440)
> +        items:
> +          - enum:
> +              - renesas,sk-rzg1m # SK-RZG1M (YR8A77430S000BE)

This board belongs under the RZ/G1M section above
(see also the 7743 in the part number).

> +          - const: renesas,r8a7744

> +      - description: Kingfisher (SBEV-RCAR-KF-M03)
> +        items:
> +          - const: shimafuji,kingfisher
> +          - enum:
> +              - renesas,h3ulcb
> +              - renesas,m3ulcb
> +          - enum:
> +              - renesas,r8a7795
> +              - renesas,r8a7796

This looks a bit funny: all other entries have the "const" last, and
use it for the
SoC number. May be correct, though.
To clarify, this is an extension board that can fit both the [HM]3ULCB
boards (actually also the new M3NULCB, I think).

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert at linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
