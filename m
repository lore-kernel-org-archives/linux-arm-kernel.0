From: js@sig21.net (Johannes Stezenbach)
Date: Wed, 16 Nov 2011 16:07:22 +0100
Subject: [alsa-devel] [PATCH] ARM: pxa: add support for Raumfeld DDX
In-Reply-To: <4EC3B30F.60403@gmail.com>
References: <1320661562-422-1-git-send-email-zonque@gmail.com>
 <20111115141348.GG3077@opensource.wolfsonmicro.com>
 <4EC3B30F.60403@gmail.com>
Message-ID: <20111116150722.GA15580@sig21.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Nov 16, 2011 at 01:56:47PM +0100, Daniel Mack wrote:
> On 11/15/2011 03:13 PM, Mark Brown wrote:
> > On Mon, Nov 07, 2011 at 11:26:02AM +0100, Daniel Mack wrote:
> > 
> >> +	/* PXA DMA cannot do zero extend for 24bit samples,
> >> +	* thus only 16bit (two samples packet into 32bit word)
> >> +	* or 32bit samples are possible
> >> +	*/
> >> +	snd_pcm_hw_constraint_mask64(substream->runtime,
> >> +				    SNDRV_PCM_HW_PARAM_FORMAT,
> >> +				    SNDRV_PCM_FMTBIT_S16_LE  | SNDRV_PCM_FMTBIT_S16_BE |
> >> +				    SNDRV_PCM_FMTBIT_S32_LE  | SNDRV_PCM_FMTBIT_S32_BE);
> > 
> > If the PXA DMA controller can't do 24 bit audio it should be imposing
> > this constraint.
> 
> Right. Will fix this in the CPU DAI.

IIRC the PXA can handle 24bit audio, and the STA32x can handle it, too.
However due to constraints in the clock ratios on the Raumfeld board
this mode cannot be used.  Thus this constraint is in sound/soc/pxa/raumfeld.c.

Does that make sense?  It's been a while since I worked on this code,
maybe I misremember.  And I failed to mention it in the code comment :-(


Johannes
