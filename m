From: broonie@kernel.org (Mark Brown)
Date: Mon, 9 Jun 2014 12:56:43 +0100
Subject: [PATCH 1/5] mfd: Add driver for Maxim 77802 Power Management IC
In-Reply-To: <1402309361.17650.14.camel@AMDC1943>
References: <1402306670-17041-1-git-send-email-javier.martinez@collabora.co.uk>
 <1402306670-17041-2-git-send-email-javier.martinez@collabora.co.uk>
 <1402309361.17650.14.camel@AMDC1943>
Message-ID: <20140609115643.GZ5099@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Jun 09, 2014 at 12:22:41PM +0200, Krzysztof Kozlowski wrote:
> On pon, 2014-06-09 at 11:37 +0200, Javier Martinez Canillas wrote:

> > +static const struct max77802_irq_data max77802_irqs[] = {
> > +	DECLARE_IRQ(MAX77802_PMICIRQ_PWRONF,	PMIC_INT1, 1 << 0),
> > +	DECLARE_IRQ(MAX77802_PMICIRQ_PWRONR,	PMIC_INT1, 1 << 1),

> Why just not use two regmap_irq_chips (for PMIC and RTC blocks)
> replacing whole max77802-irq.c file?

If they share the same primary IRQ line something like what the arizona
drivers do should handle things well enough.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20140609/ad590f22/attachment.sig>
