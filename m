From: kyle@mcmartin.ca (Kyle McMartin)
Date: Thu, 15 Oct 2009 17:48:05 -0400
Subject: [PATCH] [ARM] force dcache flush if dcache_dirty bit set
In-Reply-To: <Pine.LNX.4.64.0910121855070.21347@sister.anvils>
References: <1255337423-3158-1-git-send-email-ngupta@vflare.org>
	<20091012090710.GA29310@n2100.arm.linux.org.uk>
	<20091012.023744.157085851.davem@davemloft.net>
	<20091012100023.GC29310@n2100.arm.linux.org.uk>
	<Pine.LNX.4.64.0910121634170.7327@sister.anvils>
	<20091012170312.GB9453@flint.arm.linux.org.uk>
	<Pine.LNX.4.64.0910121855070.21347@sister.anvils>
Message-ID: <20091015214805.GP11702@bombadil.infradead.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Oct 12, 2009 at 07:06:04PM +0100, Hugh Dickins wrote:
> The architectures which appear to need fixing in the same way are
> arm, mips, parisc, sh and sparc64 (xtensa looks right already, and
> score just looks confused - a whole function __update_cache() which
> checks for PG_arch_1, yet nothing sets it?).
> 

parisc looks affected as well, though I don't recall the semantics of
dcache flushing without a mapping. James, can you send a patch?

WRT score, which seems to have been mostly cobbled together as a modern
copy of mips, it can likely be eliminated entirely, as it looks to have
been cargoculted from mips without thought.

regards, Kyle
