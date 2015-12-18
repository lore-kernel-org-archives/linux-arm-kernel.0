From: marc.zyngier@arm.com (Marc Zyngier)
Date: Fri, 18 Dec 2015 11:29:57 +0000
Subject: [PATCH 2/2] ARM: Make IPI_CPU_BACKTRACE a "non-secure" SGI
In-Reply-To: <5673EC09.8090909@linaro.org>
References: <1450430173-26992-1-git-send-email-marc.zyngier@arm.com>
 <1450430173-26992-3-git-send-email-marc.zyngier@arm.com>
 <5673EC09.8090909@linaro.org>
Message-ID: <5673EE35.4090502@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 18/12/15 11:20, Daniel Thompson wrote:
> On 18/12/15 09:16, Marc Zyngier wrote:
>> Having IPI_CPU_BACKTRACE as SGI15 may not work if the kernel is
>> running in non-secure mode and that the secure firmware has
>> decided to follow ARM's recommendations that SGI8-15 should
>> be reserved for secure purpose.
>>
>> Now that we are "only" using SGI0-6, change IPI_CPU_BACKTRACE
>> to use SGI7, which makes it more likely to work.
>>
>> Signed-off-by: Marc Zyngier <marc.zyngier@arm.com>
> 
> Tested-by: Daniel Thompson <daniel.thompson@linaro.org>

Thanks Daniel, much appreciated.

	M.
-- 
Jazz is not dead. It just smells funny...
