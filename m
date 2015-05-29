From: vaibhav.hiremath@linaro.org (Vaibhav Hiremath)
Date: Sat, 30 May 2015 02:49:24 +0530
Subject: [PATCH 07/12] i2c: pxa: Reset i2c controller on timeout in
 interrupt and pio mode
In-Reply-To: <87r3pzxf1s.fsf@belgarion.home>
References: <1432818224-17070-1-git-send-email-vaibhav.hiremath@linaro.org>	<1432818224-17070-8-git-send-email-vaibhav.hiremath@linaro.org>
 <87r3pzxf1s.fsf@belgarion.home>
Message-ID: <5568D7DC.4060909@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



On Saturday 30 May 2015 02:43 AM, Robert Jarzmik wrote:
> Vaibhav Hiremath <vaibhav.hiremath@linaro.org> writes:
>
>> In case of timeout during msg xfer assert reset to
>> i2c controller for both interrupt and PIO mode of operation.
>>
>> Signed-off-by: Jett.Zhou <jtzhou@marvell.com>
>> [vaibhav.hiremath at linaro.org: Split & merge patches into logical changes
>> and update the Changelog]
>> Signed-off-by: Vaibhav Hiremath <vaibhav.hiremath@linaro.org>
>>
>> Signed-off-by: Vaibhav Hiremath <vaibhav.hiremath@linaro.org>
> I have the same comment as before.
> I don't like a reset in the transfer path, especially in normal busy phases for
> slow I2C devices. A quirk as before.
>

Note that this assertion of reset in in case of timeout error.

Timeout error may be due to various reasons, and this is recovery
mechanism.

Thanks,
Vaibhav
