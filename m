From: vaibhav.hiremath@linaro.org (Vaibhav Hiremath)
Date: Tue, 02 Jun 2015 22:22:19 +0530
Subject: [PATCH 12/12] i2c: pxa: enable/disable i2c module across msg xfer
In-Reply-To: <20150528132312.GC2067@n2100.arm.linux.org.uk>
References: <1432818224-17070-1-git-send-email-vaibhav.hiremath@linaro.org>
 <1432818224-17070-13-git-send-email-vaibhav.hiremath@linaro.org>
 <20150528132312.GC2067@n2100.arm.linux.org.uk>
Message-ID: <556DDF43.4050804@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



On Thursday 28 May 2015 06:53 PM, Russell King - ARM Linux wrote:
> On Thu, May 28, 2015 at 06:33:44PM +0530, Vaibhav Hiremath wrote:
>> From: Yi Zhang <yizhang@marvell.com>
>>
>> Enable i2c module/unit before transmission and disable when it finishes.
>>
>> why?
>> It's because the i2c bus may be distrubed if the slave device,
>> typically a touch, powers on.
>
> "disturbed"
>
> I'd recommend that this is a DT property - not every platform is going to
> want this, and as there is rudimentary I2C slave support in this driver,
> this change breaks that.
>

I would take it as two different comments here, and I believe you also
meant same,

1. Not breaking I2C slave support

Not sure whether enabling/disabling module in ISR would suffice here.
To be specific, in the functions i2c_pxa_slave_start() &
i2c_pxa_slave_stop()


Another important point is, I am not sure on validation part here, as
the platform I have doesn't have multi masters on the bus.

2. DT property

I forsee conflict between, DT property and SLAVE mode of operation.
where we may want to support master-&-slave together.

Also, we may not need this if we fix I2C Slave support issue, but
testing is challenge for me (atleast).



Do you see any issues with first approach?
if you are ok with first approach, I can change the code.


Thanks,
Vaibhav
