From: voice.shen@atmel.com (Bo Shen)
Date: Fri, 19 Oct 2012 14:56:51 +0800
Subject: dts: question about how to configure PIO used as i2c irq
In-Reply-To: <507BC449.6070203@atmel.com>
References: <507B7AC3.7090904@gmail.com>
 <20121015055720.GQ12801@game.jcrosoft.org> <507BC449.6070203@atmel.com>
Message-ID: <5080F9B3.5090708@atmel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi J,

On 10/15/2012 16:07, Nicolas Ferre wrote:
> On 10/15/2012 07:57 AM, Jean-Christophe PLAGNIOL-VILLARD :
>> On 10:53 Mon 15 Oct     , Bo Shen wrote:
>>> Hi All,
>>>    When moving atmel qt1070 linux driver with DT support. The atmel
>>> qt1070 is an I2C device. I meet the following questions.
>>>
>>>    The qt1070 DT node
>>>    --<--------------
>>>    qt1070: keyboard at 1b {
>>>          compatible = "atmel,qt1070";
>>>          reg = <0x1b>;
>>>          interrupt-parent = <&pioA>;
>>>          interrupts = <7 0x0>;
>>>    };
>>>    -->--------------
>>>
>>>    DT will parse this node and map irq, the i2c_client->irq. This can
>>> be used directly in atmel qt1070 driver. However, the PIO which used
>>> as irq need configure as a PIO input. Now, we can not use
>>> irq_to_gpio() function to convert irq to gpio. So, if we can not
>>> configure this gpio.
>>>
>>>    If we configure the pio in board-dt.c, I think this is not a good
>>> place. For example, if the kernel image support multiplatform, while
>>> on these platform, using different pio for qt1070, so this will
>>> cause only one platform can use qt1070.
>>>
>>>    So, for this question, how should I solve it? Would you please
>>> give me some advice?
>> I already reply you in private 4 times
>
> Yes, but maybe it is because it was not well explained, or not developed
> to the proper extend... So, please do not make these remarks: if the
> conversation was private, it is not necessary to recall that here. Maybe
> Voice is looking for help from someone else?
>
>> you have only 2 choice pass the gpio and manage in c
>> or configure the gpio as input in the xlate or map of the gpio drivers and the
>> mux via pinctrl
>
> Can you please develop a bit more: which xlate? How to tell the gpio
> driver about the map? Can you provide an example?

Any information for this? Search with google, I don't find any useful 
information.

> Bye,
>
