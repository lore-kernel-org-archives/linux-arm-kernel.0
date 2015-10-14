From: cedric.madianga@gmail.com (M'boumba Cedric Madianga)
Date: Wed, 14 Oct 2015 10:57:55 +0200
Subject: [PATCH v2 2/4] dmaengine: Add STM32 DMA driver
In-Reply-To: <561E17EA.6000900@linaro.org>
References: <1444745127-1105-1-git-send-email-cedric.madianga@gmail.com>
 <1444745127-1105-3-git-send-email-cedric.madianga@gmail.com>
 <561D1689.90703@linaro.org>
 <CAOAejn1N=dFZ3nQ_hNznJQX1-fkP3r=vdYuWY4OMH65PrW3xVg@mail.gmail.com>
 <561E17EA.6000900@linaro.org>
Message-ID: <CAOAejn2SMDtDa8TmMNeTUb38aqbAQnX5bK9JuMCweV6mKNMKZQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Daniel,

2015-10-14 10:52 GMT+02:00 Daniel Thompson <daniel.thompson@linaro.org>:
> On 14/10/15 08:54, M'boumba Cedric Madianga wrote:
>>>>
>>>> +static int stm32_dma_alloc_chan_resources(struct dma_chan *c)
>>>> +{
>>>> +       struct stm32_dma_chan *chan = to_stm32_dma_chan(c);
>>>> +       struct stm32_dma_device *dmadev = stm32_dma_chan_get_dev(chan);
>>>> +       int ret;
>>>> +
>>>> +       chan->config_init = false;
>>>> +       ret = clk_prepare_enable(dmadev->clk);
>>>> +       if (ret < 0) {
>>>> +               dev_err(chan2dev(chan), "clk_prepare_enable failed:
>>>> %d\n",
>>>> ret);
>>>> +               return ret;
>>>> +       }
>>>> +
>>>> +       ret = stm32_dma_disable_chan(chan);
>>>> +
>>>> +       return ret;
>>>> +}
>>>
>
>
> If stm32_dma_disable_chan() returns an error then we will not restore the
> original the clock counts causing them to "leak".

Ok got it. Thanks for the clarification.
I will fix it in the next version.

BR,
Cedric
