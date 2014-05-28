From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Wed, 28 May 2014 12:29:12 +0200
Subject: [PATCH 02/11] pinctrl: sunxi: add IRQCHIP_SKIP_SET_WAKE flag for
 pinctrl irq chip
In-Reply-To: <5384B9E7.1070405@gmail.com>
References: <1401090486-4414-1-git-send-email-hdegoede@redhat.com>
 <1401090486-4414-3-git-send-email-hdegoede@redhat.com>
 <20140527080746.GB4730@lukather> <5384B9E7.1070405@gmail.com>
Message-ID: <20140528102912.GP4730@lukather>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, May 27, 2014 at 06:14:31PM +0200, Tomasz Figa wrote:
> On 27.05.2014 10:07, Maxime Ripard wrote:
> > On Mon, May 26, 2014 at 09:47:57AM +0200, Hans de Goede wrote:
> >> From: Chen-Yu Tsai <wens@csie.org>
> >> 
> >> The sunxi pinctrl irq chip driver does not support wakeup at the 
> >> moment. Adding IRQCHIP_SKIP_SET_WAKE lets the irqs work with
> >> drivers using wakeup.
> >> 
> >> Also add a name to the irq chip.
> >> 
> >> Signed-off-by: Chen-Yu Tsai <wens@csie.org> Signed-off-by: Hans
> >> de Goede <hdegoede@redhat.com> --- 
> >> drivers/pinctrl/sunxi/pinctrl-sunxi.c | 2 ++ 1 file changed, 2
> >> insertions(+)
> >> 
> >> diff --git a/drivers/pinctrl/sunxi/pinctrl-sunxi.c
> >> b/drivers/pinctrl/sunxi/pinctrl-sunxi.c index db9ccd6..ec60c2e
> >> 100644 --- a/drivers/pinctrl/sunxi/pinctrl-sunxi.c +++
> >> b/drivers/pinctrl/sunxi/pinctrl-sunxi.c @@ -646,6 +646,8 @@
> >> static struct irq_chip sunxi_pinctrl_irq_chip = { .irq_mask_ack	=
> >> sunxi_pinctrl_irq_mask_ack, .irq_unmask	=
> >> sunxi_pinctrl_irq_unmask, .irq_set_type	=
> >> sunxi_pinctrl_irq_set_type, +	.name		= "sunxi-pio", +	.flags		=
> >> IRQCHIP_SKIP_SET_WAKE,
> > 
> > I'd rather see the name set to dev_name() or something like that.
> > This will not work that great with multiple pin controller
> > supporting interrupts.
> 
> Correct me if I'm wrong, but I've always thought that struct irq_chip
> describes a class of IRQ controllers, not particular instances.

It's not said as such in <linux/irq.h>, but maybe..

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
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20140528/50f075cd/attachment.sig>
