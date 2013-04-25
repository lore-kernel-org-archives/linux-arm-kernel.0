From: linus.walleij@linaro.org (Linus Walleij)
Date: Thu, 25 Apr 2013 14:51:51 +0200
Subject: [PATCH 13/32] dmaengine: ste_dma40: Calculate number of logical
 channels from physical ones
In-Reply-To: <20130425092930.GI4623@gmail.com>
References: <1366279934-30761-1-git-send-email-lee.jones@linaro.org>
 <1366279934-30761-14-git-send-email-lee.jones@linaro.org>
 <CACRpkdYq9QLRaaysc=izGgi53ogf1oRHuCwWKW+rQBbE_UtfnA@mail.gmail.com>
 <20130425092930.GI4623@gmail.com>
Message-ID: <CACRpkdYywbCeP7wemk2Vy81rm9q3VUbpkN1jUs6UBPLVSOoyHw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Apr 25, 2013 at 11:29 AM, Lee Jones <lee.jones@linaro.org> wrote:
> On Thu, 25 Apr 2013, Linus Walleij wrote:
>
>> On Thu, Apr 18, 2013 at 12:11 PM, Lee Jones <lee.jones@linaro.org> wrote:
>>
>> > This change will cost ~25KB of memory, but it's worth the trade-off,
>> > as it removes a great deal of overhead. It means that instead of only
>> > allocating memory for the logical channels in use, it does so for all
>> > available ones, which is 32 per physical channel. However, this now
>> > means we can remove some platform data and we don't have to worry
>> > about adding vendor specific variables to Device Tree.
>> >
>> > Cc: Vinod Koul <vinod.koul@intel.com>
>> > Cc: Dan Williams <djbw@fb.com>
>> > Cc: Per Forlin <per.forlin@stericsson.com>
>> > Cc: Rabin Vincent <rabin@rab.in>
>> > Signed-off-by: Lee Jones <lee.jones@linaro.org>
>>
>> (...)
>> >  static struct stedma40_platform_data dma40_plat_data = {
>> > -       .dev_len = DB8500_DMA_NR_DEV,
>>
>> So that was set to 64 in the platform...
>>
>> > -       /* Count the number of logical channels in use */
>> > -       for (i = 0; i < plat_data->dev_len; i++)
>> > -               if (plat_data->dev_rx[i] != 0)
>> > -                       num_log_chans++;
>> > -
>> > -       for (i = 0; i < plat_data->dev_len; i++)
>> > -               if (plat_data->dev_tx[i] != 0)
>> > -                       num_log_chans++;
>>
>> And I guess this code snippet made it go down to <= 32 all the time,
>> correct?
>
> However many were described in dma40_[rx|tx]_map, yes.

OK how fragile, but definately not your fault.
Acked-by: Linus Walleij <linus.walleij@linaro.org>

Yours,
Linus Walleij
