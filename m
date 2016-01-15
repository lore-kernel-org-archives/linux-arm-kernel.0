From: Suzuki.Poulose@arm.com (Suzuki K. Poulose)
Date: Fri, 15 Jan 2016 10:28:50 +0000
Subject: [PATCH] arm-cci: simplify sysfs attr handling
In-Reply-To: <20151104111112.GA23860@leverpostej>
References: <1443523283-6248-1-git-send-email-mark.rutland@arm.com>
 <20151104111112.GA23860@leverpostej>
Message-ID: <5698C9E2.7040405@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 04/11/15 11:11, Mark Rutland wrote:
> On Tue, Sep 29, 2015 at 11:41:23AM +0100, Mark Rutland wrote:
>> There's no need to dynamically initialise attribute pointers when we can
>> get the compiler to do it for us. We also don't need a dev_ext_attribute
>> for the cpumask, as the drvdata for a PMU device is a pointer to struct
>> pmu.
>>
>> Signed-off-by: Mark Rutland <mark.rutland@arm.com>
>> Acked-by: Punit Agrawal <punit.agrawal@arm.com>
>> Reviewed-by: Suzuki K. Poulose <suzuki.poulose@arm.com>
>> Tested-by: Suzuki K. Poulose <suzuki.poulose@arm.com>
>> Cc: Arnd Bergmann <arnd@arndb.de>
>> Cc: Olof Johansson <olof@lixom.net>
>> ---
>>   drivers/bus/arm-cci.c | 100 +++++++++++++-------------------------------------
>>   1 file changed, 25 insertions(+), 75 deletions(-)
>
> Arnd/Olof, are you happy to pick this up?
>
> I don't believe there are any other pending changes to the CCI code, and
> haven't been since I posted this so it still applies atop of v4.3.
>

fyi,

This hasn't made into arm-soc tree yet.

Suzuki
