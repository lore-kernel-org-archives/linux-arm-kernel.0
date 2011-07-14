From: dongas86@gmail.com (Dong Aisheng)
Date: Fri, 15 Jul 2011 00:15:24 +0800
Subject: [alsa-devel] [PATCH V2 01/10] ASoc: mxs: add mxs-pcm driver
In-Reply-To: <20110714123106.GB1904@pengutronix.de>
References: <1310483085-31442-1-git-send-email-b29396@freescale.com>
	<1310483085-31442-2-git-send-email-b29396@freescale.com>
	<20110714123106.GB1904@pengutronix.de>
Message-ID: <CAA+hA=T7TDrUWnH1ami_1C2btzV_7GVbTU6D-ypSxjaSSFB_bw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

2011/7/14 Wolfram Sang <w.sang@pengutronix.de>:
>
>> +static struct snd_pcm_hardware snd_mxs_hardware = {
>> + ? ? .info ? ? ? ? ? ? ? ? ? = SNDRV_PCM_INFO_MMAP |
>> + ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? SNDRV_PCM_INFO_MMAP_VALID |
>> + ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? SNDRV_PCM_INFO_PAUSE |
>> + ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? SNDRV_PCM_INFO_RESUME |
>> + ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? SNDRV_PCM_INFO_INTERLEAVED,
>> + ? ? .formats ? ? ? ? ? ? ? ?= SNDRV_PCM_FMTBIT_S16_LE |
>> + ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? SNDRV_PCM_FMTBIT_S20_3LE |
>> + ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? SNDRV_PCM_FMTBIT_S24_LE |
>> + ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? SNDRV_PCM_FMTBIT_S32_LE,
>> + ? ? .channels_min ? ? ? ? ? = 2,
>> + ? ? .channels_max ? ? ? ? ? = 2,
>> + ? ? .period_bytes_min ? ? ? = 32,
>> + ? ? .period_bytes_max ? ? ? = 8192,
>> + ? ? .periods_min ? ? ? ? ? ?= 1,
>> + ? ? .periods_max ? ? ? ? ? ?= 255,
>
> When using madplay (for MP3) instead of aplay, I get
>
> [ 3310.010000] mxs-dma mxs-dma-apbx: maximum number of sg exceeded: 128 > 53
> [ 3310.020000] dma dma1chan4: cannot prepare slave dma
>
> So, the mxs-dma limit should be taken into account here.
I also have tried a lot on mp3 playing with madplay, however still have not
met this issue.
Can you tell how can i get the same mp3 as you played?
Maybe it helps me to reproduce this issue.
I will check it tomorrow.
Thanks for the reminder.

>> + ? ? .buffer_bytes_max ? ? ? = 64 * 1024,
>> + ? ? .fifo_size ? ? ? ? ? ? ?= 32,
>> +
>> +};
