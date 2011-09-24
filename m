From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Sat, 24 Sep 2011 11:12:31 +0100
Subject: I-cache/D-cache inconsistency issue with page cache
In-Reply-To: <20110924100701.GA5908@glandium.org>
References: <20110923115721.GA7013@glandium.org>
	<20110923193941.GQ17169@n2100.arm.linux.org.uk>
	<20110924093544.GA5724@glandium.org>
	<20110924094734.GC17169@n2100.arm.linux.org.uk>
	<20110924100701.GA5908@glandium.org>
Message-ID: <20110924101231.GD17169@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, Sep 24, 2011 at 12:07:01PM +0200, Mike Hommey wrote:
> This has been seen on tegra boards under Ubuntu Maverick
> (2.6.35.7.something) and under Android (2.6.32.9.something) and on the Asus
> Transformer (Android, 2.6.36.3.something). All Cortex-A9 tegras. It has
> *not* been reproduced on pandaboards (Cortex-A9 OMAP4430).

Ah, your kernels are probably too old.

You need to ensure that you have at least 6012191 (ARM: 6380/1:
Introduce __sync_icache_dcache() for VIPT caches) and 85848dd (ARM:
6381/1: Use lazy cache flushing on ARMv7 SMP systems).  Note that both
these depend on some preceding patches too.
