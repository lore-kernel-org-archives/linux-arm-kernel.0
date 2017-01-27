From: arnd@arndb.de (Arnd Bergmann)
Date: Fri, 27 Jan 2017 17:20:41 +0100
Subject: [PATCH v3 12/13] pinctrl: samsung: Move retention control from
 mach-s5pv210 to the pinctrl driver
In-Reply-To: <CACRpkdYSVvGPoJ-gLiyGuHrqz=GYHCmmFv_bD9HpAywPD5Yzzg@mail.gmail.com>
References: <CGME20170119134910eucas1p2d401df77ccc1ef8e7b05f4cdb2ffc8d3@eucas1p2.samsung.com>
 <1484833733-16082-13-git-send-email-m.szyprowski@samsung.com>
 <CACRpkdYSVvGPoJ-gLiyGuHrqz=GYHCmmFv_bD9HpAywPD5Yzzg@mail.gmail.com>
Message-ID: <7931853.ZcRrqCbIhv@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thursday, January 26, 2017 10:11:33 AM CET Linus Walleij wrote:
> On Thu, Jan 19, 2017 at 2:48 PM, Marek Szyprowski
> <m.szyprowski@samsung.com> wrote:
> 
> > This patch moves pad retention control from S5PV210 machine code to
> > Exynos pin controller driver. This helps to avoid possible ordering
> > and logical dependencies between machine and pin control code. Till
> > now it worked fine only because sys_ops for machine code and pin
> > controller were called in registration order.
> >
> > Signed-off-by: Marek Szyprowski <m.szyprowski@samsung.com>
> > Acked-by: Tomasz Figa <tomasz.figa@gmail.com>
> > For mach-s5pv210:
> > Acked-by: Krzysztof Kozlowski <krzk@kernel.org>
> > ---
> >  arch/arm/mach-s5pv210/pm.c               |  7 ----
> >  arch/arm/mach-s5pv210/regs-clock.h       |  4 ---
> >  drivers/pinctrl/samsung/pinctrl-exynos.c | 56 ++++++++++++++++++++++++++++++++
> 
> Same here, can I have an ARM SoC ACK?
> 

Acked-by: Arnd Bergmann <arnd@arndb.de>
