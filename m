From: zhangfei.gao@gmail.com (zhangfei gao)
Date: Tue, 19 Jun 2012 20:21:27 +0800
Subject: [alsa-devel] [PATCH v2 1/5] dmaengine: mmp_tdma: add mmp tdma
 support
In-Reply-To: <1339670638.1927.1641.camel@vkoul-udesk3>
References: <1339409081-10097-1-git-send-email-zhangfei.gao@marvell.com>
 <1339409081-10097-2-git-send-email-zhangfei.gao@marvell.com>
 <1339670638.1927.1641.camel@vkoul-udesk3>
Message-ID: <CAMj5Bkh+DeQCVc5OVMUwxxsMUGMaGz5=BxA_9gd-FcyYtGH6=w@mail.gmail.com>
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
>
>
> --
> ~Vinod

Hi, Vinod

The patch is updated, would you mind take a look, thanks.
