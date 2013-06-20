From: ben.dooks@codethink.co.uk (Ben Dooks)
Date: Thu, 20 Jun 2013 12:07:47 +0100
Subject: [PATCH 01/10] ARM: fix ARCH_IXP4xx usage of
 ARCH_SUPPORTS_BIG_ENDIAN
In-Reply-To: <20130619193014.51b5c796@skate>
References: <1371645406-16873-1-git-send-email-ben.dooks@codethink.co.uk>
 <1371645406-16873-2-git-send-email-ben.dooks@codethink.co.uk>
 <20130619193014.51b5c796@skate>
Message-ID: <51C2E283.8010000@codethink.co.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 19/06/13 18:30, Thomas Petazzoni wrote:
> Dear Ben Dooks,
>
> On Wed, 19 Jun 2013 13:36:37 +0100, Ben Dooks wrote:
>> The Kconfig for arch/arm/mach-ixp4xx has a local definition
>> of ARCH_SUPPORTS_BIG_ENDIAN which could be used elsewhere.
>> This means that if IXP4xx is selected and this symbol is
>> selected eleswhere then an warning is produced.
>>
>> Clean the following error up by making the symbol be
>> selected by the main ARCH_IXP4XX definition and have a
>> common definition in arch/arm/mm/Kconfig
>>
>> warning: (ARCH_xxx) selects ARCH_SUPPORTS_BIG_ENDIAN which has unmet direct dependencies (ARCH_IXP4XX)
>> warning: (ARCH_xxx) selects ARCH_SUPPORTS_BIG_ENDIAN which has unmet direct dependencies (ARCH_IXP4XX)
>> ---
>>   arch/arm/Kconfig             |    1 +
>>   arch/arm/mach-ixp4xx/Kconfig |    4 ----
>>   arch/arm/mm/Kconfig          |    6 ++++++
>>   3 files changed, 7 insertions(+), 4 deletions(-)
>
> Patch lacks SoB.

Thanks, must have missed it.

-- 
Ben Dooks				http://www.codethink.co.uk/
Senior Engineer				Codethink - Providing Genius
