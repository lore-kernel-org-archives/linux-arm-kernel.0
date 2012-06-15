From: zhangfei.gao@gmail.com (zhangfei gao)
Date: Fri, 15 Jun 2012 11:02:02 +0800
Subject: [alsa-devel] [PATCH v2 1/5] dmaengine: mmp_tdma: add mmp tdma
 support
In-Reply-To: <1339670638.1927.1641.camel@vkoul-udesk3>
References: <1339409081-10097-1-git-send-email-zhangfei.gao@marvell.com>
 <1339409081-10097-2-git-send-email-zhangfei.gao@marvell.com>
 <1339670638.1927.1641.camel@vkoul-udesk3>
Message-ID: <CAMj5Bkhz8UPxRT6B6v8Ds-jPqXBnOCSgd6nUKx9e+x3SZwxRQw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Jun 14, 2012 at 6:43 PM, Vinod Koul <vinod.koul@linux.intel.com> wrote:
> On Mon, 2012-06-11 at 18:04 +0800, Zhangfei Gao wrote:
>> +static int mmp_tdma_clear_chan_irq(struct mmp_tdma_chan *tdmac)
>> +{
>> + ? ? ? u32 reg = readl(tdmac->reg_base + TDISR);
>> +
>> + ? ? ? if (reg & TDISR_COMP) {
>> + ? ? ? ? ? ? ? /* clear irq */
>> + ? ? ? ? ? ? ? reg &= ~TDISR_COMP;
>> + ? ? ? ? ? ? ? writel(reg, tdmac->reg_base + TDISR);
>> +
>> + ? ? ? ? ? ? ? return 0;
>> + ? ? ? }
>> + ? ? ? return -1;
>> +}
> -1?
> Please return a proper linux error code.

Thanks Vinod for careful review, my mistake, will resend the patch.

> http://mailman.alsa-project.org/mailman/listinfo/alsa-devel
