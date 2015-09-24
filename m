From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Thu, 24 Sep 2015 12:15:03 +0200
Subject: [PATCH 2/4] pinctrl: sunxi: add allwinner A83T PIO controller
 support
In-Reply-To: <CAGb2v66gd9qe-yPwENp8e6incjiN7OhXKk00=1gbkofvKrM9og@mail.gmail.com>
References: <1442936337-3104-1-git-send-email-vishnupatekar0510@gmail.com>
 <1442936337-3104-3-git-send-email-vishnupatekar0510@gmail.com>
 <CAGb2v66gd9qe-yPwENp8e6incjiN7OhXKk00=1gbkofvKrM9og@mail.gmail.com>
Message-ID: <20150924101503.GQ4684@lukather>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Sep 23, 2015 at 12:06:56AM +0800, Chen-Yu Tsai wrote:
> > +static const struct sunxi_pinctrl_desc sun8i_a83t_pinctrl_data = {
> > +       .pins = sun8i_a83t_pins,
> > +       .npins = ARRAY_SIZE(sun8i_a83t_pins),
> > +       .irq_banks = 3,
> 
> Do you know if there's a hole at where PA_EINT interrupt registers
> should be? AFAIK we aren't handling that properly, but that is outside
> the scope of this patch.

Judging from the A83t datasheet, PB seems to be the first IRQ bank, so
it should be fine.

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
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20150924/7ee149ab/attachment.sig>
