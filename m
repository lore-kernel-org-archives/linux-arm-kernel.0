From: timur@tabi.org (Timur Tabi)
Date: Wed, 13 Nov 2013 08:15:21 -0600
Subject: [alsa-devel] [PATCH] ASoC: fsl-ssi: fix SDMA starvation
In-Reply-To: <20131113133841.GI30263@pengutronix.de>
References: <1384255056-25673-1-git-send-email-mpa@pengutronix.de>
 <52822529.5090502@tabi.org> <20131112132441.GG30263@pengutronix.de>
 <CAOZdJXUWv3_ZV6p9VQ+zYqwUDVQC6BMb-VhVoVtEh1yC23VuTg@mail.gmail.com>
 <20131113121630.GH30263@pengutronix.de> <52837A59.5070508@tabi.org>
 <20131113133841.GI30263@pengutronix.de>
Message-ID: <52838979.7060309@tabi.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Markus Pargmann wrote:
> Is it necessary to keep TDMAE enabled the whole time? In the patch we
> enable it when playback starts and disable when it stops, so the
> communication between DMA and SSI shouldn't be disturbed.

I will have to test it to be sure, but there's a risk that the bit won't 
be set early enough.  I've seen weird problems like that on my board.
