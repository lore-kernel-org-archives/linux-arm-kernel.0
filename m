From: timur@codeaurora.org (Timur Tabi)
Date: Wed, 16 Aug 2017 13:32:44 -0500
Subject: [PATCH 2/3] [v3] pinctrl: qcom: disable GPIO groups with no pins
In-Reply-To: <7c278367-bf3b-6a26-e31f-ee696cb5534e@codeaurora.org>
References: <1501179565-26466-1-git-send-email-timur@codeaurora.org>
 <1501179565-26466-3-git-send-email-timur@codeaurora.org>
 <CACRpkdZj+tnMcEpic6PrQS-qMJDodmc_uFJVudxc=USCTXpyKg@mail.gmail.com>
 <d0b16753-b202-5756-1cba-1cd083af52ed@codeaurora.org>
 <7c278367-bf3b-6a26-e31f-ee696cb5534e@codeaurora.org>
Message-ID: <66bfbee6-245d-fddb-f6cb-a2c3c06ffc9b@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 08/16/2017 01:10 PM, Jiandi An wrote:
> 
> Technically the same check added in msm_gpio_irq_mask() and 
> msm_gpio_irq_unmask() should be added in msm_gpio_irq_ack(), 
> msm_gpio_irq_set_type(), and msm_gpio_irq_set_wake() if it's registered 
> with irq domain.

I assume that if the GPIO is never unmasked, then msm_gpio_irq_ack() 
will never be called.

msm_gpio_irq_set_type() and msm_gpio_irq_set_wake() might be called, so 
I can add checks for those functions.  I'm hoping that won't be 
necessary, however.  The GPIO and IRQ code is too entangled for me to 
figure out whether unclaimed GPIOs can still have their interrupts 
programmed.

-- 
Qualcomm Datacenter Technologies, Inc. as an affiliate of Qualcomm
Technologies, Inc.  Qualcomm Technologies, Inc. is a member of the
Code Aurora Forum, a Linux Foundation Collaborative Project.
