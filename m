From: broonie@opensource.wolfsonmicro.com (Mark Brown)
Date: Tue, 17 Jul 2012 19:24:34 +0100
Subject: [PATCH v2 1/2] pinctrl: pinctrl-imx: add support for set bits
 for general purpose registers
In-Reply-To: <CACRpkdZei=U67wHQW6rKGkv0X10t4k+BEYE8uFZPbp-6Y60deQ@mail.gmail.com>
References: <1342084080-3145-1-git-send-email-b29396@freescale.com>
 <CACRpkdbHtgKLA3JJxc4VY35zSpJFvk15u62Z3aBCqERoeQ10CA@mail.gmail.com>
 <20120717030225.GF19699@shlinux2.ap.freescale.net>
 <CACRpkdZei=U67wHQW6rKGkv0X10t4k+BEYE8uFZPbp-6Y60deQ@mail.gmail.com>
Message-ID: <20120717182434.GB11723@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jul 17, 2012 at 08:15:40PM +0200, Linus Walleij wrote:

> u32 db8500_prcmu_read(unsigned int reg);
> void db8500_prcmu_write(unsigned int reg, u32 value);
> void db8500_prcmu_write_masked(unsigned int reg, u32 mask, u32 value);

> The third function is an oddity which performs read-modify-write
> on the other side (firmware).

Not so odd - a very high proportion of APIs like this have a r/m/w
operation as there's usually a requirement for doing the updates
atomically.
