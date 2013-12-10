From: jonathan.austin@arm.com (Jonathan Austin)
Date: Tue, 10 Dec 2013 17:27:21 +0000
Subject: [PATCH v2] ARM: add support for the Cortex-A12 processor
In-Reply-To: <201312080322.57976.arnd@arndb.de>
References: <1386342282-8769-1-git-send-email-jonathan.austin@arm.com>
 <201312080322.57976.arnd@arndb.de>
Message-ID: <52A74EF9.2090405@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 08/12/13 02:22, Arnd Bergmann wrote:
> On Friday 06 December 2013, Jonathan Austin wrote:
>> The A12 behaves as the A7/A15 does with respect to setting the SMP bit, and
>> doesn't require TLB ops broadcasting to be explicitly enabled like the A9 does.
>>
>> Note that as the ACTLR cannot (usually) be written from non-secure, it is the
>> responsibility of the bootloader/firmware to set this bit per core - it is
>> done here in Linux as last resort in case of bad firmware.
>>
>> Acked-by: Catalin Marinas <catalin.marinas@arm.com>
>> Acked-by: Will Deacon <will.deacon@arm.com>
>> Signed-off-by: Jonathan Austin <jonathan.austin@arm.com>
>
> I guess this one qualifies for stable backports under the "new device ID"
> rule, and I'm sure people will want to have it in some longterm release.
>

Yes, I'd say this certainly makes sense for 3.10 - though even without 
this things will basically work due to the catch-all for V7A.

Happy to Cc: stable when I put this into the patch system, though

Jonny

> 	Arnd
>
