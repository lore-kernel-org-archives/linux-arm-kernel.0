From: linus.walleij@linaro.org (Linus Walleij)
Date: Tue, 17 Jul 2012 20:15:40 +0200
Subject: [PATCH v2 1/2] pinctrl: pinctrl-imx: add support for set bits for
 general purpose registers
In-Reply-To: <20120717030225.GF19699@shlinux2.ap.freescale.net>
References: <1342084080-3145-1-git-send-email-b29396@freescale.com>
 <CACRpkdbHtgKLA3JJxc4VY35zSpJFvk15u62Z3aBCqERoeQ10CA@mail.gmail.com>
 <20120717030225.GF19699@shlinux2.ap.freescale.net>
Message-ID: <CACRpkdZei=U67wHQW6rKGkv0X10t4k+BEYE8uFZPbp-6Y60deQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jul 17, 2012 at 5:02 AM, Dong Aisheng <b29396@freescale.com> wrote:
> On Sun, Jul 15, 2012 at 04:43:03AM +0800, Linus Walleij wrote:

>> This whole issue appears in other systems so you're not alone
>> on this, for example the ux500 PRCMU driver has exactly these
>> properties.
>>
> So how does ux500 PRCMU handle this?

First, this driver is in MFD which is the most apropriate place I can
think of right now.

Then we have accessor functions, but when we just want to read/write a
register we have this API:

u32 db8500_prcmu_read(unsigned int reg);
void db8500_prcmu_write(unsigned int reg, u32 value);
void db8500_prcmu_write_masked(unsigned int reg, u32 mask, u32 value);

The third function is an oddity which performs read-modify-write
on the other side (firmware).

Yours,
Linus Walleij
