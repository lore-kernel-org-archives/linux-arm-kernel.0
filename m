From: catalin.marinas@arm.com (Catalin Marinas)
Date: Fri, 25 Jun 2010 13:36:03 +0100
Subject: Heads up: Linus plans to kill ARM defconfigs
In-Reply-To: <201006090807.20810.post@hendrik-sattler.de>
References: <201006090807.20810.post@hendrik-sattler.de>
Message-ID: <1277469363.13134.22.camel@e102109-lin.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, 2010-06-09 at 07:07 +0100, Hendrik Sattler wrote:
> Am Mittwoch 09 Juni 2010, 01:21:24 schrieb Ryan Mallon:
> > Yes. I thought the problem was that Kconfig doesn't work correctly for
> > this though. Does having 'select MTD_PARTITIONS' automatically cause
> > CONFIG_MTD to be set? If not, then you basically need to have the full
> > config option list, which is basically what defconfig is.
> 
> Anybody thought about improving Kconfig to make this possible?
> Specifying CONFIG_MTD and CONFIG_MTD_PARTITIONS again and again will just
> repeat information (that CONFIG_MTD_PARTITIONS depends on CONFIG_MTD).
> The recursive 'select' could have a different name.

A first step is a warning when selecting options with unmet dependencies
- http://lkml.org/lkml/2010/6/8/191.

This could be extended to automatically select the dependencies but it
many cases it could just be a Kconfig error.

-- 
Catalin
