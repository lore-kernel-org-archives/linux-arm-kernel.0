From: padma.kvr@gmail.com (Padma Venkat)
Date: Tue, 5 Mar 2013 11:21:46 +0530
Subject: [PATCH] DMA: PL330: Add check if device tree compatible
In-Reply-To: <201303041258.39222.arnd@arndb.de>
References: <1362374943-29312-1-git-send-email-padma.v@samsung.com>
 <201303041258.39222.arnd@arndb.de>
Message-ID: <CAAgF-Bfw7__aehMT3RBXz4=S7kxd_0frs8v1FqA=gP0Dq5H6hg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Arnd,

On Mon, Mar 4, 2013 at 6:28 PM, Arnd Bergmann <arnd@arndb.de> wrote:
> On Monday 04 March 2013, Padmavathi Venna wrote:
>> +
>> +       if (adev->dev.of_node) {
>> +               ret = of_dma_controller_register(adev->dev.of_node,
>> +                                        of_dma_pl330_xlate, pdmac);
>> +               if (ret) {
>> +                       dev_err(&adev->dev,
>> +                       "unable to register DMA to the generic DT DMA helpers\n");
>> +                       goto probe_err4;
>> +               }
>>         }
>
> Hmm, when I did the same thing in dw_dma, Andy commented that this should
> not be a failure at all, since the device is still usable. Could we
> instead make of_dma_controller_register return silently when it
> gets a NULL of_node?

Ok. I will do that.

Thanks
Padma
>
>         Arnd
