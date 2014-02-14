From: geert@linux-m68k.org (Geert Uytterhoeven)
Date: Fri, 14 Feb 2014 10:18:58 +0100
Subject: [PATCH 23/27] clocksource: sh_cmt: Add DT support
In-Reply-To: <1392339605-20691-24-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
References: <1392339605-20691-1-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
 <1392339605-20691-24-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
Message-ID: <CAMuHMdUPJ_Wz85AJeYF8vnkOfjd8A7fHb45bL5-B0bAPqNHnhw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Feb 14, 2014 at 2:00 AM, Laurent Pinchart
<laurent.pinchart+renesas@ideasonboard.com> wrote:
> +++ b/Documentation/devicetree/bindings/timer/renesas,cmt.txt
> @@ -0,0 +1,75 @@
> +* Renesas R-Car Compare Match Timer (CMT)
> +
> +The CMT is a multi-channel 16/32/48-bit timer/counter with configurable clock

16-bit is mentioned here ...

> +inputs and programmable compare match.
> +
> +Channels share hadware resources but their counter and compare match value are

hardware

> +independent. A particular CMT instance can implement only a subset of the
> +channels supported by the CMT model. Channels indices start from 0 and are

Channel indices

> +consecutive.
> +
> +Required Properties:
> +
> +  - compatible: must contain one of the following.

... why not add "renesas,cmt-16" here (and one extra line in the actual driver),
while you're at it?

> +    - "renesas,cmt-32" for the 32-bit CMT
> +               (CMT0 on sh7372, sh73a0 and r8a7740)
> +    - "renesas,cmt-32-fast" for the 32-bit CMT with fast clock support
> +               (CMT[234] on sh7372, sh73a0 and r8a7740)
> +    - "renasas,cmt-48" for the 48-bit CMT
> +               (CMT1 on sh7372, sh73a0 and r8a7740)
> +    - "renesas,cmt-48-gen2" for the second generation 48-bit CMT
> +               (CMT[01] on r8a73a4, r8a7790 and r8a7791)

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert at linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
