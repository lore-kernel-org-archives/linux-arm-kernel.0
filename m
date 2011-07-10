From: dongas86@gmail.com (Dong Aisheng)
Date: Sun, 10 Jul 2011 14:28:26 +0800
Subject: [PATCH 01/10] ASoc: mxs: add mxs-pcm driver
In-Reply-To: <20110709023358.GB26900@sirena.org.uk>
References: <1310140790-2132-1-git-send-email-b29396@freescale.com>
	<1310140790-2132-2-git-send-email-b29396@freescale.com>
	<20110709023358.GB26900@sirena.org.uk>
Message-ID: <CAA+hA=ROnBkLFbZgvbP_XtmbqALKGBqLbZXquxe-HYOg-xhJqg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

2011/7/9 Mark Brown <broonie@opensource.wolfsonmicro.com>:
> On Fri, Jul 08, 2011 at 11:59:41PM +0800, Dong Aisheng wrote:
>> Signed-off-by: Dong Aisheng <b29396@freescale.com>
>
> *Always* CC maintainers on patches.
Sorry for missed it.
Will add in patch v2.
Thanks a lot for the review.

>> + * Copyright (C) 2011 Freescale Semiconductor, Inc. All Rights Reserved.
>> + *
>> + * Refer to sound/soc/imx/imx-pcm-dma-mx2.c
>
> Why?
Just with the reference of  imx-pcm-dma-mx2.c code.

>> + ? ? iprtd->buf = (unsigned int *)substream->dma_buffer.area;
>
> This cast looks incredibly suspicious...
Will remove the cast.

>> +static int snd_mxs_pcm_prepare(struct snd_pcm_substream *substream)
>> +{
>> + ? ? return 0;
>> +}
>> +
>
> Remove empty functions.
Will clean up it.

>> +static int snd_mxs_pcm_trigger(struct snd_pcm_substream *substream, int cmd)
>> +{
>> + ? ? struct snd_pcm_runtime *runtime = substream->runtime;
>> + ? ? struct mxs_pcm_runtime_data *iprtd = runtime->private_data;
>> +
>> + ? ? switch (cmd) {
>> + ? ? case SNDRV_PCM_TRIGGER_START:
>> + ? ? case SNDRV_PCM_TRIGGER_RESUME:
>> + ? ? case SNDRV_PCM_TRIGGER_PAUSE_RELEASE:
>> + ? ? ? ? ? ? dmaengine_submit(iprtd->desc);
>> +
>> + ? ? ? ? ? ? break;
>> +
>
> Why the random blank line?
Sorry for the typo, WIll remove.

>> +static struct platform_driver mxs_pcm_driver = {
>> + ? ? .driver = {
>> + ? ? ? ? ? ? ? ? ? ? .name = "mxs-pcm-audio",
>> + ? ? ? ? ? ? ? ? ? ? .owner = THIS_MODULE,
>
> Indentation here is very odd...
Will fix in the next patch.

> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel at lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
>
