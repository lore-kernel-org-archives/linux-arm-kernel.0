From: huangtao@rock-chips.com (Huang, Tao)
Date: Tue, 3 Nov 2015 20:00:06 +0800
Subject: [RESEND PATCH 0/1] Fix the "hard LOCKUP" when running a heavy
 loading
In-Reply-To: <20151103111437.GU8644@n2100.arm.linux.org.uk>
References: <1446538209-13490-1-git-send-email-wxt@rock-chips.com>
 <20151103111437.GU8644@n2100.arm.linux.org.uk>
Message-ID: <5638A1C6.30200@rock-chips.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello Russell:

? 2015?11?03? 19:14, Russell King - ARM Linux ??:
> On Tue, Nov 03, 2015 at 04:10:08PM +0800, Caesar Wang wrote:
>> As the Russell said:
>> "in other words, which can be handled by updating a control register in
>> the firmware or boot loader"
>> Maybe the better solution is in firmware.
> 
> The full quote is:
> 
> "I think we're at the point where we start insisting that workarounds
> which are simple enable/disable feature bit operations (in other words,
> which can be handled by updating a control register in the firmware or
> boot loader) must be done that way, and we are not going to add such
> workarounds to the kernel anymore."
> 
> The position hasn't changed.  Workarounds such as this should be handled
> in the firmware/boot loader before control is passed to the kernel.
> 
> The reason is very simple: if the C compiler can generate code which
> triggers the bug, it can generate code which triggers the bug in the
> boot loader.  So, the only place such workarounds can be done is before
> any C code gets executed.  Putting such workarounds in the kernel is
> completely inappropriate.

I agree with your reason for CPU0. But how about CPU1~3 if we don't use
any firmware such as ARM Trusted Firmware to take control of CPU power
on? If the CPU1~3 will run on Linux when its first instruction is running?

BTW I don't want to argue with you the workaround is right or wrong
because I know the errata just happen on r0p0 not r0p1.

> 
> Sorry, I'm not going to accept this workaround into the kernel.

It seems we should introduce some code outside the kernel to do such
initialization?
