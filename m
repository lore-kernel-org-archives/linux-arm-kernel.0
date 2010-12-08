From: u.kleine-koenig@pengutronix.de (Uwe =?iso-8859-1?Q?Kleine-K=F6nig?=)
Date: Wed, 8 Dec 2010 11:56:43 +0100
Subject: [PATCH v2 08/15] ARM: mxs: Add iomux support
In-Reply-To: <AANLkTikb4Ytx==R=n7RDOXv+tKtVvgcTUX7R-QDQfVoc@mail.gmail.com>
References: <1290754154-9428-1-git-send-email-shawn.guo@freescale.com>
	<1291739523-25077-7-git-send-email-shawn.guo@freescale.com>
	<19711.13023.154958.539289@ipc1.ka-ro>
	<AANLkTikb4Ytx==R=n7RDOXv+tKtVvgcTUX7R-QDQfVoc@mail.gmail.com>
Message-ID: <20101208105643.GO18244@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello,

On Wed, Dec 08, 2010 at 06:52:36PM +0800, Shawn Guo wrote:
> Hi Lothar,
> 
> Thanks for the review.
> 
> On Wed, Dec 8, 2010 at 3:25 PM, Lothar Wa?mann <LW@karo-electronics.de> wrote:
> > Hi,
> >
> > Shawn Guo writes:
> >> MXS-based SoCs implements iomux functions in block PINCTRL.
> >>
> >> Signed-off-by: Shawn Guo <shawn.guo@freescale.com>
> >> ---
> >> Changes for v2:
> >> ?- Define iomux_cfg_t as u64
> > ? ? ^^^^^^^^^^^^^^^^^^^^^^^^^
> > Really?
> >
> >> +typedef struct pad_desc {
> >> + ? ? unsigned bank:12;
> >> + ? ? unsigned pin:20;
> >> + ? ? unsigned muxsel:8;
> >> + ? ? unsigned ma:12;
> >> + ? ? unsigned vol:8;
> >> + ? ? unsigned pull:4;
> >> +} iomux_cfg_t;
> > ^^^^^^^^^^^^^^^^^
> >
> I did not pick the correct word.  What I meant is 64 bits.  Since this
> error is in change log, I would fix it if there is v3 of the patch.
the idea was to really use an u64 to have the pin definitions modifyable.

Best regards
Uwe

-- 
Pengutronix e.K.                           | Uwe Kleine-K?nig            |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
