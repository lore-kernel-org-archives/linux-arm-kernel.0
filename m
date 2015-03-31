From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Tue, 31 Mar 2015 10:16:03 +0100
Subject: [PATCH RFC 09/11] sound/core: add IEC958 channel status helper
In-Reply-To: <1427793034.2969.17.camel@pengutronix.de>
References: <20150330193911.GM24899@n2100.arm.linux.org.uk>
 <E1YcfYA-0002vc-Al@rmk-PC.arm.linux.org.uk>
 <1427793034.2969.17.camel@pengutronix.de>
Message-ID: <20150331091603.GQ24899@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Mar 31, 2015 at 11:10:34AM +0200, Philipp Zabel wrote:
> This fails to build for me on 4.0-rc6:
> make[2]: *** No rule to make target 'sound/core/snd-pcm-iec958.o', needed by 'sound/core/snd-pcm.o'.  Stop.
> scripts/Makefile.build:403: recipe for target 'sound/core' failed

Yes, I originally had this as a separate module, but decided it was silly,
so put it in the main snd-pcm module instead.

Naturally, it builds for me because the target object exists in my build
tree from the first way...

> --- a/sound/core/Makefile
> +++ b/sound/core/Makefile
> @@ -14,12 +14,11 @@ snd-pcm-y := pcm.o pcm_native.o pcm_lib.o pcm_timer.o pcm_misc.o \
>                 pcm_memory.o memalloc.o
>  snd-pcm-$(CONFIG_SND_DMA_SGBUF) += sgbuf.o
>  snd-pcm-$(CONFIG_SND_PCM_ELD) += pcm_drm_eld.o
> -snd-pcm-$(CONFIG_SND_PCM_IEC958) += snd-pcm-iec958.o
> +snd-pcm-$(CONFIG_SND_PCM_IEC958) += pcm_iec958.o
>  
>  # for trace-points
>  CFLAGS_pcm_lib.o := -I$(src)
>  
> -snd-pcm-iec958-objs := pcm_iec958.o
>  snd-pcm-dmaengine-objs := pcm_dmaengine.o
>  
>  snd-rawmidi-objs  := rawmidi.o

Yep, that's obviously what I wanted - good catch, thanks!

-- 
FTTC broadband for 0.8mile line: currently at 10.5Mbps down 400kbps up
according to speedtest.net.
