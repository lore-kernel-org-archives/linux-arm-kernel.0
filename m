From: vaibhav.hiremath@linaro.org (Vaibhav Hiremath)
Date: Mon, 13 Jul 2015 12:39:53 +0530
Subject: [PATCH-v3 02/11] i2c: pxa: No need to set slave addr for i2c
 master mode reset
In-Reply-To: <20150710145628.GB6594@katana>
References: <1436210695-19159-1-git-send-email-vaibhav.hiremath@linaro.org>
 <1436210695-19159-3-git-send-email-vaibhav.hiremath@linaro.org>
 <20150710081148.GB1528@katana> <559FBCD3.4050402@linaro.org>
 <20150710141440.GA6594@katana> <559FD5DB.9030308@linaro.org>
 <20150710145628.GB6594@katana>
Message-ID: <55A36441.2020206@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



On Friday 10 July 2015 08:26 PM, Wolfram Sang wrote:
> On Fri, Jul 10, 2015 at 07:55:31PM +0530, Vaibhav Hiremath wrote:
>>
>>
>> On Friday 10 July 2015 07:44 PM, Wolfram Sang wrote:
>>> On Fri, Jul 10, 2015 at 06:08:43PM +0530, Vaibhav Hiremath wrote:
>>>>
>>>>
>>>> On Friday 10 July 2015 01:41 PM, Wolfram Sang wrote:
>>>>> On Tue, Jul 07, 2015 at 12:54:46AM +0530, Vaibhav Hiremath wrote:
>>>>>> Normally i2c controller works as master, so slave addr is not needed, or it
>>>>>> will impact some slave device (eg. ST NFC chip) i2c accesses, because it has
>>>>>> the same i2c address with controller.
>>>>>
>>>>> Just to make sure: Does it? As I read the code, slave interrupts are
>>>>> enabled later only when slave mode is selected? Is that a HW bug? And if
>>>>> so, can't the code just be moved into this #ifdef block later?
>>>>>
>>>>
>>>> Yes we could, infact I thought about it;
>>>> but I would break recommended sequence here.
>>>
>>> And did you set the "own slave address" to a value which one of your
>>> existing i2c slaves also has (without enabling slave mode)? Did it
>>> disturb communication?
>>>
>>
>> Since slave and master mode are mutual exclusive,
>> I did not try this.
>
> Ehrm, what I meant was. Did you see the issue mentioned in the above
> commit message? Can you reproduce it? You don't need to enable slave
> mode for that, no?
>

Ohh yes,

I am able to reproduce this issue.

I have pxa1928 based board, where I have only PMIC 88PM860 connected to
I2C bus, and whenever I set slave address to 0x30 (PMIC slave address)
all I2C transaction for PMIC goes for toss.


Thanks,
Vaibhav
