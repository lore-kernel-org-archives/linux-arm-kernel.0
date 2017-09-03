From: tiwai@suse.de (Takashi Iwai)
Date: Sun, 03 Sep 2017 09:15:03 +0200
Subject: [alsa-devel] [PATCH v6 01/12] ALSA: ac97: split out the
 generic	ac97 registers
In-Reply-To: <20170902195414.3699-2-robert.jarzmik@free.fr>
References: <20170902195414.3699-1-robert.jarzmik@free.fr>
 <20170902195414.3699-2-robert.jarzmik@free.fr>
Message-ID: <s5hy3pwuubs.wl-tiwai@suse.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, 02 Sep 2017 21:54:03 +0200,
Robert Jarzmik wrote:
> 
> Split out from the ac97_codec.h the ac97 generic registers, which can be
> used by a codec, typically a generic ac97 codec, and by the ac97 bus, to
> scan an ac97 AC-Link.
> 
> This split encompasses all the AC97 standard registers, but not the
> codec specific ones.
> 
> In order to have a clean split between former ac97 bus implementation
> and the new coming one in sound/ac97, it is safer to not include any
> former ac97 includes, excepting in sound/ac97/compat.c.
> 
> Amongst the thing to isolate :
>  - don't have the struct snd_ac97 in sound/ac97/* (except compat.c) to not
>    be "fooled" by a definition which would come with ac97_codec.h by
>    "chance".
>  - don't have to have snd_a97_*() functions, as they rely on struct
>    snd_ac97.
>   - don't want the struct snd_ac97_bus_ops, there is a new one
> 
> Signed-off-by: Robert Jarzmik <robert.jarzmik@free.fr>

Reviewed-by: Takashi Iwai <tiwai@suse.de>


thanks,

Takashi
