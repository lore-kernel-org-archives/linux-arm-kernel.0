From: dave.martin@linaro.org (Dave Martin)
Date: Fri, 17 Dec 2010 13:20:54 +0000
Subject: OMAP3: Warning: swp{b} use is deprecated for this architecture
In-Reply-To: <AANLkTimaC3WaWAF8QNgs+3qza2WmBPXGbo5eKsooMT_o@mail.gmail.com>
References: <AANLkTinmg4SyQNz5ide40YYC7k_MRQ6Q-j=WKN7jLC68@mail.gmail.com>
	<20101216115657.GP9937@n2100.arm.linux.org.uk>
	<AANLkTi=-ERvBARQ3bzOMZPx0s-OPuZHgXqjRet1aUxGw@mail.gmail.com>
	<AANLkTink3TJonOC+cnpRUKKu9_+OBhJKDQ25yvrZZsrQ@mail.gmail.com>
	<6188477658179778436@unknownmsgid>
	<AANLkTinL3oonBvkZwZFr=Wh2m_EYQ1WVudV9cxNqKRBx@mail.gmail.com>
	<AANLkTinXBx5F-wQC_eJPftsqgbaFUg9R8z5FxTFR+gTy@mail.gmail.com>
	<20101216201042.GW9937@n2100.arm.linux.org.uk>
	<AANLkTimaC3WaWAF8QNgs+3qza2WmBPXGbo5eKsooMT_o@mail.gmail.com>
Message-ID: <AANLkTimyJ0VOJvxJs5f8Q6W4FxkR8HFic7futTGD-ApB@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On Thu, Dec 16, 2010 at 9:44 PM, Jean Pihet <jean.pihet@newoldbits.com> wrote:
> On Thu, Dec 16, 2010 at 9:10 PM, Russell King - ARM Linux
> <linux@arm.linux.org.uk> wrote:
>> On Thu, Dec 16, 2010 at 08:04:41PM +0000, Dave Martin wrote:
>>> Note that the above bit of code is similar/identical to a bit of code
>>> already present in the OMAP BSP... so this still needs to be
>>> addressed.
>>>
>>> See arch/arm/mach-omap2/sleep34xx.S:lock_scratchpad_sem
>>
>> That's odd.
>>
>> | The following warning is issued by the compiler (gcc version 4.4.1
>> | (Sourcery G++ Lite 2010q1-202):
>> | arch/arm/mach-omap2/sleep34xx.S:87: Warning: swp{b} use is deprecated
>> | for this architecture
>>
>> It seems we're discussing the same code!

Hmmm, guess I didn't look closely enough in the filename from the
original post(!)

>>
>> As has been pointed out, and as Jean points out, this code is not called
>> at the moment, so can be removed to resolve the problem.
>>
> Exactly! It is actually planned for removal, cf.
> http://marc.info/?l=linux-omap&m=129252188012958&w=2

Well, that solves the problem nicely, for now...

Cheers
---Dave

> A better solution will be needed at the time the API will be in use.
>
> Thanks,
> Jean
>
