From: moinejf@free.fr (Jean-Francois Moine)
Date: Wed, 2 Jul 2014 19:51:54 +0200
Subject: [PATCH] ASoC: tda998x: add a codec to the HDMI transmitter
In-Reply-To: <20140702165628.GO20799@lunn.ch>
References: <20140702183841.7c964832@armhf>
	<20140702165628.GO20799@lunn.ch>
Message-ID: <20140702195154.47d6f6b4@armhf>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, 2 Jul 2014 18:56:28 +0200
Andrew Lunn <andrew@lunn.ch> wrote:

> How well will this work with Russell concept of a front end and two
> backends? Can you uses your CODEC twice, once with the I2S backend and
> a second time with the S/PDIF backend?

Hi Andrew,

The TDA998x CODEC has two functions:
- it sets the possible formats and rates when the screen connects and
- it sets the audio input port when audio streaming starts.

I tested this CODEC with both DAPM and DPCM. If the audio subsystem
asks for streaming on both I2S and S/PDIF, only the last call is served
(this depends on the order of the DAI links in the audio card creation
table).

As I told to Russell, DPCM just asks for a 'system' DAI (front-end),
but it also asks for some additional code in the kirkwood DMA driver
because all PCMs are activated on streaming start.

-- 
Ken ar c'henta?	|	      ** Breizh ha Linux atav! **
Jef		|		http://moinejf.free.fr/
