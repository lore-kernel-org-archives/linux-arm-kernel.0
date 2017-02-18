From: joe@perches.com (Joe Perches)
Date: Fri, 17 Feb 2017 17:17:56 -0800
Subject: [PATCH 5/5] staging: bcm2835-audio: bcm2835.h: fix line length
 coding style issue
In-Reply-To: <1487362603-15967-5-git-send-email-adanhawthorn@gmail.com>
References: <1487362603-15967-1-git-send-email-adanhawthorn@gmail.com>
 <1487362603-15967-5-git-send-email-adanhawthorn@gmail.com>
Message-ID: <1487380676.2198.11.camel@perches.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, 2017-02-17 at 15:16 -0500, Nathan Howard wrote:
> Fix checkpatch.pl warning of the form "WARNING: line over 80 characters."
[]
> diff --git a/drivers/staging/bcm2835-audio/bcm2835.h b/drivers/staging/bcm2835-audio/bcm2835.h
[]
> @@ -163,8 +163,10 @@ int bcm2835_audio_write(struct bcm2835_alsa_stream *alsa_stream,
>  			unsigned int count,
>  			void *src);
>  void bcm2835_playback_fifo(struct bcm2835_alsa_stream *alsa_stream);
> -unsigned int bcm2835_audio_retrieve_buffers(struct bcm2835_alsa_stream *alsa_stream);
> +unsigned int bcm2835_audio_retrieve_buffers(
> +		struct bcm2835_alsa_stream *alsa_stream);

This is not a good change.

This line exceeds 80 columns only because
it uses very long identifiers (30+ chars).

Anything that uses these very long names
is going to be silly looking when forced
to use 80 column line length maximums.

Basically, it's OK as it is and if you
really want to change it for any reason
the other style to use is to have the
return value on a separate line like:

unsigned int
bcm2836_audio_retrieve_buffers(struct bcm2835_also_stream *alsa_stream);

Even so, that's not a good change either.
