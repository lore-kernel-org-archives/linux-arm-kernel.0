From: magnus.damm@gmail.com (Magnus Damm)
Date: Tue, 9 Jul 2013 18:11:09 +0900
Subject: [PATCH 00/04] ARM: shmobile: ARCH_MULTIPLATFORM for EMEV2 and
 KZM9D
In-Reply-To: <201307090945.36314.arnd@arndb.de>
References: <20130709054331.14007.66068.sendpatchset@w520>
 <201307090945.36314.arnd@arndb.de>
Message-ID: <CANqRtoRpMC+D4OHTLkrmgrZ+HZdFcGuBQti3kkDeiT_vrCduvA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jul 9, 2013 at 4:45 PM, Arnd Bergmann <arnd@arndb.de> wrote:
> On Tuesday 09 July 2013, Magnus Damm wrote:
>> ARM: shmobile: ARCH_MULTIPLATFORM for EMEV2 and KZM9D
>>
>> [PATCH 01/04] ARM: shmobile: Only build clocks when COMMON_CLK=n
>> [PATCH 02/04] ARM: shmobile: Introduce ARCH_SHMOBILE_MULTI
>> [PATCH 03/04] ARM: shmobile: Add EMEV2 and KZM9D to ARCH_SHMOBILE_MULTI
>> [PATCH 04/04] ARM: shmobile: Allow ARCH_SHMOBILE_MULTI timer configuration
>>
>> This patch set extends mach-shmobile to allow a subset of SoCs and
>> boards to be built for ARCH_MULTIPLATFORM. With this series applied
>> the EMEV2 SoC and the KZM9D board can be built in two ways - either
>> as good old ARCH_SHMOBILE or new ARCH_SHMOBILE_MULTI. The latter
>> requires common clock framework for proper run time operation.
>>
>> The goal is to over time move all DT reference implementations from
>> ARCH_SHMOBILE to ARCH_SHMOBILE_MULTI. Until CCF is available for a
>> certain SoC it is to me acceptable for a DT reference board to allow
>> build in both ARCH_SHMOBILE and ARCH_SHMOBILE_MULTI. The reason for
>> this is to allow incremental development and easy testing during
>> development of CCF for a certain SoC. The KZM9D board is now in this
>> state while it is waiting for common clocks to become ready.
>>
>> In the near future a prototype hack will be posted that comments
>> out the clock framework bits on EMEV2 and will allow boot of KZM9D
>> in the case of ARCH_SHMOBILE_MULTI even though CCF is not yet
>> available.
>>
>> Signed-off-by: Magnus Damm <damm@opensource.se>
>
> Great stuff, very glad you got this far!

Thanks, I'm happy to hear that!

> I have two small style comments, nothing important.

Sure, I will fix up and resend. Thanks for your feedback!

/ magnus
