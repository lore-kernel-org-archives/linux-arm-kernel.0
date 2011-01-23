From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Sun, 23 Jan 2011 17:48:14 +0000
Subject: [PATCH] ARM: OMAP2: use early init hook
In-Reply-To: <20110123171344.GH30094@n2100.arm.linux.org.uk>
References: <20110123171344.GH30094@n2100.arm.linux.org.uk>
Message-ID: <20110123174814.GI30094@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, Jan 23, 2011 at 05:13:44PM +0000, Russell King - ARM Linux wrote:
> Move non-mapping and non-irq initialization code out of .map_io and
> .init_irq respectively into the new init_early hook.
> 
> Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>
> ---
> I think I've updated this patch correctly for the new platforms merged
> into mainline.

Grr, this breaks on OMAP because some of this stuff wants to do ioremap()
and therefore wants the kmem allocators initialized.  That's rather
annoying...
