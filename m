From: balbi@ti.com (Felipe Balbi)
Date: Thu, 10 Apr 2014 16:55:27 -0500
Subject: [PATCH] irq: crossbar: improve allocate_free_irq() complexity
In-Reply-To: <1396392259-27437-1-git-send-email-balbi@ti.com>
References: <1396392259-27437-1-git-send-email-balbi@ti.com>
Message-ID: <20140410215527.GF27668@saruman.home>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Apr 01, 2014 at 05:44:19PM -0500, Felipe Balbi wrote:
> current algorithm in allocate_free_irq() is O(n),
> by just keeping track of last allocated IRQ with a
> simple unsigned integer, we can find a free IRQ
> in O(1).
> 
> Signed-off-by: Felipe Balbi <balbi@ti.com>
> ---
> 
> compile-tested only as J6 DTS is currently missing crossbar
> altogether :-(
> 
> There's a drawback with this patch which I'm not sure if we
> should care a lot because I couldn't entirely grasp when is
> domain->xlate() called and if we will map/unmap IRQs in runtime
> or will this *always* be done only during boot.
> 
> If we're talking about runtime IRQ remapping, then this, clearly,
> won't work. But if this will be done only during boot up, then we
> avoid iterating over the irq_map array each time we try to translate
> a new IRQ prior to mapping it.
> 
> Comments are highly welcome as I'll probably learn something new
> about the IRQ subsystem ;-)

do not apply this one!!! It won't work in all cases.

-- 
balbi
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 819 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20140410/76691006/attachment.sig>
