From: horms@verge.net.au (Simon Horman)
Date: Wed, 21 Feb 2018 17:50:54 +0100
Subject: [PATCH v2 03/19] soc: renesas: Identify R-Car M3-N
In-Reply-To: <CAMuHMdVw4OSPP7XYLGuE7SfVjOk_6VK847NdsVwszBX9XshQ3A@mail.gmail.com>
References: <1519139541-18783-1-git-send-email-jacopo+renesas@jmondi.org>
 <1519139541-18783-4-git-send-email-jacopo+renesas@jmondi.org>
 <CAMuHMdVw4OSPP7XYLGuE7SfVjOk_6VK847NdsVwszBX9XshQ3A@mail.gmail.com>
Message-ID: <20180221165053.xx6gqdyja2zfghmy@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Feb 20, 2018 at 04:40:34PM +0100, Geert Uytterhoeven wrote:
> Hi Jacopo,
> 
> On Tue, Feb 20, 2018 at 4:12 PM, Jacopo Mondi <jacopo+renesas@jmondi.org> wrote:
> > Add support for indentifying R-Car M3-N (R8A77965) SoC.
> >
> > Signed-off-by: Jacopo Mondi <jacopo+renesas@jmondi.org>
> 
> Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
> 
> > --- a/drivers/soc/renesas/renesas-soc.c
> > +++ b/drivers/soc/renesas/renesas-soc.c
> > @@ -149,6 +149,11 @@ static const struct renesas_soc soc_rcar_v3m __initconst __maybe_unused = {
> >         .id     = 0x54,
> >  };
> >
> > +static const struct renesas_soc soc_rcar_m3_n __initconst __maybe_unused = {
> > +       .family = &fam_rcar_gen3,
> > +       .id     = 0x55,
> > +};
> 
> Note that the list was sorted by SoC part number.

Thanks, I have moved the above structure to between
the similar structure for m3_w and v3m. The result is below.

> > +
> >  static const struct renesas_soc soc_rcar_v3h __initconst __maybe_unused = {
> >         .family = &fam_rcar_gen3,
> >         .id     = 0x56,
> > @@ -214,6 +219,9 @@ static const struct of_device_id renesas_socs[] __initconst = {
> >  #ifdef CONFIG_ARCH_R8A7796
> >         { .compatible = "renesas,r8a7796",      .data = &soc_rcar_m3_w },
> >  #endif
> > +#ifdef CONFIG_ARCH_R8A77965
> > +       { .compatible = "renesas,r8a77965",     .data = &soc_rcar_m3_n },
> > +#endif
> >  #ifdef CONFIG_ARCH_R8A77970
> >         { .compatible = "renesas,r8a77970",     .data = &soc_rcar_v3m },
> >  #endif

From: Jacopo Mondi <jacopo+renesas@jmondi.org>
Subject: [PATCH] soc: renesas: Identify R-Car M3-N

Add support for indentifying R-Car M3-N (R8A77965) SoC.

Signed-off-by: Jacopo Mondi <jacopo+renesas@jmondi.org>
Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
---
 drivers/soc/renesas/renesas-soc.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/drivers/soc/renesas/renesas-soc.c b/drivers/soc/renesas/renesas-soc.c
index 000834321774..ea71c413c926 100644
--- a/drivers/soc/renesas/renesas-soc.c
+++ b/drivers/soc/renesas/renesas-soc.c
@@ -144,6 +144,11 @@ static const struct renesas_soc soc_rcar_m3_w __initconst __maybe_unused = {
 	.id	= 0x52,
 };
 
+static const struct renesas_soc soc_rcar_m3_n __initconst __maybe_unused = {
+	.family = &fam_rcar_gen3,
+	.id     = 0x55,
+};
+
 static const struct renesas_soc soc_rcar_v3m __initconst __maybe_unused = {
 	.family	= &fam_rcar_gen3,
 	.id	= 0x54,
@@ -214,6 +219,9 @@ static const struct of_device_id renesas_socs[] __initconst = {
 #ifdef CONFIG_ARCH_R8A7796
 	{ .compatible = "renesas,r8a7796",	.data = &soc_rcar_m3_w },
 #endif
+#ifdef CONFIG_ARCH_R8A77965
+	{ .compatible = "renesas,r8a77965",	.data = &soc_rcar_m3_n },
+#endif
 #ifdef CONFIG_ARCH_R8A77970
 	{ .compatible = "renesas,r8a77970",	.data = &soc_rcar_v3m },
 #endif
-- 
2.11.0
