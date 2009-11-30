From: javier.martin@vista-silicon.com (javier Martin)
Date: Mon, 30 Nov 2009 14:09:16 +0100
Subject: [PATCH 8/9 v2] MXC: Add a digital audio multiplexer driver
In-Reply-To: <20091130123412.GP27548@pengutronix.de>
References: <1258022525-21078-4-git-send-email-s.hauer@pengutronix.de>
	<1258022525-21078-6-git-send-email-s.hauer@pengutronix.de>
	<1258022525-21078-7-git-send-email-s.hauer@pengutronix.de>
	<1258022525-21078-8-git-send-email-s.hauer@pengutronix.de>
	<1258022525-21078-9-git-send-email-s.hauer@pengutronix.de>
	<20091112150615.GA30179@pengutronix.de>
	<eedb5540911300356p2b41eeaakee050953ad39ec26@mail.gmail.com>
	<20091130121017.GN27548@pengutronix.de>
	<eedb5540911300425n374af9f0k5346d85fdb79eb11@mail.gmail.com>
	<20091130123412.GP27548@pengutronix.de>
Message-ID: <eedb5540911300509t11cc783cr8e97eda66ee382a@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


>From bogus@does.not.exist.com  Fri Nov  6 13:01:15 2009
From: bogus@does.not.exist.com ()
Date: Fri, 06 Nov 2009 18:01:15 -0000
Subject: No subject
Message-ID: <mailman.58.1259665835.2170.linux-arm-kernel@lists.infradead.org>

> From: Sascha Hauer <s.hauer@pengutronix.de>
> Date: Mon, 30 Nov 2009 13:31:29 +0100
> Subject: [PATCH] i.MX27 audmux: Fix register offsets
>
> The PPCR registers start at 0x10, not 0xc. Fix this.
>
> Signed-off-by: Sascha Hauer <s.hauer@pengutronix.de>
> ---
>  arch/arm/plat-mxc/include/mach/audmux.h |    6 +++---
>  1 files changed, 3 insertions(+), 3 deletions(-)
>
> diff --git a/arch/arm/plat-mxc/include/mach/audmux.h
> b/arch/arm/plat-mxc/include/mach/audmux.h
> index 5cd6466..dcc12d4 100644
> --- a/arch/arm/plat-mxc/include/mach/audmux.h
> +++ b/arch/arm/plat-mxc/include/mach/audmux.h
> @@ -4,9 +4,9 @@
>  #define MX27_AUDMUX_HPCR1_SSI0         0
>  #define MX27_AUDMUX_HPCR2_SSI1         1
>  #define MX27_AUDMUX_HPCR3_SSI_PINS_4   2
> -#define MX27_AUDMUX_PPCR1_SSI_PINS_1   3
> -#define MX27_AUDMUX_PPCR2_SSI_PINS_2   4
> -#define MX27_AUDMUX_PPCR3_SSI_PINS_3   5
> +#define MX27_AUDMUX_PPCR1_SSI_PINS_1   4
> +#define MX27_AUDMUX_PPCR2_SSI_PINS_2   5
> +#define MX27_AUDMUX_PPCR3_SSI_PINS_3   6
>

Be careful,
I think this patch breaks some of the boards currently using
MXC_AUDMUX_V1_PCR_RXDSEL(x) and similar macros defined in mach/audmux.h (for
example pcm038).
For those macros the old AUDMUX register indexes are fine.

I suggest fixing this inside audmux_v1.c instead of modifying mach/audmux.h.


Thank you.
-- 
Javier Martin
Vista Silicon S.L.
CDTUC - FASE C - Oficina S-345
Avda de los Castros s/n
39005- Santander. Cantabria. Spain
+34 942 25 32 60
www.vista-silicon.com

--0016e6d58cb2408bb9047996596d
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable


>From bogus@does.not.exist.com  Fri Nov  6 13:01:15 2009
From: bogus@does.not.exist.com ()
Date: Fri, 06 Nov 2009 18:01:15 -0000
Subject: No subject
Message-ID: <mailman.59.1259665835.2170.linux-arm-kernel@lists.infradead.org>

div class=3D"gmail_quote"><blockquote class=3D"gmail_quote" style=3D"border=
-left: 1px solid rgb(204, 204, 204); margin: 0pt 0pt 0pt 0.8ex; padding-lef=
t: 1ex;">

From: Sascha Hauer &lt;<a href=3D"mailto:s.hauer@pengutronix.de">s.hauer at pe=
ngutronix.de</a>&gt;<br>
Date: Mon, 30 Nov 2009 13:31:29 +0100<br>
Subject: [PATCH] i.MX27 audmux: Fix register offsets<br>
<br>
The PPCR registers start at 0x10, not 0xc. Fix this.<br>
<br>
Signed-off-by: Sascha Hauer &lt;<a href=3D"mailto:s.hauer@pengutronix.de">s=
.hauer at pengutronix.de</a>&gt;<br>
---<br>
=A0arch/arm/plat-mxc/include/mach/audmux.h | =A0 =A06 +++---<br>
=A01 files changed, 3 insertions(+), 3 deletions(-)<br>
<br>
diff --git a/arch/arm/plat-mxc/include/mach/audmux.h b/arch/arm/plat-mxc/in=
clude/mach/audmux.h<br>
index 5cd6466..dcc12d4 100644<br>
--- a/arch/arm/plat-mxc/include/mach/audmux.h<br>
+++ b/arch/arm/plat-mxc/include/mach/audmux.h<br>
@@ -4,9 +4,9 @@<br>
<div class=3D"im">=A0#define MX27_AUDMUX_HPCR1_SSI0 =A0 =A0 =A0 =A0 0<br>
=A0#define MX27_AUDMUX_HPCR2_SSI1 =A0 =A0 =A0 =A0 1<br>
=A0#define MX27_AUDMUX_HPCR3_SSI_PINS_4 =A0 2<br>
-#define MX27_AUDMUX_PPCR1_SSI_PINS_1 =A0 3<br>
-#define MX27_AUDMUX_PPCR2_SSI_PINS_2 =A0 4<br>
-#define MX27_AUDMUX_PPCR3_SSI_PINS_3 =A0 5<br>
</div>+#define MX27_AUDMUX_PPCR1_SSI_PINS_1 =A0 4<br>
+#define MX27_AUDMUX_PPCR2_SSI_PINS_2 =A0 5<br>
+#define MX27_AUDMUX_PPCR3_SSI_PINS_3 =A0 6<br></blockquote><br>Be careful,=
<br>I think this patch breaks some of the boards currently using MXC_AUDMUX=
_V1_PCR_RXDSEL(x) and similar macros defined in mach/audmux.h (for example =
pcm038).<br>
For those macros the old AUDMUX register indexes are fine.<br><br>I suggest=
 fixing this inside audmux_v1.c instead of modifying mach/audmux.h.<br><br>=
<br>Thank you.<br></div>-- <br>Javier Martin<br>Vista Silicon S.L.<br>CDTUC=
 - FASE C - Oficina S-345<br>
Avda de los Castros s/n<br>39005- Santander. Cantabria. Spain<br>+34 942 25=
 32 60<br><a href=3D"http://www.vista-silicon.com">www.vista-silicon.com</a=
><br>

--0016e6d58cb2408bb9047996596d--
