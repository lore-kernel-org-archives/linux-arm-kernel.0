From: moinejf@free.fr (Jean-Francois Moine)
Date: Tue, 28 Jan 2014 10:23:53 +0100
Subject: [alsa-devel] [PATCH RFC v3 0/8] Beaglebone-Black HDMI audio
In-Reply-To: <52E6B42F.4050901@ti.com>
References: <y> <cover.1390836773.git.jsarha@ti.com>
 <52E6806A.2090109@metafoo.de> <52E686B2.9060806@ti.com>
 <20140127190641.273890c6@armhf> <52E6B42F.4050901@ti.com>
Message-ID: <20140128102353.48e8fb51@armhf>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, 27 Jan 2014 21:31:59 +0200
Jyri Sarha <jsarha@ti.com> wrote:

> I would suggest to leave the CTS_N_K to the current setting (3), unless 
> we can change the CTS_N_K on the fly according to the used sample format.

Yes, this is possible:

- the tda998x codec may call the tda998x hdmi in the hw_params()
  function, i.e. when the sample format is known, and then,

- the tda998x_audio_update() function may have the audio parameters
  (struct snd_pcm_hw_params) as an argument, and CTS_N_K may be set
  to either 1, 2 or 3 for SNDRV_PCM_FORMAT_S16_LE / S24_LE and S32_LE.

This is working in my machine. Would it also work for you?

-- 
Ken ar c'henta?	|	      ** Breizh ha Linux atav! **
Jef		|		http://moinejf.free.fr/
