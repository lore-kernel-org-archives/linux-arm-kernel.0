From: balbi@ti.com (Felipe Balbi)
Date: Wed, 5 Jan 2011 08:47:22 +0200
Subject: [PATCH 1/4] arm: omap: gpio: don't access irq_desc array directly
In-Reply-To: <87r5cs42p1.fsf@ti.com>
References: <1294142577-28772-1-git-send-email-balbi@ti.com>
	<1294142577-28772-2-git-send-email-balbi@ti.com>
	<87r5cs42p1.fsf@ti.com>
Message-ID: <20110105064722.GC2458@legolas.emea.dhcp.ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jan 04, 2011 at 04:24:58PM -0800, Kevin Hilman wrote:
> Felipe Balbi <balbi@ti.com> writes:
> 
> > Instead of accessing the irq_desc array directly
> > we can use irq_to_desc(irq). That will allow us to,
> > if wanted, select SPARSE_IRQ and irq_descs will be
> > added to a radix tree, instead of a array.
> >
> > Signed-off-by: Felipe Balbi <balbi@ti.com>
> 
> Can you refresh this one against Tony's omap-for-linus branch. The GPIO
> omap_device/hwmod conversion changed things around a bit and this patch
> doesn't apply.
> 
> After that, you can send separately, and I'll queue this one along with
> some other GPIO core fixes for the 2.6.38-rc series after -rc1 comes
> out.

Sure, it's attached to this mail.

-- 
balbi
