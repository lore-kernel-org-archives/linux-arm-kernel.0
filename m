From: vaibhav.hiremath@linaro.org (Vaibhav Hiremath)
Date: Thu, 04 Jun 2015 00:19:05 +0530
Subject: [PATCH 12/12] i2c: pxa: enable/disable i2c module across msg xfer
In-Reply-To: <20150603105626.GE6696@yizhang>
References: <1432818224-17070-1-git-send-email-vaibhav.hiremath@linaro.org>
 <1432818224-17070-13-git-send-email-vaibhav.hiremath@linaro.org>
 <20150528132312.GC2067@n2100.arm.linux.org.uk> <556DDF43.4050804@linaro.org>
 <556DE0EB.1010609@linaro.org> <20150603105626.GE6696@yizhang>
Message-ID: <556F4C21.1070500@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



On Wednesday 03 June 2015 04:26 PM, Yi Zhang wrote:
> On Tue, Jun 02, 2015 at 10:29:23PM +0530, Vaibhav Hiremath wrote:
>>
>>
>> On Tuesday 02 June 2015 10:22 PM, Vaibhav Hiremath wrote:
>>>
>>>
>>> On Thursday 28 May 2015 06:53 PM, Russell King - ARM Linux wrote:
>>>> On Thu, May 28, 2015 at 06:33:44PM +0530, Vaibhav Hiremath wrote:
>>>>> From: Yi Zhang <yizhang@marvell.com>
>>>>>
>>>>> Enable i2c module/unit before transmission and disable when it finishes.
>>>>>
>>>>> why?
>>>>> It's because the i2c bus may be distrubed if the slave device,
>>>>> typically a touch, powers on.
>>>>
>>>> "disturbed"
>>>>
>>>> I'd recommend that this is a DT property - not every platform is going to
>>>> want this, and as there is rudimentary I2C slave support in this driver,
>>>> this change breaks that.
>>>>
>>>
>>> I would take it as two different comments here, and I believe you also
>>> meant same,
>>>
>>> 1. Not breaking I2C slave support
>>>
>>> Not sure whether enabling/disabling module in ISR would suffice here.
>>> To be specific, in the functions i2c_pxa_slave_start() &
>>> i2c_pxa_slave_stop()
>>>
>>>
>>
>> Please ignore this option, as enable is important to generate interrupt
>> on slave start.
>
>    Yes, you are right, enabling i2c controller first is must for
>    generating the interrupt


Zang,

Probably you can help me,

I am trying to introduce standard DT propertied for sclk adjustment,
meant for ILCR and IWCR register.
The datasheet I have has some confusion in terms of usage of load
counters and wait counters.

Can you please help me understand on below queries -

  1. Any additional calculation (any offset or something) I need to add
     for calculating counter values from time in nsec/usec?

  2. Counters just counts the input clock (of either 26MHz or 69MHz)?

  3. Are all counters to respective modes mutual exclusive? I mean, if I
     set fast mode, any dependency on other counters? I see IWCR.COUNT
     is common for both standard and fast mode, what about high speed
     mode?

  4. IWCR.COUNT field is meant for tHD.DATA ???

Thanks,
Vaibhav
