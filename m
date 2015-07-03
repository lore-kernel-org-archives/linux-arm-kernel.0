From: vaibhav.hiremath@linaro.org (Vaibhav Hiremath)
Date: Fri, 03 Jul 2015 23:43:18 +0530
Subject: [PATCH-V2 04/12] i2c: pxa: Reset i2c controller on timeout in
 interrupt and pio mode
In-Reply-To: <87fv55clcy.fsf@belgarion.home>
References: <vaibhav.hiremath@linaro.org>	<1434383399-2370-1-git-send-email-vaibhav.hiremath@linaro.org>	<1434383399-2370-5-git-send-email-vaibhav.hiremath@linaro.org>
 <87fv55clcy.fsf@belgarion.home>
Message-ID: <5596D0BE.8070902@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



On Friday 03 July 2015 08:57 PM, Robert Jarzmik wrote:
> Vaibhav Hiremath <vaibhav.hiremath@linaro.org> writes:
>
>> In case of timeout during msg xfer assert reset to
>> i2c controller for both interrupt and PIO mode of operation.
>>
>> Signed-off-by: Jett.Zhou <jtzhou@marvell.com>
>> [vaibhav.hiremath at linaro.org: Split & merge patches into logical changes
>> and update the Changelog]
>> Signed-off-by: Vaibhav Hiremath <vaibhav.hiremath@linaro.org>
>
> I already said it previously, I'm against an unconditional reset in a timeout
> path. Make it a quirk or whatever, but in the current status, I'm against.
>
> The previous behavior looks correct to me : upon timeout, retry, no need to
> reset.
>

We still do return RETRY here, but also assert reset to I2C.

Anyway, lets revisit this again later. I will remove it in my next
version.

Thanks,
Vaibhav
