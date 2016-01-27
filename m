From: heiko@sntech.de (Heiko =?ISO-8859-1?Q?St=FCbner?=)
Date: Wed, 27 Jan 2016 15:10:19 +0100
Subject: [PATCH v2] pinctrl: rockchip: add support for the rk3399
In-Reply-To: <CACRpkdb6Cooo-_eBKJn-SdFkGPg2hR9nud7Tq6aa+bmkDuOEmg@mail.gmail.com>
References: <1451997055-47655-1-git-send-email-wdc@rock-chips.com>
 <1452152498-21780-1-git-send-email-wdc@rock-chips.com>
 <CACRpkdb6Cooo-_eBKJn-SdFkGPg2hR9nud7Tq6aa+bmkDuOEmg@mail.gmail.com>
Message-ID: <1664345.86tvmnNB3Q@diego>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Am Mittwoch, 27. Januar 2016, 15:02:18 schrieb Linus Walleij:
> On Thu, Jan 7, 2016 at 8:41 AM, David Wu <wdc@rock-chips.com> wrote:
> > From: David Wu <david.wu@rock-chips.com>
> > 
> > The pinctrl of rk3399 is much different from other's,
> > especially the 3bits of drive strength.
> > 
> > Signed-off-by: David Wu <david.wu@rock-chips.com>
> > ---
> > change from v1:
> > - need spin_unlock_irqrestore for set drive default case
> 
> Heiko can you please look at this patch?

sorry, about that falling so far down my inbox. I'll try to look at it today 
or tomorrow.

But overall it looks good.

@David: if you wake up before I manage to review more in-depth, the
"reading register twice" (+writing counterpart)
+                       /* need to read regs twice */
+                       ret = regmap_read(regmap, reg, &temp);
+                       if (ret)
+                               return ret;

should definitly get more explanation on how that access scheme works. Seems to 
be some special register access method with the register returning different 
values each time? As I don't have a manual for the soc yet this is definitly 
curious for me :-)

> 
> > +       { .compatible = "rockchip,rk3399-pinctrl",
> > +               .data = (void *)&rk3399_pin_ctrl },
> 
> I guess this requires a small patch to some binding file.
> It's OK to fold that into this patch.

@David:
Documentation/devicetree/bindings/pinctrl/rockchip,pinctrl.txt
