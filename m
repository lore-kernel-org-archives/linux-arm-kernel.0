From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Mon, 31 Mar 2014 13:06:31 +0200
Subject: [PATCH 2/2] ARM: sun7i/sun6i: irqchip: Disable NMI before
 registering the handler
In-Reply-To: <1395939759-11135-3-git-send-email-carlo@caione.org>
References: <1395939759-11135-1-git-send-email-carlo@caione.org>
 <1395939759-11135-3-git-send-email-carlo@caione.org>
Message-ID: <20140331110631.GF26751@lukather>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Mar 27, 2014 at 06:02:39PM +0100, Carlo Caione wrote:
> From: Hans de Goede <hdegoede@redhat.com>
> 
> It is advisable to disable the NMI before registering the IRQ handler as
> registering the IRQ handler unmasks the IRQ on the GIC, so if U-Boot has
> left the NMI enabled and the NMI pin is active we will immediately get
> an interrupt before any driver has claimed the downstream interrupt of
> the NMI.
> 
> Signed-off-by: Hans de Goede <hdegoede@redhat.com>
> Signed-off-by: Carlo Caione <carlo@caione.org>

Acked-by: Maxime Ripard <maxime.ripard@free-electrons.com>

Thanks!

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
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20140331/ece0e7d5/attachment.sig>
