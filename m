From: sebastian.hesselbarth@gmail.com (Sebastian Hesselbarth)
Date: Thu, 07 Nov 2013 11:12:28 +0100
Subject: [PATCH v3 4/9] ARM: add Marvell Berlin SoC familiy to Marvell doc
In-Reply-To: <20131107135632.6384d705@xhacker>
References: <1381235073-17134-1-git-send-email-sebastian.hesselbarth@gmail.com>
 <1383661723-17956-1-git-send-email-sebastian.hesselbarth@gmail.com>
 <1383661723-17956-5-git-send-email-sebastian.hesselbarth@gmail.com>
 <20131107135632.6384d705@xhacker>
Message-ID: <527B678C.7060402@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 11/07/13 06:56, Jisheng Zhang wrote:
> I have some permission to comment this patch now ;)

Great!

> On Tue, 5 Nov 2013 06:28:38 -0800
> Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com> wrote:
>
>> This adds known facts and rumors about the Marvell Berlin (88DE3xxx) SoC
>> family to the Marvell SoC documentation.
>>
>> Signed-off-by: Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>
>> Reviewed-by: Jason Cooper <jason@lakedaemon.net>
>> Reviewed-by: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
>> Reviewed-by: Arnd Bergmann <arnd@arndb.de>
>> ---
[...]
>> diff --git a/Documentation/arm/Marvell/README
>> b/Documentation/arm/Marvell/README index 8f08a86..53ecf08 100644
>> --- a/Documentation/arm/Marvell/README
>> +++ b/Documentation/arm/Marvell/README
>> @@ -210,6 +210,35 @@ MMP/MMP2 family (communication processor)
>>      Linux kernel mach directory: arch/arm/mach-mmp
>>      Linux kernel plat directory: arch/arm/plat-pxa
>>
>> +Berlin family (Digital Entertainment)
>> +-------------------------------------
>> +
>> +  Flavors:
>> +	88DE3005, Armada 1500-mini
>> +		Design name:	BG2CD(A0)
>> +		Core:		ARM Cortex-A9, PL310 L2CC
>> +		Homepage:
>> http://www.marvell.com/digital-entertainment/armada-1500-mini/
>> +	88DE3010, Armada 1000
>> +		Design name:	BG2(Z1)
>> +		Core:		Marvell PJ4B (ARMv7), Tauros3 L2CC
>> +		Product Brief:
>> http://www.marvell.com/digital-entertainment/assets/armada_1000_pb.pdf
> 88DE3010 is based on ARMv5 and is too old, I bet there are no real users now. Can we
> remove it?

(If you leave a blank line between my message and your reply it is much
more easy to find)

I see Marvell also removed it from DE product line. So, I agree, let's
get rid of it.

>> +	88DE3100, Armada 1500
>> +		Design name:	BG2(A0)
> BG2(B0), BG2(A0) and BG2(Z1) are both called 88DE3100, Armada 1500. They are
> just different Step versions. And BG2(Zx) BG2(Ax) are rarely used outside marvell
> Mostly used version is BG2(B0)

Yeah, I was maybe just making it up, as you weren't allowed to clarify
it before. I'll remove the stepping from the design name.

>> +		Core:		Marvell PJ4B (ARMv7), Tauros3 L2CC
>> +		Homepage:
>> http://www.marvell.com/digital-entertainment/armada-1500/
>> +		Product Brief:
>> http://www.marvell.com/digital-entertainment/armada-1500/assets/Marvell-ARMADA-1500-Product-Brief.pdf
>> +	88DE????
>> +		Design name:	BG3
>> +		Core:		ARM Cortex-A15, CA15 integrated L2CC
>> +
>> +  Homepage: http://www.marvell.com/digital-entertainment/
>> +  Directory: arch/arm/mach-berlin
>> +
>> +  Comments:
>> +   * This line of SoCs is based on Marvell Sheeva or ARM Cortex CPUs
>> +     with Synopsys DesignWare (IRQ, GPIO, Timers, ...) and PXA IP (SDHCI,
>> USB, ETH, ...).
>> +   * Currently known design names are: C2, BG2(Z1), BG2(A0), BG2CD(A0),
>> BG2CT(A0) +
>>   Long-term plans
>>   ---------------
>>
>
