From: ryan@bluewatersys.com (Ryan Mallon)
Date: Thu, 10 Jun 2010 09:56:07 +1200
Subject: Heads up: Linus plans to kill ARM defconfigs
In-Reply-To: <201006090807.20810.post@hendrik-sattler.de>
References: <4C083BCF.2060500@bluewatersys.com>	<alpine.LFD.2.00.1006081655350.30664@xanadu.home>	<4C0ED074.7050700@bluewatersys.com>
	<201006090807.20810.post@hendrik-sattler.de>
Message-ID: <4C100DF7.3040907@bluewatersys.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hendrik Sattler wrote:
> Am Mittwoch 09 Juni 2010, 01:21:24 schrieb Ryan Mallon:
>> Yes. I thought the problem was that Kconfig doesn't work correctly for
>> this though. Does having 'select MTD_PARTITIONS' automatically cause
>> CONFIG_MTD to be set? If not, then you basically need to have the full
>> config option list, which is basically what defconfig is.
> 
> Anybody thought about improving Kconfig to make this possible?
> Specifying CONFIG_MTD and CONFIG_MTD_PARTITIONS again and again will just 
> repeat information (that CONFIG_MTD_PARTITIONS depends on CONFIG_MTD).
> The recursive 'select' could have a different name.

This could be done by manually fixing the Kconfig files and using the
select keyword to specify mandatory dependencies. For example CONFIG_MTD
should select CONFIG_MTD_PARTITIONS since it cannot work without it. The
MTD_PARTITIONS option will still be hidden until MTD is selected because
of the 'if MTD' at the top of drivers/mtd/Kconfig, but it means the
other Kconfig files doing a select MTD_PARTITIONS would work correctly.

Would be a lot of work to go through all of the Kconfig files and fix
this though.

~Ryan

-- 
Bluewater Systems Ltd - ARM Technology Solution Centre

Ryan Mallon         		5 Amuri Park, 404 Barbadoes St
ryan at bluewatersys.com         	PO Box 13 889, Christchurch 8013
http://www.bluewatersys.com	New Zealand
Phone: +64 3 3779127		Freecall: Australia 1800 148 751
Fax:   +64 3 3779135			  USA 1800 261 2934
