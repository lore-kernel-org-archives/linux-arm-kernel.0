From: geert@linux-m68k.org (Geert Uytterhoeven)
Date: Fri, 9 Sep 2016 14:07:28 +0200
Subject: [PATCH 1/8] devicetree: binding: R-car Gen3 CMT0 and CMT1 bindings
In-Reply-To: <1473421394-9745-2-git-send-email-bd-phuc@jinso.co.jp>
References: <1473421394-9745-1-git-send-email-bd-phuc@jinso.co.jp>
 <1473421394-9745-2-git-send-email-bd-phuc@jinso.co.jp>
Message-ID: <CAMuHMdVAuyWUid6GEJXNoyw4bH3h=QWmo7eMLyiCayc5UQaoFA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Phuc-san,

On Fri, Sep 9, 2016 at 1:43 PM,  <bd-phuc@jinso.co.jp> wrote:
> Add documentation for new separate CMT0 and CMT1 DT compatible strings
> for R-Car Gen3.
>
> Signed-off-by: Bui Duc Phuc <bd-phuc@jinso.co.jp>
> ---
>  Documentation/devicetree/bindings/timer/renesas,cmt.txt | 2 ++
>  1 file changed, 2 insertions(+)
>
> diff --git a/Documentation/devicetree/bindings/timer/renesas,cmt.txt b/Documentation/devicetree/bindings/timer/renesas,cmt.txt
> index 1a05c1b..72fd526 100644
> --- a/Documentation/devicetree/bindings/timer/renesas,cmt.txt
> +++ b/Documentation/devicetree/bindings/timer/renesas,cmt.txt
> @@ -52,6 +52,8 @@ Required Properties:
>                 (CMT[01] on r8a73a4, r8a7790 and r8a7791)
>                 This is a fallback for the renesas,cmt-48-r8a73a4,
>                 renesas,cmt-48-r8a7790 and renesas,cmt-48-r8a7791 entries.
> +    - "renesas,cmt-48-gen3" for third generation 48-bit CMT
> +               (CMT[01] on r8a7795 and r8a7796)

I think the plan was to get rid of the renesas,cmt-48-* bindings, as they do
not allow to differentiate between CMT0 and CMT1, which have different feature
sets.

Cfr. Magnus' series "clocksource: sh_cmt: DT binding rework V4"
(https://lkml.org/lkml/2016/3/14/433).

Magnus: What's the status of your series?

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert at linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
