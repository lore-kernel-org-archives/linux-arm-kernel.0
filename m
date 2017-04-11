From: gregkh@linuxfoundation.org (Greg Kroah-Hartman)
Date: Tue, 11 Apr 2017 16:15:23 +0200
Subject: [PATCH v3 1/2] staging: vc04_services: bcm2835-audio:
 bcm2835-pcm.c Fixed checkpatch warning about unaligned function params
In-Reply-To: <2b55563dd9824e6f9d45b174f1eccd301fccc2d5.1491693395.git.sfaragnaus@gmail.com>
References: <cover.1491693395.git.sfaragnaus@gmail.com>
 <2b55563dd9824e6f9d45b174f1eccd301fccc2d5.1491693395.git.sfaragnaus@gmail.com>
Message-ID: <20170411141523.GA15891@kroah.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, Apr 09, 2017 at 12:25:25AM +0100, Andrea della Porta wrote:
> Fixed unaligned function parameters issues, as per checkpatch warning
> 
> Signed-off-by: Andrea della Porta <sfaragnaus@gmail.com>
> ---
> Changes in v3:
> - rebased on staging-testing
> 
>  .../vc04_services/bcm2835-audio/bcm2835-pcm.c      | 43 ++++++++++------------
>  1 file changed, 20 insertions(+), 23 deletions(-)
> 
> diff --git a/drivers/staging/vc04_services/bcm2835-audio/bcm2835-pcm.c b/drivers/staging/vc04_services/bcm2835-audio/bcm2835-pcm.c
> index e8cf0b9..a2cc09a 100644
> --- a/drivers/staging/vc04_services/bcm2835-audio/bcm2835-pcm.c
> +++ b/drivers/staging/vc04_services/bcm2835-audio/bcm2835-pcm.c
> @@ -67,7 +67,7 @@ void bcm2835_playback_fifo(struct bcm2835_alsa_stream *alsa_stream)
>  
>  
>  	audio_info("alsa_stream=%p substream=%p\n", alsa_stream,
> -		alsa_stream ? alsa_stream->substream : 0);
> +		   alsa_stream ? alsa_stream->substream : 0);
>  
>  	if (alsa_stream->open)
>  		consumed = bcm2835_audio_retrieve_buffers(alsa_stream);
> @@ -82,10 +82,10 @@ void bcm2835_playback_fifo(struct bcm2835_alsa_stream *alsa_stream)
>  			new_period = 1;
>  	}
>  	audio_debug("updating pos cur: %d + %d max:%d period_bytes:%d, hw_ptr: %d new_period:%d\n",
> -		alsa_stream->pos,
> +		    alsa_stream->pos,
>  		consumed,
>  		alsa_stream->buffer_size,
> -		(int) (alsa_stream->period_size * alsa_stream->substream->runtime->periods),
> +		(int)(alsa_stream->period_size * alsa_stream->substream->runtime->periods),

That's not an "alignment" change :(

>  		frames_to_bytes(alsa_stream->substream->runtime, alsa_stream->substream->runtime->status->hw_ptr),
>  		new_period);
>  	if (alsa_stream->buffer_size) {
> @@ -224,6 +224,7 @@ static int snd_bcm2835_playback_close(struct snd_pcm_substream *substream)
>  	 */
>  	if (alsa_stream->running) {
>  		int err;
> +

Nor is this :(

Only do what your say your patch is doing, otherwise it makes reviewers
mad...

thanks,

greg k-h
