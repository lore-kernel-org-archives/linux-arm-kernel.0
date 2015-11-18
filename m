From: dbrignoli@audioscience.com (Delio Brignoli)
Date: Wed, 18 Nov 2015 09:26:49 +0100
Subject: Minimal support for dm814x
In-Reply-To: <CAALWOA-PjKW9M3qqxum4OqJ3V3AwKaaEDzA17jdZmgUNNE79Wg@mail.gmail.com>
References: <4999BB3D-4BB5-4F7C-96D7-FB687725CDCC@audioscience.com>
 <20151109150602.GR3199@atomide.com>
 <CAALWOA-NUyRYaGbmBZpc6CcFga8_BKPZ9WQTxa3t09bHS_6=qA@mail.gmail.com>
 <7933071D-84FD-4A85-8CD0-CC504CE1D9D1@audioscience.com>
 <20151111174028.GF3218@atomide.com>
 <CAALWOA_dEtajQBLrXesQ2bRCDf-1Dzg_tJw_=yAmaO=T3=KMZQ@mail.gmail.com>
 <20151112174155.GM3218@atomide.com>
 <CAALWOA9o80rhaqwaa6=XxmNN1FcWzHDXiaqkqFVO81CAMX=04w@mail.gmail.com>
 <CAALWOA-29pK=GbNKhdY=4oJzhnueVxNAPruu9Uacqi5vMJN=OA@mail.gmail.com>
 <20151113145216.GC2517@atomide.com>
 <CAALWOA-PjKW9M3qqxum4OqJ3V3AwKaaEDzA17jdZmgUNNE79Wg@mail.gmail.com>
Message-ID: <D5E377BD-5AAE-4302-B2C3-2B17A00892B5@audioscience.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 18 Nov 2015, at 06:22, Matthijs van Duin <matthijsvanduin@gmail.com> wrote:
> The PLL code looks pretty mediocre to me. In particular, they make no
> effort whatsoever to configure an exact ratio. It seems their
> algorithm uses whatever pre divider was already programmed,

I believe the implementors assumed the bootloader was setting up the PLL, its adjustment may have been an afterthought added in order to support PTP.

> This works in principle, but both minimizing the DCO and (often
> needlessly) using the fractional multiplier seem like recipes to
> maximize the clock jitter. Mind you, I don't know how much jitter
> we?re talking about here, I don't recall having seen specs about this.

We haven?t seen any specs either but testing shows that changing DCO mode causes the PLL to lose lock at least temporarily.

?
Delio
