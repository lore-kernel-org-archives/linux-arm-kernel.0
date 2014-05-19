From: anarsoul@gmail.com (Vasily Khoruzhick)
Date: Mon, 19 May 2014 18:34:41 +0300
Subject: [PATCH 2/2] dmaengine: s3c24xx-dma: Add cyclic transfer support
In-Reply-To: <1400488830.3703.64.camel@smile.fi.intel.com>
References: <1400445779-17365-1-git-send-email-anarsoul@gmail.com>
 <1400445876-17460-1-git-send-email-anarsoul@gmail.com>
 <1400488830.3703.64.camel@smile.fi.intel.com>
Message-ID: <CA+E=qVfsEQhZqFOjmn1ktGct8Czu_Hv0YCTaFU+oYWODN-bupA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Andy,

On Mon, May 19, 2014 at 11:40 AM, Andy Shevchenko
<andriy.shevchenko@linux.intel.com> wrote:
>> +
>> +     if (direction == DMA_MEM_TO_DEV) {
>> +             txd->disrcc = S3C24XX_DISRCC_LOC_AHB |
>> +                           S3C24XX_DISRCC_INC_INCREMENT;
>> +             txd->didstc = hwcfg;
>> +             slave_addr = s3cchan->cfg.dst_addr;
>> +             txd->width = s3cchan->cfg.dst_addr_width;
>> +     } else if (direction == DMA_DEV_TO_MEM) {
>> +             txd->disrcc = hwcfg;
>> +             txd->didstc = S3C24XX_DIDSTC_LOC_AHB |
>> +                           S3C24XX_DIDSTC_INC_INCREMENT;
>> +             slave_addr = s3cchan->cfg.src_addr;
>> +             txd->width = s3cchan->cfg.src_addr_width;
>> +     } else {
>> +             s3c24xx_dma_free_txd(txd);
>> +             dev_err(&s3cdma->pdev->dev,
>> +                     "direction %d unsupported\n", direction);
>> +             return NULL;
>> +     }
>
> Instead of doing this, you may put few lines on top of function
>
> if (!is_slave_direction) {
>         dev_err(&s3cdma->pdev->dev, "direction %d unsupported\n", direction);
>         return NULL;
> }
>
> As an additional effect you can transform the 'else if' to just 'else' above the code.

Sounds reasonable, will resend v2 in few mins.

Regards
Vasily

> --
> Andy Shevchenko <andriy.shevchenko@intel.com>
> Intel Finland Oy
