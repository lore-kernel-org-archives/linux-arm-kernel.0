From: lokeshvutla@ti.com (Lokesh Vutla)
Date: Mon, 13 Feb 2017 09:08:12 +0530
Subject: [PATCH RESEND] ARM: ep93xx: Disable TS-72xx watchdog before
 uncompressing
In-Reply-To: <20170208122354.GA5912@afzalpc>
References: <20170202201226.29631-1-f.fainelli@gmail.com>
 <20170208122354.GA5912@afzalpc>
Message-ID: <d7f36fd2-bc44-9339-d296-b3fc6dfb0531@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



On Wednesday 08 February 2017 05:53 PM, Afzal Mohammed wrote:
> Hi,
> 
> On Thu, Feb 02, 2017 at 12:12:26PM -0800, Florian Fainelli wrote:
>> The TS-72xx/73xx boards have a CPLD watchdog which is configured to
>> reset the board after 8 seconds, if the kernel is large enough that this
>> takes about this time to decompress the kernel, we will encounter a
>> spurious reboot.
> 
> so once it reaches Kernel proper, that dog is being killed, right ?
> 
> iirc, TI AM335x's & AM43x's ROM code too leaves the on-chip watchdog
> enabled & the bootloader disables it (else once it boots to prompt, it
> reboots always unless watchdog driver [if present] takes care of it),
> Lokesh, right ?

Yes, that's right. Watchdog is disabled in U-Boot.

Thanks and regards,
Lokesh
