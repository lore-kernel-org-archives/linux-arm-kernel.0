From: J.Lambrecht@TELEVIC.com (=?iso-8859-15?Q?Lambrecht_J=FCrgen?=)
Date: Fri, 8 Jul 2011 16:19:22 +0200
Subject: [RFC PATCH] ARM ASoC: add sound driver for imx27pdk using
	mc13783 codec
In-Reply-To: <201107081611.25998.philippe.retornaz@epfl.ch>
References: <1310131491-625-1-git-send-email-J.Lambrecht@televic.com>
	<201107081611.25998.philippe.retornaz@epfl.ch>
Message-ID: <4E1711EA.5070209@televic.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 07/08/2011 04:11 PM, Philippe R?tornaz wrote:
>
> Le vendredi 8 juillet 2011 15:24:51, J?rgen Lambrecht a ?crit :
> > - Started from sound/soc/imx/phycore-mc13783.c
> > - Renamed to general "imx" because also valid for imx27pdk (3ds) and 
> other
> > 3ds platforms. Or should there be a file per platform?
>
> It's also valid on the mx31moboard platforms. So I guess it make sens 
> to have
> a general name.
>
ok
>
> > - Fixed some issues (add names, add read/write functions, changed
> > late_initcall to module_init, configure clock input pin) - Add debug
> > printing and comments.
> > - Result:
> >   * soundcard detection;
> >   * after creating /dev entries, aplay runs;
> >   * both 'aplay song.wav' and 'madplay song.mp3' give the same error:
> >     a time-out waiting for DMA (ALSA pcm_lib.c:1802: playback write 
> error
> > (DMA or IRQ trouble?)) * this driver uses the DMA method; the FIQ method
> > gives the same error
>
> Does it mean this doesn't work at all to play sound ? IIRC Sascha 
> driver used
> to work with the non-dmaengine implementation on 2.6.34.
>
indeed, doesn't work at all. I know it used to work on 2.6.34.
We also have a fsl linux 2.6.22 were it works.
I must say: when i use aplay to play a mono file, then there is no 
error, it just never ends, and no sound also.
For a stereo file, it gives the error.
Mark also that when I use madplay (v0.15.2) (or mp3play) to play a mono 
or stereo mp3, it allocates 3 DMA channels, but only frees one after the 
error.

J?rgen
>
>
> Thanks,
>
> Philippe
>


-- 
J?rgen Lambrecht
R&D Associate
Tel: +32 (0)51 303045    Fax: +32 (0)51 310670
http://www.televic-rail.com
Televic Rail NV - Leo Bekaertlaan 1 - 8870 Izegem - Belgium
Company number 0825.539.581 - RPR Kortrijk
