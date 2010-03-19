From: hemanthv@ti.com (Hemanth V)
Date: Fri, 19 Mar 2010 19:58:41 +0530 (IST)
Subject: Highmem issues with MMC filesystem
In-Reply-To: <alpine.LFD.2.00.1003190908330.31128@xanadu.home>
References: <alpine.LFD.2.00.1003170946250.31128@xanadu.home>
	<043e01cac5df$c3ec1b90$LocalHost@wipblrx0099946>
	<alpine.LFD.2.00.1003171050160.31128@xanadu.home>
	<20100318092352.GD8267@n2100.arm.linux.org.uk>
	<c70ff3ad1003180415x58e29baaj9b8b77e6378cb0cb@mail.gmail.com>
	<20100318112453.GA19544@n2100.arm.linux.org.uk>
	<alpine.LFD.2.00.1003180904440.31128@xanadu.home>
	<EAF47CD23C76F840A9E7FCE10091EFAB02C489CB4A@dbde02.ent.ti.com>
	<20100318141930.GF19544@n2100.arm.linux.org.uk>
	<alpine.LFD.2.00.1003181205020.31128@xanadu.home>
	<20100319015523.GD14108@shareable.org>
	<alpine.LFD.2.00.1003190908330.31128@xanadu.home>
Message-ID: <5080.10.24.255.18.1269008921.squirrel@dbdmail.itg.ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

> Nicolas Pitre wrote:
>
> Furthermore the same highmem issues were reported to occur on an OMAP
> system with the filesystem on a MMC card i.e. different CPU manufacturer
> with a different block device driver.
>
> So the issue really seems to be about ARMv5 (works) vs ARMv6 (doesn't
> work), which makes some sense given the huge difference between both
> cache models.
>

Adding a cache flush before starting MMC DMA solves the problem for me,
so dumping cache contents can give some clues to the problem. Does anyone
have access to a debugger which can dump cache contents.

Thanks
Hemanth
