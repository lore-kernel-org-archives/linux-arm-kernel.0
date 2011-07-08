From: philippe.retornaz@epfl.ch (Philippe =?iso-8859-15?q?R=E9tornaz?=)
Date: Fri, 8 Jul 2011 16:11:25 +0200
Subject: [RFC PATCH] ARM ASoC: add sound driver for imx27pdk using mc13783
	codec
In-Reply-To: <1310131491-625-1-git-send-email-J.Lambrecht@televic.com>
References: <1310131491-625-1-git-send-email-J.Lambrecht@televic.com>
Message-ID: <201107081611.25998.philippe.retornaz@epfl.ch>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Le vendredi 8 juillet 2011 15:24:51, J?rgen Lambrecht a ?crit :
> - Started from sound/soc/imx/phycore-mc13783.c
> - Renamed to general "imx" because also valid for imx27pdk (3ds) and other
> 3ds platforms. Or should there be a file per platform?

It's also valid on the mx31moboard platforms. So I guess it make sens to have 
a general name.

> - Fixed some issues (add names, add read/write functions, changed
> late_initcall to module_init, configure clock input pin) - Add debug
> printing and comments.
> - Result:
>   * soundcard detection;
>   * after creating /dev entries, aplay runs;
>   * both 'aplay song.wav' and 'madplay song.mp3' give the same error:
>     a time-out waiting for DMA (ALSA pcm_lib.c:1802: playback write error
> (DMA or IRQ trouble?)) * this driver uses the DMA method; the FIQ method
> gives the same error

Does it mean this doesn't work at all to play sound ? IIRC Sascha driver used 
to work with the non-dmaengine implementation on 2.6.34.

Thanks,

Philippe
