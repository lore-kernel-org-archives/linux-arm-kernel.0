From: moinejf@free.fr (Jean-Francois Moine)
Date: Mon, 27 Jan 2014 19:06:41 +0100
Subject: [alsa-devel] [PATCH RFC v3 0/8] Beaglebone-Black HDMI audio
In-Reply-To: <52E686B2.9060806@ti.com>
References: <y> <cover.1390836773.git.jsarha@ti.com>
 <52E6806A.2090109@metafoo.de> <52E686B2.9060806@ti.com>
Message-ID: <20140127190641.273890c6@armhf>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, 27 Jan 2014 18:17:54 +0200
Jyri Sarha <jsarha@ti.com> wrote:

> Support for S16_LE could maybe be added if the tda998x specific codec 
> would fiddle with CTS_N predivider-setting (K select) according to the 
> used sample width. But it appears Cobox plays all the sample formats 
> fine without this change, so the question is if playing around with 
> CTS_N predivider would break already working support there (something to 
> be tested).

Jyri,

Setting

	cts_n = CTS_N_M(3) | CTS_N_K(1);

instead of K(3) in the I2S sequence of tda998x_configure_audio() in the
tda998x driver works fine for me with S16_LE and S24_LE.

Does this solve your problem?

Russell, do you see any problem about this change?

-- 
Ken ar c'henta?	|	      ** Breizh ha Linux atav! **
Jef		|		http://moinejf.free.fr/
