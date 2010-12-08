From: LW@KARO-electronics.de (=?iso-8859-15?Q?Lothar_Wa=DFmann?=)
Date: Wed, 8 Dec 2010 12:32:16 +0100
Subject: [PATCH v2 08/15] ARM: mxs: Add iomux support
In-Reply-To: <AANLkTimHyYUkDqLQ79o9fP_9NgOK1Lec=psoFCpb1+jA@mail.gmail.com>
References: <1290754154-9428-1-git-send-email-shawn.guo@freescale.com>
	<1291739523-25077-7-git-send-email-shawn.guo@freescale.com>
	<19711.13023.154958.539289@ipc1.ka-ro>
	<AANLkTikb4Ytx==R=n7RDOXv+tKtVvgcTUX7R-QDQfVoc@mail.gmail.com>
	<20101208105643.GO18244@pengutronix.de>
	<AANLkTimHyYUkDqLQ79o9fP_9NgOK1Lec=psoFCpb1+jA@mail.gmail.com>
Message-ID: <19711.27840.946740.905255@ipc1.ka-ro>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Shawn Guo writes:
> 2010/12/8 Uwe Kleine-K?nig <u.kleine-koenig@pengutronix.de>:
> > Hello,
> >
> > On Wed, Dec 08, 2010 at 06:52:36PM +0800, Shawn Guo wrote:
> >> Hi Lothar,
> >>
> >> Thanks for the review.
> >>
> >> On Wed, Dec 8, 2010 at 3:25 PM, Lothar Wa?mann <LW@karo-electronics.de> wrote:
> >> > Hi,
> >> >
> >> > Shawn Guo writes:
> >> >> MXS-based SoCs implements iomux functions in block PINCTRL.
> >> >>
> >> >> Signed-off-by: Shawn Guo <shawn.guo@freescale.com>
> >> >> ---
> >> >> Changes for v2:
> >> >> ?- Define iomux_cfg_t as u64
> >> > ? ? ^^^^^^^^^^^^^^^^^^^^^^^^^
> >> > Really?
> >> >
> >> >> +typedef struct pad_desc {
> >> >> + ? ? unsigned bank:12;
> >> >> + ? ? unsigned pin:20;
> >> >> + ? ? unsigned muxsel:8;
> >> >> + ? ? unsigned ma:12;
> >> >> + ? ? unsigned vol:8;
> >> >> + ? ? unsigned pull:4;
> >> >> +} iomux_cfg_t;
> >> > ^^^^^^^^^^^^^^^^^
> >> >
> >> I did not pick the correct word. ?What I meant is 64 bits. ?Since this
> >> error is in change log, I would fix it if there is v3 of the patch.
> > the idea was to really use an u64 to have the pin definitions modifyable.
> >
> Ah, I misunderstood the comments.  But I did not see mxc switches to
> u64.  Do you have example to show what you want exactly?
> 
See:
http://lists.infradead.org/pipermail/linux-arm-kernel/2010-November/032202.html


Lothar Wa?mann
-- 
___________________________________________________________

Ka-Ro electronics GmbH | Pascalstra?e 22 | D - 52076 Aachen
Phone: +49 2408 1402-0 | Fax: +49 2408 1402-10
Gesch?ftsf?hrer: Matthias Kaussen
Handelsregistereintrag: Amtsgericht Aachen, HRB 4996

www.karo-electronics.de | info at karo-electronics.de
___________________________________________________________
