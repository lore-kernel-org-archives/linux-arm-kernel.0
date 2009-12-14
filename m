From: anders.grafstrom@netinsight.net (=?ISO-8859-1?Q?Anders_Grafstr=F6m?=)
Date: Mon, 14 Dec 2009 19:47:10 +0100
Subject: [PATCH 2/7] ARM: dma-mapping: simplify page_to_dma()
	and	__pfn_to_bus()
In-Reply-To: <20091212143748.GC30537@n2100.arm.linux.org.uk>
References: <20091120182539.GG16920@n2100.arm.linux.org.uk>
	<E1NBYE2-0005kv-7H@rmk-PC.arm.linux.org.uk>
	<4B23A23B.7070208@netinsight.net>
	<20091212143748.GC30537@n2100.arm.linux.org.uk>
Message-ID: <4B26882E.5000801@netinsight.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Russell King - ARM Linux wrote:
> No, because bus addresses on footbridge are not physical addresses.  This
> should solve the problem:
> 
> diff --git a/arch/arm/mach-footbridge/common.c b/arch/arm/mach-footbridge/common.c
> index b97f529..41febc7 100644
> --- a/arch/arm/mach-footbridge/common.c
> +++ b/arch/arm/mach-footbridge/common.c

Appears to be good. I did a quick test run and saw no problem.
