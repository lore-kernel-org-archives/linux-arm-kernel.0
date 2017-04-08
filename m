From: gregkh@linuxfoundation.org (Greg KH)
Date: Sat, 8 Apr 2017 12:57:35 +0200
Subject: [PATCH 1/3] Fixed checkpatch warning about unaligned function
 params
In-Reply-To: <a7afd06fb8a7e36568e639020c07662692da2589.1490760735.git.sfaragnaus@gmail.com>
References: <cover.1490760735.git.sfaragnaus@gmail.com>
 <a7afd06fb8a7e36568e639020c07662692da2589.1490760735.git.sfaragnaus@gmail.com>
Message-ID: <20170408105735.GA23668@kroah.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Mar 29, 2017 at 06:15:35AM +0100, Andrea della Porta wrote:
> Fixed issues:
> CHECK: Alignment should match open parenthesis
> #71: FILE: drivers/staging/vc04_services/bcm2835-audio/bcm2835-pcm.c:71:
> +       audio_info("alsa_stream=%p substream=%p\n", alsa_stream,
> +               alsa_stream ? alsa_stream->substream : 0);
> 
> CHECK: Alignment should match open parenthesis
> #262: FILE: drivers/staging/vc04_services/bcm2835-audio/bcm2835-pcm.c:262:
> +static int snd_bcm2835_pcm_hw_params(struct snd_pcm_substream *substream,
> +       struct snd_pcm_hw_params *params)
> 
> CHECK: Alignment should match open parenthesis
> #315: FILE: drivers/staging/vc04_services/bcm2835-audio/bcm2835-pcm.c:315:
> +       err = bcm2835_audio_set_params(alsa_stream, channels,
> +               alsa_stream->params_rate,
> 
> CHECK: Alignment should match open parenthesis
> #384: FILE: drivers/staging/vc04_services/bcm2835-audio/bcm2835-pcm.c:384:
> +               audio_debug("bcm2835_AUDIO_TRIGGER_START running=%d\n",
> +                       alsa_stream->running);
> 
> CHECK: Alignment should match open parenthesis
> #391: FILE: drivers/staging/vc04_services/bcm2835-audio/bcm2835-pcm.c:391:
> +                                       bytes_to_frames(runtime,
> +                                       alsa_stream->pos);
> 
> CHECK: Alignment should match open parenthesis
> #436: FILE: drivers/staging/vc04_services/bcm2835-audio/bcm2835-pcm.c:436:
> +       audio_debug("pcm_pointer... (%d) hwptr=%d appl=%d pos=%d\n", 0,
> +               frames_to_bytes(runtime, runtime->status->hw_ptr),
> 
> CHECK: Alignment should match open parenthesis
> #447: FILE: drivers/staging/vc04_services/bcm2835-audio/bcm2835-pcm.c:447:
> +static int snd_bcm2835_pcm_lib_ioctl(struct snd_pcm_substream *substream,
> +       unsigned int cmd, void *arg)
> 
> CHECK: Alignment should match open parenthesis
> #452: FILE: drivers/staging/vc04_services/bcm2835-audio/bcm2835-pcm.c:452:
> +       audio_info(" .. substream=%p, cmd=%d, arg=%p (%x) ret=%d\n", substream,
> +               cmd, arg, arg ? *(unsigned *) arg : 0, ret);
> 
> CHECK: Alignment should match open parenthesis
> #544: FILE: drivers/staging/vc04_services/bcm2835-audio/bcm2835-pcm.c:544:
> +       snd_pcm_lib_preallocate_pages_for_all(pcm, SNDRV_DMA_TYPE_CONTINUOUS,
> +               snd_dma_continuous_data(GFP_KERNEL),
> 
> Signed-off-by: Andrea della Porta <sfaragnaus@gmail.com>
> ---
>  .../vc04_services/bcm2835-audio/bcm2835-pcm.c      | 47 ++++++++++------------
>  1 file changed, 22 insertions(+), 25 deletions(-)

Your email subject lines do not match other patches for this driver
(staging: drivername: file: what is happening).

Please fix up and resend all of these.

Also, no need to put the full checkpatch output in the changelog,
summarize it for us.

thanks,

greg k-h
