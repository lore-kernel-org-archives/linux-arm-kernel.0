From: zhangfei.gao@gmail.com (zhangfei gao)
Date: Thu, 7 Jun 2012 18:44:20 +0800
Subject: [alsa-devel] [PATCH v1 2/5] ASoC: mmp: add audio dma support
In-Reply-To: <1339063547.1927.63.camel@vkoul-udesk3>
References: <1338791851-21038-1-git-send-email-zhangfei.gao@marvell.com>
 <1338791851-21038-3-git-send-email-zhangfei.gao@marvell.com>
 <1339061042.1927.61.camel@vkoul-udesk3>
 <CAMj5Bkj+4qQqoDgz_d7eLK+QuVm41fnN5204tRpJ8NKrNsAjcg@mail.gmail.com>
 <1339063547.1927.63.camel@vkoul-udesk3>
Message-ID: <CAMj5BkhtHaF=b=VDMoif_RxWR_Wdxc7qMpjH-SBO=yoA4W9LTA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Jun 7, 2012 at 6:05 PM, Vinod Koul <vinod.koul@linux.intel.com> wrote:
> On Thu, 2012-06-07 at 17:59 +0800, zhangfei gao wrote:
>> On Thu, Jun 7, 2012 at 5:24 PM, Vinod Koul <vinod.koul@linux.intel.com> wrote:
>> > On Mon, 2012-06-04 at 14:37 +0800, Zhangfei Gao wrote:
>> >> mmp-pcm handle audio dma based on soc-dmaengine
>> >> Support mmp and pxa910
>> > See soc-dmaengine.c. You sneed to use the library to use dmaengine.
>> >
>>
>> Thanks Vinod for kind review.
>>
>> Some confusion, only find sound/soc/soc-dmaengine-pcm.c.
>> So the driver base on the library, snd_dmaengine_pcm_open/close etc.
>> Replacing dma_request_channel etc.
>>
>> Is it right direction?
> Yes your driver should use it. See examples in other soc drivers

This driver already been ported to soc-dmaengine-pcm.c, refer
mxs-pcm.c and imx-pcm-dma-mx2.c.
Using snd_dmaengine_pcm_open, snd_dmaengine_pcm_close, etc.
Only exception is dmaengine_slave_config, since we have some specific config.

>
>
> --
> ~Vinod
>
