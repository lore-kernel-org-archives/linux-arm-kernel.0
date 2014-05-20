From: anarsoul@gmail.com (Vasily Khoruzhick)
Date: Tue, 20 May 2014 16:15:47 +0300
Subject: [PATCH v2 2/2] dmaengine: s3c24xx-dma: Add cyclic transfer support
In-Reply-To: <1400574680.3703.72.camel@smile.fi.intel.com>
References: <1400519158-5801-1-git-send-email-anarsoul@gmail.com>
 <1400519158-5801-2-git-send-email-anarsoul@gmail.com>
 <1400574680.3703.72.camel@smile.fi.intel.com>
Message-ID: <CA+E=qVfsWdENHd5yCiTjb-QE7hDcUF6GiEvFBFbQwvt2wok+NA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, May 20, 2014 at 11:31 AM, Andy Shevchenko
<andriy.shevchenko@linux.intel.com> wrote:
> On Mon, 2014-05-19 at 20:05 +0300, Vasily Khoruzhick wrote:
>> Many audio interface drivers require support of cyclic transfers to work
>> correctly, for example Samsung ASoC DMA driver. This patch adds support
>> for cyclic transfers to the s3c24xx-dma driver
>
> Sorry, not mentioned earlier, but couple of nitpicks below. (I think you
> may wait for more comments and then decide what to do with mine)
>
>> +     dev_dbg(&s3cdma->pdev->dev,
>> +             "prepare cyclic transaction of %d bytes with period %d from %s\n",
>> +             size, period, s3cchan->name);
>
> size and period are size_t, thus %zu.

Ok.

>> +             /* Check last period length */
>> +             if (i == (sg_len - 1))
>
> Redundant parenthesis.

Ok

>> +                     dsg->len = size - (period * i);
>> +             if (direction == DMA_MEM_TO_DEV) {
>> +                     dsg->src_addr = addr + (period * i);
>
> Ditto.

Ok

>> +                     dsg->dst_addr = slave_addr;
>> +             } else { /* DMA_DEV_TO_MEM */
>> +                     dsg->src_addr = slave_addr;
>> +                     dsg->dst_addr = addr + (period * i);
>
> Ditto.

Ok
