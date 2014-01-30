From: jsarha@ti.com (Jyri Sarha)
Date: Thu, 30 Jan 2014 14:20:56 +0200
Subject: [alsa-devel] [PATCH RFC v3 0/8] Beaglebone-Black HDMI audio
In-Reply-To: <20140128102353.48e8fb51@armhf>
References: <y>	<cover.1390836773.git.jsarha@ti.com>	<52E6806A.2090109@metafoo.de>	<52E686B2.9060806@ti.com>	<20140127190641.273890c6@armhf>	<52E6B42F.4050901@ti.com>
 <20140128102353.48e8fb51@armhf>
Message-ID: <52EA43A8.9050909@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 01/28/2014 11:23 AM, Jean-Francois Moine wrote:
> On Mon, 27 Jan 2014 21:31:59 +0200
> Jyri Sarha <jsarha@ti.com> wrote:
>
>> I would suggest to leave the CTS_N_K to the current setting (3), unless
>> we can change the CTS_N_K on the fly according to the used sample format.
>
> Yes, this is possible:
>
> - the tda998x codec may call the tda998x hdmi in the hw_params()
>    function, i.e. when the sample format is known, and then,
>
> - the tda998x_audio_update() function may have the audio parameters
>    (struct snd_pcm_hw_params) as an argument, and CTS_N_K may be set
>    to either 1, 2 or 3 for SNDRV_PCM_FORMAT_S16_LE / S24_LE and S32_LE.
>
> This is working in my machine. Would it also work for you?
>

I am having trouble getting the tda998x-codec working on BBB. The 
problem is I do not have a DT node for the tda998x driver. Instead I 
have tilcdc-slave node that provides pdata for the tda-driver.

I am thinking of solving the problem by adding a reference to the 
i2c-adapter hosting tda998x as an optional DT property to the codec 
node. I could then dig the driver instance from the i2c adapter's 
children. Any better ideas?

Best regards,
Jyri
