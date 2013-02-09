From: ben.dooks@codethink.co.uk (Ben Dooks)
Date: Sat, 09 Feb 2013 16:46:26 +0000
Subject: [PATCH 01/17] ARM: add =?UTF-8?Q?CPU=5FBE=38=5FBOOT=5FLE=20co?=
 =?UTF-8?Q?nfiguration?=
In-Reply-To: <alpine.LFD.2.02.1302082228160.6300@xanadu.home>
References: <1360365467-25056-1-git-send-email-ben.dooks@codethink.co.uk>
 <1360365467-25056-2-git-send-email-ben.dooks@codethink.co.uk>
 <alpine.LFD.2.02.1302082228160.6300@xanadu.home>
Message-ID: <0e242c77d74978de24f65afb2033b02a@codethink.co.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 09/02/2013 04:10, Nicolas Pitre wrote:
> On Fri, 8 Feb 2013, Ben Dooks wrote:
>
>> Add configuration for booting a BE8 system from a LE boot 
>> environment.
>>
>> Signed-off-by: Ben Dooks <ben.dooks@codethink.co.uk>
>> ---
>>  arch/arm/mm/Kconfig |    7 +++++++
>>  1 file changed, 7 insertions(+)
>>
>> diff --git a/arch/arm/mm/Kconfig b/arch/arm/mm/Kconfig
>> index 3fd629d..70e2ad9 100644
>> --- a/arch/arm/mm/Kconfig
>> +++ b/arch/arm/mm/Kconfig
>> @@ -688,6 +688,13 @@ config CPU_ENDIAN_BE8
>>  	help
>>  	  Support for the BE-8 (big-endian) mode on ARMv6 and ARMv7 
>> processors.
>>
>> +config CPU_BE8_BOOT_LE
>> +	bool "Boot BE system from LE loader"
>> +	depends on CPU_ENDIAN_BE8
>> +	help
>> +	  Support for running BE-8 (big-endian) from a boot environment 
>> that is
>> +	  running in LE mode.
>> +
>
> This looks strange to have a patch that only adds a config symbol 
> with
> no user.  Could you move it later in the series, or fold it with, 
> say,
> patch #4?

Yes, will look at folding it in.

-- 
Ben
