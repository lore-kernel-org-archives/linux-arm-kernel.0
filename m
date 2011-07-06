From: mina86@mina86.com (Michal Nazarewicz)
Date: Wed, 06 Jul 2011 18:09:00 +0200
Subject: [PATCH 6/8] drivers: add Contiguous Memory Allocator
In-Reply-To: <alpine.DEB.2.00.1107061100290.17624@router.home>
References: <1309851710-3828-1-git-send-email-m.szyprowski@samsung.com>
	<201107061609.29996.arnd@arndb.de>
	<20110706142345.GC8286@n2100.arm.linux.org.uk>
	<201107061651.49824.arnd@arndb.de>
	<20110706154857.GG8286@n2100.arm.linux.org.uk>
	<alpine.DEB.2.00.1107061100290.17624@router.home>
Message-ID: <op.vx7ghajd3l0zgt@mnazarewicz-glaptop>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, 06 Jul 2011 18:05:00 +0200, Christoph Lameter <cl@linux.com> wrote:
> ZONE_DMA is a zone for memory of legacy (crippled) devices that cannot  
> DMA into all of memory (and so is ZONE_DMA32).  Memory from ZONE_NORMAL
> can be used for DMA as well and a fully capable device would be expected
> to handle any memory in the system for DMA transfers.
>
> "guaranteed" dmaable memory? DMA abilities are device specific. Well  
> maybe you can call ZONE_DMA memory to be guaranteed if you guarantee
> that any device must at mininum be able to perform DMA into ZONE_DMA
> memory. But there may not be much of that memory around so you would
> want to limit the use of that scarce resource.

As pointed in Marek's other mail, this reasoning is not helping in any
way.  In case of video codec on various Samsung devices (and from some
other threads this is not limited to Samsung), the codec needs separate
buffers in separate memory banks.

-- 
Best regards,                                         _     _
.o. | Liege of Serenely Enlightened Majesty of      o' \,=./ `o
..o | Computer Science,  Michal "mina86" Nazarewicz    (o o)
ooo +-----<email/xmpp: mnazarewicz@google.com>-----ooO--(_)--Ooo--
