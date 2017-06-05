From: marc.zyngier@arm.com (Marc Zyngier)
Date: Mon, 5 Jun 2017 10:27:05 +0100
Subject: Vexpress TC2 no longer booting on v4.12-rc1
In-Reply-To: <a8b9336e-661a-841a-ca93-45ebe1b55994@arm.com>
References: <CANLsYkz3dcVArStN2GJguYfJbWc_4dC4vvTE1KVtYpVWipEYjg@mail.gmail.com>
 <a8b9336e-661a-841a-ca93-45ebe1b55994@arm.com>
Message-ID: <6527c326-f4fc-8b37-21c8-ee7e361d9f63@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 05/06/17 10:18, Sudeep Holla wrote:
> 
> 
> On 02/06/17 23:16, Mathieu Poirier wrote:
>> Good afternoon Russell and friends,
>>
>> I noticed that my vexpress-TC2 platform stopped booting when moving to
>> kernel v4.12-rc1 (same with -rc2 and 3).  The last time things worked
>> properly was on v4.11.  I did a bisect between v4.11 and v4.12-rc1 and
>> ended up on [1], hence this email.
>>
>> Since CONFIG_ARM_VIRT_EXT is selected by  default I removed the
>> "#ifdef CONFIG_ARM_VIRT_EXT" section in the last hunk of the patch and
>> the system sprung up to life again.
>>
>> Compiler: arm-linux-gnueabi-gcc (Ubuntu/Linaro 5.4.0-6ubuntu1~16.04.4)
>> 5.4.0 20160609
>> Kernel command line: console=ttyAMA0,38400 loglevel=8 root=/dev/sda2 rootwait
>> U-boot:
>>  ## Flattened Device Tree blob at 82000000
>>    Booting using the fdt blob at 0x82000000
>>    Loading Ramdisk to 9fcea000, end 9feea6d1 ... OK
>>    Loading Device Tree to 9fce2000, end 9fce9ad8 ... OK
>>
>> I'm not sure what else you need at this time - simply get back to me
>> with what I'm missing and I'll be happy to provided.  I'm also
>> offering to test patches.
>>
> 
> Fixed[1] and must be queued in rmk's tree[2].

Ah, brilliant. Thanks Sudeep.

	M.
-- 
Jazz is not dead. It just smells funny...
