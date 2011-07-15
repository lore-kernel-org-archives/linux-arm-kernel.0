From: B29396@freescale.com (Dong Aisheng-B29396)
Date: Fri, 15 Jul 2011 06:30:51 +0000
Subject: [alsa-devel] [PATCH V2 01/10] ASoc: mxs: add mxs-pcm driver
In-Reply-To: <CAA+hA=T7TDrUWnH1ami_1C2btzV_7GVbTU6D-ypSxjaSSFB_bw@mail.gmail.com>
References: <1310483085-31442-1-git-send-email-b29396@freescale.com>
	<1310483085-31442-2-git-send-email-b29396@freescale.com>
	<20110714123106.GB1904@pengutronix.de>
	<CAA+hA=T7TDrUWnH1ami_1C2btzV_7GVbTU6D-ypSxjaSSFB_bw@mail.gmail.com>
Message-ID: <65EE16ACC360FA4D99C96DC085B3F7721CF10E@039-SN1MPN1-002.039d.mgd.msft.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

> -----Original Message-----
> From: Dong Aisheng [mailto:dongas86 at gmail.com]
> Sent: Friday, July 15, 2011 12:15 AM
> To: Wolfram Sang
> Cc: Dong Aisheng-B29396; alsa-devel at alsa-project.org;
> s.hauer at pengutronix.de; broonie at opensource.wolfsonmicro.com; u.kleine-
> koenig at pengutronix.de; lrg at ti.com; linux-arm-kernel at lists.infradead.org
> Subject: Re: [alsa-devel] [PATCH V2 01/10] ASoc: mxs: add mxs-pcm driver
> 
> 2011/7/14 Wolfram Sang <w.sang@pengutronix.de>:
> >
> >> +static struct snd_pcm_hardware snd_mxs_hardware = {
> >> + ? ? .info ? ? ? ? ? ? ? ? ? = SNDRV_PCM_INFO_MMAP |
> >> + ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? SNDRV_PCM_INFO_MMAP_VALID |
> >> + ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? SNDRV_PCM_INFO_PAUSE |
> >> + ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? SNDRV_PCM_INFO_RESUME |
> >> + ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? SNDRV_PCM_INFO_INTERLEAVED,
> >> + ? ? .formats ? ? ? ? ? ? ? ?= SNDRV_PCM_FMTBIT_S16_LE |
> >> + ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? SNDRV_PCM_FMTBIT_S20_3LE |
> >> + ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? SNDRV_PCM_FMTBIT_S24_LE |
> >> + ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? SNDRV_PCM_FMTBIT_S32_LE,
> >> + ? ? .channels_min ? ? ? ? ? = 2,
> >> + ? ? .channels_max ? ? ? ? ? = 2,
> >> + ? ? .period_bytes_min ? ? ? = 32,
> >> + ? ? .period_bytes_max ? ? ? = 8192,
> >> + ? ? .periods_min ? ? ? ? ? ?= 1,
> >> + ? ? .periods_max ? ? ? ? ? ?= 255,
> >
> > When using madplay (for MP3) instead of aplay, I get
> >
> > [ 3310.010000] mxs-dma mxs-dma-apbx: maximum number of sg exceeded:
> > 128 > 53 [ 3310.020000] dma dma1chan4: cannot prepare slave dma
> >
> > So, the mxs-dma limit should be taken into account here.
> I also have tried a lot on mp3 playing with madplay, however still have
> not met this issue.
> Can you tell how can i get the same mp3 as you played?
> Maybe it helps me to reproduce this issue.
> I will check it tomorrow.
> Thanks for the reminder.
> 

Changed to 52 due for periods_max.
        .periods_min            = 1,
-       .periods_max            = 255,
+       .periods_max            = 52,

Thanks.

Regards
Dong Aisheng
