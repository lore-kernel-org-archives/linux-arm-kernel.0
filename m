From: ben.dooks@codethink.co.uk (Ben Dooks)
Date: Sat, 09 Feb 2013 22:00:51 +0000
Subject: [PATCH 14/17] highbank: enable big-endian
In-Reply-To: <5116C0A2.7030508@gmail.com>
References: <1360365467-25056-1-git-send-email-ben.dooks@codethink.co.uk>
 <1360365467-25056-15-git-send-email-ben.dooks@codethink.co.uk>
 <5116C0A2.7030508@gmail.com>
Message-ID: <4d2a1c1c4e6df18881390c8549aa3108@codethink.co.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 09/02/2013 21:33, Rob Herring wrote:
> On 02/08/2013 05:17 PM, Ben Dooks wrote:
>> Apart from a xgmac driver issue, the highbank seems to work 
>> correctly in
>> big-endian mode. Allow the selection of big-endian in the system.
>>
>> Signed-off-by: Ben Dooks <ben.dooks@codethink.co.uk>
>> ---
>>  arch/arm/mach-highbank/Kconfig |    1 +
>>  1 file changed, 1 insertion(+)
>>
>> diff --git a/arch/arm/mach-highbank/Kconfig 
>> b/arch/arm/mach-highbank/Kconfig
>> index 551c97e..9373571 100644
>> --- a/arch/arm/mach-highbank/Kconfig
>> +++ b/arch/arm/mach-highbank/Kconfig
>> @@ -13,3 +13,4 @@ config ARCH_HIGHBANK
>>  	select HAVE_SMP
>>  	select SPARSE_IRQ
>>  	select USE_OF
>> +	select ARCH_SUPPORTS_BIG_ENDIAN
>
> Considering that there is nothing highbank specific to enable BE 
> support
> and all the support is within the A9 core (as BE support was never an
> intended feature), I wonder if this is really the right place for 
> this
> option. All this really says is BE has been tested on this platform 
> and
> presumably it would work on other platforms ignoring raw vs. relaxed
> accessors.

 From reading previous ARM documentation, I believe that the big endian
is not a requirement for ARMv7 and can be compiled out of the core if
the implementor does not want it. However, we've yet to find any of the
cores out there with it removed.

As such, we still have to test on Freescale and OMAP devices.

If anyone else objects to this, or feels it would be better moved
to the V7 cpu selection, or removed entirely then let me know.

> In any case:
>
> Acked-by: Rob Herring <rob.herring@calxeda.com>
>
> Rob
