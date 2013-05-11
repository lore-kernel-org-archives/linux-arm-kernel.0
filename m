From: kgene.kim@samsung.com (Kukjin Kim)
Date: Sun, 12 May 2013 00:28:50 +0900
Subject: [PATCH v5] pinctrl: Add pinctrl-s3c24xx driver
In-Reply-To: <201305111726.49491.heiko@sntech.de>
References: <201305031552.45410.heiko@sntech.de>
 <046401ce4d15$ccba0c80$662e2580$%kim@samsung.com>
 <201305111726.49491.heiko@sntech.de>
Message-ID: <067401ce4e5c$3cee48d0$b6cada70$%kim@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Heiko St?bner wrote:
> 
> Am Freitag, 10. Mai 2013, 02:32:05 schrieb Kukjin Kim:
> > Heiko St?bner wrote:
> > > The s3c24xx pins follow a similar pattern as the other Samsung SoCs
> and
> > > can therefore reuse the already introduced infrastructure.
> > >
> > > The s3c24xx SoCs have one design oddity in that the first 4 external
> > > interrupts do not reside in the eint pending register but in the main
> > > interrupt controller instead. We solve this by forwarding the external
> > > interrupt from the main controller into the irq domain of the pin bank.
> > > The masking/acking of these interrupts is handled in the same way.
> > >
> > > Furthermore the S3C2412/2413 SoCs contain another oddity in that they
> > > keep the same 4 eints in the main interrupt controller and eintpend
> > > register and requiring ack operations to happen in both. This is
> solved
> > > by using different compatible properties for the wakeup eint node
> which
> > > set a property accordingly.
> > >
> > > Signed-off-by: Heiko Stuebner <heiko@sntech.de>
> > > Reviewed-by: Tomasz Figa <t.figa@samsung.com>
> > > Reviewed-by: Sylwester Nawrocki <s.nawrocki@samsung.com>
> > > Acked-by: Linus Walleij <linus.walleij@linaro.org>
> >
> > Looks good to me.
> >
> > Linus, if you want me to take into samsung tree, please let me know.
> 
> in v4 Linus said:
> 
> "Are you taking this through the Samsung tree?"
> 
> This would also enable me to put the s3c2416 devicetree support on top of
> it
> in this cycle, which of course needs the pinctrl driver.
> 
OK, will apply into samsung tree.

Thanks.

- Kukjin
