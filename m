From: arnd@arndb.de (Arnd Bergmann)
Date: Thu, 19 Jul 2012 13:13:45 +0000
Subject: Devicetree: Initialization order of mmc block devices?
In-Reply-To: <5006571A.7060103@de.bosch.com>
References: <5006571A.7060103@de.bosch.com>
Message-ID: <201207191313.46178.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wednesday 18 July 2012, Dirk Behme wrote:
> Any idea how we could influence the initialization order of the mmc 
> block devices using a DT based kernel? Ensuring that the internal, hard 
> wired mmc card is always mapped to mmcblk0?

I think the best solution would be to parse the "/aliases" device node
and look for an "mmc0" or "mmc1" property with a phandle to the respective
device. That's how we sort the serial ports. We have the of_alias_get_id()
function to pick out a node from there, so it should be possible to use
that in the mmc core similar to how we use it in the uart drivers.

	Arnd
