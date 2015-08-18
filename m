From: santosh.shilimkar@oracle.com (santosh.shilimkar at oracle.com)
Date: Mon, 17 Aug 2015 20:09:17 -0700
Subject: [PATCH] ARM: keystone: add a work around to handle asynchronous
 external abort
In-Reply-To: <55D25C64.3090107@ti.com>
References: <1439320409-20084-1-git-send-email-m-karicheri2@ti.com>
 <55CDF579.4050408@ti.com> <20150814140934.GX7557@n2100.arm.linux.org.uk>
 <55CE05EC.4040909@oracle.com> <55CE633C.10402@ti.com>
 <20150814215617.GA7557@n2100.arm.linux.org.uk> <55D25C64.3090107@ti.com>
Message-ID: <55D2A1DD.9000007@oracle.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Murali,

On 8/17/15 3:12 PM, Murali Karicheri wrote:
> On 08/14/2015 05:56 PM, Russell King - ARM Linux wrote:
>> On Fri, Aug 14, 2015 at 05:53:00PM -0400, Murali Karicheri wrote:
>>> We have spend some time already to debug the root cause. Do you have
>>> idea on
>>> how this was hunted down on OMAP that we can learn from? The bad
>>> address is
>>> NULL and it seems to happen very rarely and is not easily reproducible.
>>> Don't want to put this workaround, but we couldn't track it down
>>> either. So
>>> any help to debug this will be appreciated.
>>
>> If you try applying Lucas' patch, you should receive the abort earlier
>> in the kernel boot up, which may help narrow down what is provoking it.
>>
>
> Unfortunately, this patch causes boot to stop very early just after
> local_abt_enable() is called in early_trap_init(). Before and After
> applying the patch, here is what the boot log looks like. Do you see any
> issue with the patch diff shown below? Patch is applied on top of
> v4.2-rc7. I have some additional base port patches applied to boot
> kernel on my EVM based on a new SoC.
>

 From the logs this seems to be mostly clock related issue for some
peripheral. If the bootloader clock enable all hack still exists,
may be you can try that out.

Another way to debug this is to start disabling peripheral drivers
from the kernel 1 by 1 and see if the issue goes away.

Regards,
Santosh
