From: cedric.madianga@gmail.com (M'boumba Cedric Madianga)
Date: Wed, 14 Oct 2015 17:26:04 +0200
Subject: [PATCH v2 2/4] dmaengine: Add STM32 DMA driver
In-Reply-To: <561E658D.1070900@linaro.org>
References: <1444745127-1105-1-git-send-email-cedric.madianga@gmail.com>
 <1444745127-1105-3-git-send-email-cedric.madianga@gmail.com>
 <561D1689.90703@linaro.org>
 <CAOAejn1N=dFZ3nQ_hNznJQX1-fkP3r=vdYuWY4OMH65PrW3xVg@mail.gmail.com>
 <CAOAejn2pcFSn3Hf=j6zgg6Ui6GjJZrtRch6ywByHaVLsTLMk6A@mail.gmail.com>
 <561E58AC.80207@linaro.org>
 <CAOAejn1XqvZDmCgGr5rmZoz2EzFUyxtmpSm0_atLr81rSJrEcw@mail.gmail.com>
 <561E658D.1070900@linaro.org>
Message-ID: <CAOAejn1spB+BCRh9+jJtaKxEmaRc04nveF3rQEbT7kLMH0kOkg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

2015-10-14 16:24 GMT+02:00 Daniel Thompson <daniel.thompson@linaro.org>:
>
> Hmnnn...
>
> The dmaengine framework will WARN_ONCE() if an dmaengine is removed whilst
> it is active and also works hard to ensure dmaengine modules are not removed
> whilst there are active drivers using the framework.
>
> How do we get into this function whilst there is still an active DMA
> channels?

For example, when a user try "rmmod stm32-dma" in uart console.
It will enter in stm32_dma_remove while there is potentially still active DMA.

>
>
>> But even with this improvement, I think I have to disable the clock here.
>
>
> As above, I think the dmaengine framework work to protect you from this sort
> problem. However even if I am wrong about that then unconditionally calling
> clk_disable_unprepare() can not be used to reliably manage the clocks. You
> don't know what the counts are!

Ok got it. Thanks for the clarification.

Cedric
