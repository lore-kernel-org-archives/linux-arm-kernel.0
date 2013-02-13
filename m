From: haojian.zhuang@linaro.org (Haojian Zhuang)
Date: Wed, 13 Feb 2013 22:55:59 +0800
Subject: [PATCH v2 02/10] gpio: pxa: avoid to use global irq base
In-Reply-To: <511BA0AF.8040904@compulab.co.il>
References: <1359886551-20950-1-git-send-email-haojian.zhuang@linaro.org>
 <1359886551-20950-3-git-send-email-haojian.zhuang@linaro.org>
 <511BA0AF.8040904@compulab.co.il>
Message-ID: <CAD6h2NRO6N1pRfq_=ybj5TSwC7gieYOffcQmfTyUiP5R_3fWig@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 13 February 2013 22:18, Igor Grinberg <grinberg@compulab.co.il> wrote:
> On 02/03/13 12:15, Haojian Zhuang wrote:
>> Avoid to use global irq_base in gpio-pxa driver. Define irq_base in each
>> pxa_gpio_chip instead. Then we can avoid to use macro PXA_GPIO_TO_IRQ() &
>> MMP_GPIO_TO_IRQ().
>>
>> Signed-off-by: Haojian Zhuang <haojian.zhuang@linaro.org>
>
> Ok. This patch breaks the NFS root on my PXA based systems.
> I still haven't found the cause of the breakage.
>

It's so strange. I tested it OK on pxa910 without DT. Could you help
to check whether your GPIO interrupt still works?

Regards
Haojian
