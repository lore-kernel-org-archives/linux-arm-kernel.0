From: joe@perches.com (Joe Perches)
Date: Fri, 10 Feb 2017 09:18:46 -0800
Subject: [PATCH] staging: bcm2835-audio: fix trailing statements
In-Reply-To: <20170210161425.5711-1-abdallah.meziti.pro@gmail.com>
References: <20170210161425.5711-1-abdallah.meziti.pro@gmail.com>
Message-ID: <1486747126.2192.7.camel@perches.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, 2017-02-10 at 17:14 +0100, AbdAllah-MEZITI wrote:
> Trailing statements should be on next line.
[]
> diff --git a/drivers/staging/bcm2835-audio/bcm2835-vchiq.c b/drivers/staging/bcm2835-audio/bcm2835-vchiq.c
[]
> @@ -563,7 +563,8 @@ int bcm2835_audio_set_ctls(struct bcm2835_chip *chip)
>  			} else if (bcm2835_audio_set_ctls_chan(chip->alsa_stream[i], chip) != 0) {
>  				LOG_ERR("Couldn't set the controls for stream %d\n", i);
>  				ret = -1;
> -			} else LOG_DBG(" Controls set for stream %d\n", i);
> +			} else
> +				LOG_DBG(" Controls set for stream %d\n", i);
>  		}
>  	}
>  	LOG_DBG(" .. OUT ret=%d\n", ret);

It's curious that checkpatch doesn't catch this and
ideally this would also use braces for the last else.
