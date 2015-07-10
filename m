From: marc.zyngier@arm.com (Marc Zyngier)
Date: Fri, 10 Jul 2015 09:23:49 +0100
Subject: ACPI: regression: Failed to initialize GIC IRQ controller
In-Reply-To: <CAOHikRBYS-oaWa8qKd+6-2LZ4drVrWnfvqN34cGEu8QxbrMX1Q@mail.gmail.com>
References: <CACVXFVPkZYm2i+S3m8B0tixKmTx02psGndo79ehdJxLiz9T92A@mail.gmail.com>	<559F7B2C.6090402@arm.com>
 <CAOHikRBYS-oaWa8qKd+6-2LZ4drVrWnfvqN34cGEu8QxbrMX1Q@mail.gmail.com>
Message-ID: <559F8115.1060801@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 10/07/15 09:17, Suman Tripathi wrote:
> On Fri, Jul 10, 2015 at 1:28 PM, Marc Zyngier <marc.zyngier@arm.com> wrote:
>>
>> On 10/07/15 08:45, Ming Lei wrote:
>>> Hi,
>>>
>>> Commit 0cff8dc0099f6d4f(ACPICA: ACPI 6.0: Add changes for MADT table.)
>>> causes the following failure on APM mustang board(arm64) when
>>> booting via UEFI and ACPI:
>>>
>>> No valid GICC entries exist
>>> ACPI: Failed to initialize GIC IRQ controller
>>> Kernel panic - not syncing: No interrupt controller found.
>>> CPU: 0 PID: 0 Comm: swapper/0 Not tainted 4.2.0-rc1+ #45
>>> Hardware name: APM X-Gene Mustang board (DT)
>>> Call trace:
>>> [<ffffffc000089b94>] dump_backtrace+0x0/0x12c
>>> [<ffffffc000089cd0>] show_stack+0x10/0x1c
>>> [<ffffffc0005fac18>] dump_stack+0x8c/0xdc
>>> [<ffffffc0005f7218>] panic+0xe4/0x220
>>> [<ffffffc00082631c>] init_IRQ+0x24/0x30
>>> [<ffffffc00082486c>] start_kernel+0x274/0x3d8
>>> ---[ end Kernel panic - not syncing: No interrupt controller found.
>>
>> Isn't that addressed by [1] which Catalin has queued for -rc2?
> 
> 
> I am also seeing the same . But it fixes after I apply the parking
> protocol  patch but that is not upstreamed.

I'm more interested to find out if the patch I mentioned in my original
email fixes it or not. An additional dependency on something that is not
aimed for mainline yet doesn't really help.

Thanks,

	M.
-- 
Jazz is not dead. It just smells funny...
