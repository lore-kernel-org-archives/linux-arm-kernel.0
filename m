From: linux@rempel-privat.de (Oleksij Rempel)
Date: Mon, 20 Oct 2014 20:38:36 +0200
Subject: [PATCH v6 02/10] ARM: add lolevel debug support for asm9260
In-Reply-To: <20141020143543.GW27405@n2100.arm.linux.org.uk>
References: <1413814203-8785-1-git-send-email-linux@rempel-privat.de>
 <1413814203-8785-3-git-send-email-linux@rempel-privat.de>
 <20141020143543.GW27405@n2100.arm.linux.org.uk>
Message-ID: <544556AC.2060808@rempel-privat.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Am 20.10.2014 um 16:35 schrieb Russell King - ARM Linux:
> On Mon, Oct 20, 2014 at 04:09:55PM +0200, Oleksij Rempel wrote:
>> Signed-off-by: Oleksij Rempel <linux@rempel-privat.de>
>> ---
>>  arch/arm/Kconfig.debug           | 33 ++++++++++++++++++++++++++++++---
>>  arch/arm/include/debug/asm9260.S | 31 +++++++++++++++++++++++++++++++
>>  2 files changed, 61 insertions(+), 3 deletions(-)
>>  create mode 100644 arch/arm/include/debug/asm9260.S
>>
>> diff --git a/arch/arm/Kconfig.debug b/arch/arm/Kconfig.debug
>> index b11ad54..6902a57 100644
>> --- a/arch/arm/Kconfig.debug
>> +++ b/arch/arm/Kconfig.debug
>> @@ -953,6 +953,27 @@ choice
>>  		  options; the platform specific options are deprecated
>>  		  and will be soon removed.
>>  
>> +	config DEBUG_ASM9260_UART
>> +		bool "Kernel low-level debugging via asm9260 UART"
>> +		depends on MACH_ASM9260
>> +		help
>> +		  Say Y here if you want the debug print routines to direct
>> +		  their output to an UART or USART port on asm9260 based
>> +		  machines.
>> +
>> +		    DEBUG_UART_PHYS | DEBUG_UART_VIRT
>> +
>> +		    0x80000000      | 0xf0000000     | UART0
>> +		    0x80004000      | 0xf0004000     | UART1
>> +		    0x80008000      | 0xf0008000     | UART2
>> +		    0x8000c000      | 0xf000c000     | UART3
>> +		    0x80010000      | 0xf0010000     | UART4
>> +		    0x80014000      | 0xf0014000     | UART5
>> +		    0x80018000      | 0xf0018000     | UART6
>> +		    0x8001c000      | 0xf001c000     | UART7
>> +		    0x80020000      | 0xf0020000     | UART8
>> +		    0x80024000      | 0xf0024000     | UART9
>> +
> 
> Also badly placed.

How should it be ordered, by CONFIG or machine name? With other words,
before or after AT91_DEBUG?


-- 
Regards,
Oleksij

-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 213 bytes
Desc: OpenPGP digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20141020/580c0430/attachment-0001.sig>
