From: gregkh@linuxfoundation.org (Greg KH)
Date: Tue, 11 Jul 2017 14:20:23 +0200
Subject: [PATCH] staging: bcm2835-audio: replace BUG_ON with WARN_ON
In-Reply-To: <CAHRz_yZ6OCke+umsprLmfgExe446jXi-Jnexn=t6bi9Jj7vBzQ@mail.gmail.com>
References: <CAHRz_yZ6OCke+umsprLmfgExe446jXi-Jnexn=t6bi9Jj7vBzQ@mail.gmail.com>
Message-ID: <20170711122023.GB21677@kroah.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jul 11, 2017 at 04:54:24PM +0530, karuna grewal wrote:
> replace BUG_ON with WARN_ON as pointed out by checkpatch
> 
> Signed-off-by: Karuna Grewal <karunagrewal98@gmail.com>

I can not accept patches sent in html format...

> ---
> ?drivers/staging/vc04_services/bcm2835-audio/bcm2835-ctl.c | 2 +-
> ?1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/staging/vc04_services/bcm2835-audio/bcm2835-ctl.c b/
> drivers/staging/vc04_services/bcm2835-audio/bcm2835-ctl.c
> index 5ff4b1c..30d310b 100644
> --- a/drivers/staging/vc04_services/bcm2835-audio/bcm2835-ctl.c
> +++ b/drivers/staging/vc04_services/bcm2835-audio/bcm2835-ctl.c
> @@ -93,7 +93,7 @@ static int snd_bcm2835_ctl_get(struct snd_kcontrol *kcontrol,
> ? ? ? ? if (mutex_lock_interruptible(&chip->audio_mutex))
> ? ? ? ? ? ? ? ? return -EINTR;
> 
> -? ? ? ?BUG_ON(!chip && !(chip->avail_substreams & AVAIL_SUBSTREAMS_MASK));
> +? ? ? ?WARN_ON(!chip && !(chip->avail_substreams & AVAIL_SUBSTREAMS_MASK));

Why will this make things better?

thanks,

greg k-h
