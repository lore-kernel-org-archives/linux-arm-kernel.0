From: vaibhav.hiremath@linaro.org (Vaibhav Hiremath)
Date: Mon, 13 Jul 2015 22:11:07 +0530
Subject: [PATCH-v3 07/11] i2c: pxa: enable/disable i2c module across msg
 xfer
In-Reply-To: <20150710082419.GE1528@katana>
References: <1436210695-19159-1-git-send-email-vaibhav.hiremath@linaro.org>
 <1436210695-19159-8-git-send-email-vaibhav.hiremath@linaro.org>
 <20150710082419.GE1528@katana>
Message-ID: <55A3EA23.8070009@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



On Friday 10 July 2015 01:54 PM, Wolfram Sang wrote:
> On Tue, Jul 07, 2015 at 12:54:51AM +0530, Vaibhav Hiremath wrote:
>> From: Yi Zhang <yizhang@marvell.com>
>>
>> Enable i2c module/unit before transmission and disable when it finishes.
>>
>> why?
>> It's because the i2c bus may be distrubed if the slave device,
>> typically a touch, powers on.
>>
>> As we do not want to break slave mode support, this patch introduces
>> DT property to control disable of the I2C module after xfer in master mode
>> of operation.
>>
>> i2c-disable-after-xfer : If set, driver will disable I2C module after msg xfer
>
> Hmm, I am not sure this property fits into the "describing hardware"
> category. And we can't make the below behaviour default, because the
> udelay(100) will cause quite some latency.
>
>>

Sorry for delayed response,
I thought I responded to this, but when I was preparing for V4,
realized it that I did not :)

Yes, I agree that, this doesn't look like HW description. But I could
not find any other mechanism to handle this.
And also during V1 discussion, I did not get any objection to this
approach.


Thanks,
Vaibhav
