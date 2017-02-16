From: linux@armlinux.org.uk (Russell King - ARM Linux)
Date: Thu, 16 Feb 2017 17:33:48 +0000
Subject: [PATCH 0/3] Extend rtc-armada38x support for Armada 7K/8K
In-Reply-To: <20170216153136.27009-1-gregory.clement@free-electrons.com>
References: <20170216153136.27009-1-gregory.clement@free-electrons.com>
Message-ID: <20170216173348.GT27312@n2100.armlinux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Feb 16, 2017 at 04:31:33PM +0100, Gregory CLEMENT wrote:
> The Armada 7K/8K SoCs use the same RTC IP than the Armada 38x. However
> the SOC integration differs in 2 points:
>      - MBUS bridge timing initialization
>      - IRQ configuration at SoC level
> 
> This patch set extends the driver support to these SoCs family.

I've just tried merging this into my kernel, and...

root at mcbin:~# date
Thu Feb 16 17:33:00 GMT 2017
root at mcbin:~# hwclock -uw
root at mcbin:~# hwclock
Sun 07 Feb 2106 01:49:51 GMT  -10.010475 seconds
root at mcbin:~# hwclock
Sun 07 Feb 2106 01:49:51 GMT  -10.010458 seconds

I guess it needs the same hack that Armada38x needs - "date reset" twice
in uboot?

-- 
RMK's Patch system: http://www.armlinux.org.uk/developer/patches/
FTTC broadband for 0.8mile line: currently at 9.6Mbps down 400kbps up
according to speedtest.net.
