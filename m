From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Mon, 2 Jun 2014 12:18:08 +0200
Subject: [PATCH v2 1/5] pinctrl: sunxi: Fix sunxi_irq_cfg_reg not working
 for irqs >= 8
In-Reply-To: <1401544899-405-2-git-send-email-hdegoede@redhat.com>
References: <1401544899-405-1-git-send-email-hdegoede@redhat.com>
 <1401544899-405-2-git-send-email-hdegoede@redhat.com>
Message-ID: <20140602101808.GB27722@lukather>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, May 31, 2014 at 04:01:35PM +0200, Hans de Goede wrote:
> Rename SUNXI_IRQ_NUMBER to IRQ_PER_BANK as it no longer represents the total
> number of irqs and use it instead of the number of irqs-per-reg when
> calculating the bank to use for the various sunxi_irq_xxx_reg functions.
> This fixes sunxi_irq_cfg_reg using the wrong bank for irqs >= 8.
> 
> Also sunxi_irq_cfg_reg_from_bank returns the address of pio_int_cfg0, add an
> offset to the register returned for irqs living in the pio_int_cfg[1-3].
> 
> Signed-off-by: Hans de Goede <hdegoede@redhat.com>

Good catch, I've squashed it into my serie with minor modifications
(remove the cfg_reg_from_bank that doesn't make any sense).

Thanks,
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
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20140602/52ee3706/attachment.sig>
