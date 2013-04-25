From: linus.walleij@linaro.org (Linus Walleij)
Date: Thu, 25 Apr 2013 13:14:18 +0200
Subject: [PATCH 17/32] dmaengine: ste_dma40: Remove redundant argument
 from d40_phy_cfg()
In-Reply-To: <20130422101833.GI3432@gmail.com>
References: <1366279934-30761-1-git-send-email-lee.jones@linaro.org>
 <1366279934-30761-18-git-send-email-lee.jones@linaro.org>
 <20130422093423.GD24632@intel.com>
 <20130422101833.GI3432@gmail.com>
Message-ID: <CACRpkdbsH=vZxMcoeW+RJQsLaKAs_Lzx2pGpbT7fO_Hk90x6Gw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Apr 22, 2013 at 12:18 PM, Lee Jones <lee.jones@linaro.org> wrote:

>> > +   if ((cfg->dir ==  STEDMA40_PERIPH_TO_MEM) ||
>> > +       (cfg->dir == STEDMA40_PERIPH_TO_PERIPH)) {
>>
>> Why would you need your own direction defines, I see that there is not much
>> diff between these and what dmaengine defines, so perhpas you could use
>> those?
>
> I agree. I'll speak to the STE folk.

This is because the driver was written before the dmaengine had
the enum dma_transfer_direction.

A simple search-and-replace patch would do the trick...

Yours,
Linus Walleij
