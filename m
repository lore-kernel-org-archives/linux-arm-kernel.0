From: t.figa@samsung.com (Tomasz Figa)
Date: Wed, 10 Oct 2012 10:23:53 +0200
Subject: [PATCH 02/16] pinctrl: exynos: Parse wakeup-eint parameters from
 DT
In-Reply-To: <CACRpkdZ97BRHo1Usen-D9CnojU4HLqkNb5CKNOmx7uP1A9ttgw@mail.gmail.com>
References: <1349685556-23718-1-git-send-email-t.figa@samsung.com>
 <1349685556-23718-3-git-send-email-t.figa@samsung.com>
 <CACRpkdZ97BRHo1Usen-D9CnojU4HLqkNb5CKNOmx7uP1A9ttgw@mail.gmail.com>
Message-ID: <2083377.E0rtGYPSc2@amdc1227>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wednesday 10 of October 2012 09:18:51 Linus Walleij wrote:
> On Mon, Oct 8, 2012 at 10:39 AM, Tomasz Figa <t.figa@samsung.com> wrote:
> > This patch converts the pinctrl-exynos driver to parse wakeup interrupt
> > count and register offsets from device tree. It reduces the amount of
> > static platform-specific data and facilitates adding further SoC
> > variants to pinctrl-samsung driver.
> 
> So these are:
> > +       ret = of_property_read_u32(wkup_np, "samsung,weint-count",
> > &val); +       ret = of_property_read_u32(wkup_np,
> > "samsung,weint-con", &val); +       ret =
> > of_property_read_u32(wkup_np, "samsung,weint-mask", &val); +       ret
> > = of_property_read_u32(wkup_np, "samsung,weint-pend", &val);
> Are these all four register offsets?
> 
> I don't think it's proper for the device tree to contain register
> offsets.
> 
> Base address, "regs" property, yes. Individual registers, no. That just
> makes the code hard to read and compare to the datasheet.
> 
> Or what are you aiming at here?

See my reply to your comments for patch 1. I think it should explain how 
these values are used.

One thing worth mentioning is that registers for GPIO interrupts and wakeup 
interrupts can be located at different areas of pin controller address 
space, so these offsets have to be specified for both (using geint-* and 
weint-* properties).

Best regards,
-- 
Tomasz Figa
Samsung Poland R&D Center
