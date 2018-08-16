From: tuomas.tynkkynen@iki.fi (Tuomas Tynkkynen)
Date: Thu, 16 Aug 2018 21:31:07 +0300
Subject: AArch64 boot failure on Hikey960 on latest master after "arm64:
 insn: Don't fallback on nosync path for general insn patching"
In-Reply-To: <20180816102219.GF31093@arm.com>
References: <462f8ae6-9948-a8e5-7504-623d40344336@iki.fi>
 <20180816102219.GF31093@arm.com>
Message-ID: <66fdd8a7-22ed-71f8-f0a0-119f9b495a94@iki.fi>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On 08/16/2018 01:22 PM, Will Deacon wrote:
> Hi Tuomas, [+John]
> 
> On Thu, Aug 16, 2018 at 02:38:51AM +0300, Tuomas Tynkkynen wrote:
>> Booting Linus's master of today with the usual arm64 defconfig fails for
>> me on the Hikey960 board. I've bisected it down to:
>>
>> commit 693350a7998018391852c48f68956cf0f855b2b9 (HEAD, refs/bisect/bad)
>> Author: Will Deacon <will.deacon@arm.com>
>> Date:   Tue Jun 19 17:55:28 2018 +0100
>>
>>      arm64: insn: Don't fallback on nosync path for general insn patching
>>
>> Here's the boot log with earlycon enabled after which the boot hangs:
> 
> Thanks for the boot log, that's really helpful. Please can you try the diff
> below?
> 

Thanks for the quick response, that indeed fixes it. If you need more tags:

Reported-by: Tuomas Tynkkynen <tuomas@tuxera.com>
Tested-by: Tuomas Tynkkynen <tuomas@tuxera.com>

- Tuomas
