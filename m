From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Tue, 20 Sep 2011 23:43:49 +0100
Subject: [PATCH V2] ARM: kdump: copy kernel relocation code at the
	kexec prepare stage
In-Reply-To: <1316520043-14619-1-git-send-email-leiwen@marvell.com>
References: <1316151129-30491-1-git-send-email-leiwen@marvell.com>
	<1316520043-14619-1-git-send-email-leiwen@marvell.com>
Message-ID: <20110920224349.GC17169@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Sep 20, 2011 at 08:00:43PM +0800, Lei Wen wrote:
> This copy really don't need to do at the very second before the kernel
> would crash.
> 
> Signed-off-by: Lei Wen <leiwen@marvell.com>
> Acked-by: Simon Horman <horms@verge.net.au>
> ---
> Changelog:
> V2: move the flush_icache_range after the memcpy operation to ensure I/D cache
>     coherency for the relocation code

Much better, thanks.
