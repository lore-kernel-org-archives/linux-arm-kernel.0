From: afzal.mohd.ma@gmail.com (Afzal Mohammed)
Date: Wed, 8 Feb 2017 17:53:54 +0530
Subject: [PATCH RESEND] ARM: ep93xx: Disable TS-72xx watchdog before
 uncompressing
In-Reply-To: <20170202201226.29631-1-f.fainelli@gmail.com>
References: <20170202201226.29631-1-f.fainelli@gmail.com>
Message-ID: <20170208122354.GA5912@afzalpc>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On Thu, Feb 02, 2017 at 12:12:26PM -0800, Florian Fainelli wrote:
> The TS-72xx/73xx boards have a CPLD watchdog which is configured to
> reset the board after 8 seconds, if the kernel is large enough that this
> takes about this time to decompress the kernel, we will encounter a
> spurious reboot.

so once it reaches Kernel proper, that dog is being killed, right ?

iirc, TI AM335x's & AM43x's ROM code too leaves the on-chip watchdog
enabled & the bootloader disables it (else once it boots to prompt, it
reboots always unless watchdog driver [if present] takes care of it),
Lokesh, right ?

But yes, that brings a bootloader dependency.

Regards
afzal
