From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Thu, 13 Mar 2014 10:29:17 +0100
Subject: [PATCH v2 2/4] irqchip: sun4i: Fix irq 0 not working
In-Reply-To: <1394644627-12315-3-git-send-email-hdegoede@redhat.com>
References: <1394644627-12315-1-git-send-email-hdegoede@redhat.com>
 <1394644627-12315-3-git-send-email-hdegoede@redhat.com>
Message-ID: <20140313092917.GE2815@lukather>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Mar 12, 2014 at 06:17:05PM +0100, Hans de Goede wrote:
> SUN4I_IRQ_VECTOR_REG containing 0 can mean one of 3 things:
> 1) no more irqs pending
> 2) irq 0 pending
> 3) spurious irq
> 
> So if we immediately get a reading of 0, check the irq-pending reg
> to differentiate between 2 and 3. We only do this once to avoid
> the extra check in the common case of 1) hapening after having
> read the vector-reg once.
> 
> Signed-off-by: Hans de Goede <hdegoede@redhat.com>

Acked-by: Maxime Ripard <maxime.ripard@free-electrons.com>

Maxime

-- 
Maxime Ripard, Free Electrons
Embedded Linux, Kernel and Android engineering
http://free-electrons.com
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20140313/b1b0a8a0/attachment.sig>
