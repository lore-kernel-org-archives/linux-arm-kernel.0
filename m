From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Thu, 12 Jan 2012 20:37:56 +0000
Subject: [PATCH] versatile: don't generate a duplicate IRQ domain
In-Reply-To: <1325867997-20761-1-git-send-email-jamie@jamieiles.com>
References: <1325867997-20761-1-git-send-email-jamie@jamieiles.com>
Message-ID: <20120112203756.GM1068@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Jan 06, 2012 at 04:39:57PM +0000, Jamie Iles wrote:
> Now that the VIC driver handles the irqdomain natively we don't need to
> generate one in the versatile core code.  Longer term we should move the
> initialisation of both IRQ controllers to using of_irq_init() but
> that'll need a little more work.
> 
> Cc: Russell King <linux@arm.linux.org.uk>
> Cc: Grant Likely <grant.likely@secretlab.ca>
> Signed-off-by: Jamie Iles <jamie@jamieiles.com>

Please confirm that this patch can be applied ontop of commit
356b95424cfb456e14a59eaa579422ce014c424b
(Merge branch 'for-linus' of git://git.kernel.org/pub/scm/linux/kernel/git/geert/linux-m68k)

> I don't have a versatile platform so I can't run-test this, but I
> suspect that when booting with device tree without this patch it'll warn
> with "error: irq_desc already assigned to a domain".
> 
> I don't think this can be converted to of_irq_init() straight away
> without having all of the devices using IRQ's from DT and not relying on
> static IRQ numbers and without the hardware to test it I don't have
> enough confidence to do that.

What's needed to properly test this?  Note that I don't run these boards
with DT.
