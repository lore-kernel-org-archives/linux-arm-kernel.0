From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Tue, 1 Jul 2014 16:41:02 +0200
Subject: [PATCH v3 3/4] pinctrl: sunxi: Properly handle level triggered
 gpio interrupts
In-Reply-To: <1404051062-24079-4-git-send-email-hdegoede@redhat.com>
References: <1404051062-24079-1-git-send-email-hdegoede@redhat.com>
 <1404051062-24079-4-git-send-email-hdegoede@redhat.com>
Message-ID: <20140701144102.GO28647@lukather>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, Jun 29, 2014 at 04:11:01PM +0200, Hans de Goede wrote:
> For level triggered gpio interrupts we need to use handle_fasteoi_irq,
> like we do with the irq-sunxi-nmi driver. This is necessary to give threaded
> interrupt handlers a chance to actuall clear the source of the interrupt
> (which may involve sleeping waiting for i2c / spi / mmc transfers), before
> acknowledging the interrupt.
> 
> Signed-off-by: Hans de Goede <hdegoede@redhat.com>

Acked-by: Maxime Ripard <maxime.ripard@free-electrons.com>

Thanks!
Maxime

-- 
Maxime Ripard, Free Electrons
Embedded Linux, Kernel and Android engineering
http://free-electrons.com
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 819 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20140701/a357d7dd/attachment.sig>
