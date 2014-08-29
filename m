From: huangtao@rock-chips.com (Huang Tao)
Date: Fri, 29 Aug 2014 20:08:44 +0800
Subject: [PATCH v3 1/4] thermal: rockchip: add driver for thermal
In-Reply-To: <CAC-25o-winy6jVjh9_hQ-t2VO2UfxG67pW5DpOve8A2o39EJSw@mail.gmail.com>
References: <1409187562-12370-1-git-send-email-caesar.wang@rock-chips.com>	<2852853.mfRZfFVSev@wuerfel>	<20140828143733.GA18084@developer>	<3440260.edal29kzlR@diego>	<2014082909531345696848@rock-chips.com>
 <CAC-25o-winy6jVjh9_hQ-t2VO2UfxG67pW5DpOve8A2o39EJSw@mail.gmail.com>
Message-ID: <54006D4C.2070404@rock-chips.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Dear Eduardo Bezerra Valentin:

? 2014?08?29? 19:39, edubezval at gmail.com ??:
> Hello Zhao,
>
> On Thu, Aug 28, 2014 at 9:54 PM, ??? <zyf@rock-chips.com> wrote:
>> Hi Heiko?
>>
>>    The TS-ADC on RK3288 has two component, a tsadc and a tsadc controller.
>> The tsadc controller is similar like the thermal manager unit on other SOCs.
>> We followed the naming of 3066, but not named as the Thermal Manager.
>>
>>    Moreover,there is only one set of apb registers to access the tsadc
>> controller,and the tsadc is controlled by the tsadc controller,could not
>> access directly. If we write a general tsadc driver by accessed tsadc
>> controller registers, and it hardly to write a driver for the tsadc
>> controller.
> As suggested by Arnd, you can use the generic driver as interface
> between thermal framework and IIO layer. The driver you are going to
> write to your ADC is going to be in the IIO subsystem. The only
> difference is that the generic driver would work for any ADC driver in
> the IIO subsystem.
> https://lkml.org/lkml/2014/2/5/810
>
> In fact, there is already a generic driver. We just need to get it up
> to date.  I see some testing has been already done, and results sound
> promising.
This iio_thermal driver only support get temperature from the ADC IIO
channel.
It dose not support any advanced feature such as configure the
temperature when system should be reset.
So if we adapt it, we will access the register form both TSADC IIO
driver and  thermal driver.
I don't thank this is a good ideal.

In fact, we should ignore the "ADC" stuff. This sensor use ADC internal,
but it is transparent to software, especially in automatic mode.
>
>>    So, I do not agree to write a generic adc driver for the rk3288-tsadc.
>>
>> ________________________________
>> Yifeng Zhao
>>
>>
