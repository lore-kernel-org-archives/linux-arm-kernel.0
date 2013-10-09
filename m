From: sebastian.hesselbarth@gmail.com (Sebastian Hesselbarth)
Date: Wed, 09 Oct 2013 09:08:13 +0200
Subject: [PATCH 8/8] ARM: add initial support for Marvell Berlin SoCs
In-Reply-To: <1381274699.5184.2.camel@linux-builds1>
References: <1381235073-17134-1-git-send-email-sebastian.hesselbarth@gmail.com>
 <1381235073-17134-9-git-send-email-sebastian.hesselbarth@gmail.com>
 <1381274699.5184.2.camel@linux-builds1>
Message-ID: <525500DD.8050204@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 10/09/2013 01:24 AM, Dinh Nguyen wrote:
> Hi Sebastian,
>
> On Tue, 2013-10-08 at 14:24 +0200, Sebastian Hesselbarth wrote:
>> This adds initial support for the Marvell Berlin (88DE3xxx) SoC family
>> and basic machine setup for Armada 1500 (88DE3100) SoCs.
[...]
>> +config MACH_MV88DE3100
>> +	bool "Marvell 88DE3100 (Armada 1500)"
>> +	select ARM_GIC
>> +	select CACHE_L2X0
>> +	select CPU_PJ4B
>> +	select HAVE_ARM_TWD if LOCAL_TIMERS
>> +	select HAVE_SMP
>> +	select LOCAL_TIMERS if SMP
>
> I think because of commit:
>
> a894fcc2d [ARM: smp_twd: Divorce smp_twd from local timer API]
>
> you can remove the LOCAL_TIMERS for HAVE_ARM_TWD.

Thanks, Dinh, I will have a look at this.
