From: B29396@freescale.com (Dong Aisheng-B29396)
Date: Wed, 13 Jul 2011 03:20:03 +0000
Subject: [PATCH V2 01/10] ASoc: mxs: add mxs-pcm driver
In-Reply-To: <20110712232719.GB17710@opensource.wolfsonmicro.com>
References: <1310483085-31442-1-git-send-email-b29396@freescale.com>
	<1310483085-31442-2-git-send-email-b29396@freescale.com>
	<20110712232719.GB17710@opensource.wolfsonmicro.com>
Message-ID: <65EE16ACC360FA4D99C96DC085B3F7721CD59D@039-SN1MPN1-002.039d.mgd.msft.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

> -----Original Message-----
> From: Mark Brown [mailto:broonie at opensource.wolfsonmicro.com]
> Sent: Wednesday, July 13, 2011 7:27 AM
> To: Dong Aisheng-B29396
> Cc: alsa-devel at alsa-project.org; linux-arm-kernel at lists.infradead.org;
> lrg at ti.com; s.hauer at pengutronix.de; u.kleine-koenig at pengutronix.de
> Subject: Re: [PATCH V2 01/10] ASoc: mxs: add mxs-pcm driver
> 
> On Tue, Jul 12, 2011 at 11:04:36PM +0800, Dong Aisheng wrote:
> 
> > +	if (dai->driver->capture.channels_min) {
> > +		ret = mxs_pcm_preallocate_dma_buffer(pcm,
> > +			SNDRV_PCM_STREAM_CAPTURE);
> > +		if (ret)
> > +			goto out;
> > +	}
> 
> For robustness replace the channels_min check with a check for the
> relevant substream being present (see pxa2xx-pcm.c for a recent example).
Thanks for the reminder.
I will check it.

Regards
Dong Aisheng
