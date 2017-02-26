From: julia.lawall@lip6.fr (Julia Lawall)
Date: Sun, 26 Feb 2017 19:03:00 +0100 (CET)
Subject: [Outreachy kernel] [PATCH] staging: bcm2835-audio: Fixed spacing
 around '&'
In-Reply-To: <1488131271-2908-1-git-send-email-narcisaanamaria12@gmail.com>
References: <1488131271-2908-1-git-send-email-narcisaanamaria12@gmail.com>
Message-ID: <alpine.DEB.2.20.1702261901180.2056@hadrien>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



On Sun, 26 Feb 2017, Narcisa Ana Maria Vasile wrote:

> This was reported by checkpatch.pl
>
> Signed-off-by: Narcisa Ana Maria Vasile <narcisaanamaria12@gmail.com>

Acked-by: Julia Lawall <julia.lawall@lip6.fr>

Actually, the outreachy tutorial says not to send patches to mailing
lists, only to people (except in the case of IIO, where the maintainers
asked for patches to be sent to mailing lists as well).  The
get_maintainer command to use is shown here:

https://kernelnewbies.org/FirstKernelPatch#submit_a_patch

> ---
>  drivers/staging/bcm2835-audio/bcm2835-pcm.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/staging/bcm2835-audio/bcm2835-pcm.c b/drivers/staging/bcm2835-audio/bcm2835-pcm.c
> index 9e79236..328bee4a 100644
> --- a/drivers/staging/bcm2835-audio/bcm2835-pcm.c
> +++ b/drivers/staging/bcm2835-audio/bcm2835-pcm.c
> @@ -91,7 +91,7 @@ void bcm2835_playback_fifo(struct bcm2835_alsa_stream *alsa_stream)
>  		frames_to_bytes(alsa_stream->substream->runtime, alsa_stream->substream->runtime->status->hw_ptr),
>  		new_period);
>  	if (alsa_stream->buffer_size) {
> -		alsa_stream->pos += consumed &~(1 << 30);
> +		alsa_stream->pos += consumed & ~(1 << 30);
>  		alsa_stream->pos %= alsa_stream->buffer_size;
>  	}
>
> --
> 1.9.1
>
> --
> You received this message because you are subscribed to the Google Groups "outreachy-kernel" group.
> To unsubscribe from this group and stop receiving emails from it, send an email to outreachy-kernel+unsubscribe at googlegroups.com.
> To post to this group, send email to outreachy-kernel at googlegroups.com.
> To view this discussion on the web visit https://groups.google.com/d/msgid/outreachy-kernel/1488131271-2908-1-git-send-email-narcisaanamaria12%40gmail.com.
> For more options, visit https://groups.google.com/d/optout.
>
