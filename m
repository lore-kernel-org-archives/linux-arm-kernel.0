From: gpkulkarni@gmail.com (Ganapatrao Kulkarni)
Date: Mon, 6 Oct 2014 09:59:00 +0530
Subject: [RFC PATCH 1/4] arm64: defconfig: increase NR_CPUS range to 2-128
In-Reply-To: <20141003105839.GD26643@leverpostej>
References: <1411635840-24038-1-git-send-email-ganapatrao.kulkarni@caviumnetworks.com>
 <1411635840-24038-2-git-send-email-ganapatrao.kulkarni@caviumnetworks.com>
 <20141003105839.GD26643@leverpostej>
Message-ID: <CAFpQJXWDriyO4tCPGXihPUa=hC9K_-byuLEEtSfw0cU39ipdqA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Oct 3, 2014 at 4:28 PM, Mark Rutland <mark.rutland@arm.com> wrote:
> On Thu, Sep 25, 2014 at 10:03:56AM +0100, Ganapatrao Kulkarni wrote:
>> Raising the maximum limit to 128. This is needed for Cavium's
>> Thunder systems that will have 96 cores on Multi-node system.
>
> Has this been tested on any such systems?
This is tested on Cavium's Thunder 2 Node Simulator with kernel 3.17-rc5.
please let us know, if any specific configurations needs to be tested
with the change.
>
> Mark.
>
>>
>> Signed-off-by: Ganapatrao Kulkarni <ganapatrao.kulkarni@caviumnetworks.com>
>> ---
>>  arch/arm64/Kconfig | 4 ++--
>>  1 file changed, 2 insertions(+), 2 deletions(-)
>>
>> diff --git a/arch/arm64/Kconfig b/arch/arm64/Kconfig
>> index 4d42453..a409105 100644
>> --- a/arch/arm64/Kconfig
>> +++ b/arch/arm64/Kconfig
>> @@ -296,8 +296,8 @@ config SCHED_SMT
>>         places. If unsure say N here.
>>
>>  config NR_CPUS
>> -     int "Maximum number of CPUs (2-64)"
>> -     range 2 64
>> +     int "Maximum number of CPUs (2-128)"
>> +     range 2 128
>>       depends on SMP
>>       # These have to remain sorted largest to smallest
>>       default "64"
>> --
>> 1.8.1.4
>>
>> --
>> To unsubscribe from this list: send the line "unsubscribe devicetree" in
>> the body of a message to majordomo at vger.kernel.org
>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>>
thanks
ganapat
