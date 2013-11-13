From: mpa@pengutronix.de (Markus Pargmann)
Date: Wed, 13 Nov 2013 13:16:30 +0100
Subject: [alsa-devel] [PATCH] ASoC: fsl-ssi: fix SDMA starvation
In-Reply-To: <CAOZdJXUWv3_ZV6p9VQ+zYqwUDVQC6BMb-VhVoVtEh1yC23VuTg@mail.gmail.com>
References: <1384255056-25673-1-git-send-email-mpa@pengutronix.de>
 <52822529.5090502@tabi.org> <20131112132441.GG30263@pengutronix.de>
 <CAOZdJXUWv3_ZV6p9VQ+zYqwUDVQC6BMb-VhVoVtEh1yC23VuTg@mail.gmail.com>
Message-ID: <20131113121630.GH30263@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On Tue, Nov 12, 2013 at 02:17:34PM -0600, Timur Tabi wrote:
> On Tue, Nov 12, 2013 at 7:24 AM, Markus Pargmann <mpa@pengutronix.de> wrote:
> >
> > No, I don't have access on PowerPC hardware, so I didn't test it on
> > PowerPC.
> 
> Can you change the code so that the interrupts are enabled only on
> i.MX?  On PowerPC, the interrupts are used only for debugging.

Why is this necessary? The interrupts were enabled for all
architectures before.

However, this patch is wrong as J?rgen mentioned, the SIER_FLAGS are
written to the SIER register after we enable the DMA enable bits which
leads to missing DMA enable bits at the end.
I created a new patch to cleanup the whole interrupt flag setup. I will
post it later.

Regards,

Markus

-- 
Pengutronix e.K.                           |                             |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
Peiner Str. 6-8, 31137 Hildesheim, Germany | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
