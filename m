From: anders.berg@avagotech.com (Anders Berg)
Date: Mon, 15 Sep 2014 12:59:54 +0200
Subject: [PATCH] spi: pl022: Add support for chip select extension
In-Reply-To: <CACRpkdZfzsg-upNJaWX5CO6dJn3mg=wzhKhX-koask4ckxVTmQ@mail.gmail.com>
References: <1410360030-26634-1-git-send-email-anders.berg@avagotech.com>
 <CACRpkdavQBJkaC40GJkD396JkwPjSr_dzWegn8veLpG-Fcn-SQ@mail.gmail.com>
 <CAE0=X_1YMs1OUx3H65qbZ9CX-oSiW4Uo65Z7qCW8-6ksc4ovvQ@mail.gmail.com>
 <CACRpkdZfzsg-upNJaWX5CO6dJn3mg=wzhKhX-koask4ckxVTmQ@mail.gmail.com>
Message-ID: <CAE0=X_1Rh_XWKoR+wn=uz+hcKZtKtq+7eE_Q3QAEHoyfXCX57g@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Sep 12, 2014 at 7:00 PM, Linus Walleij <linus.walleij@linaro.org> wrote:
> On Thu, Sep 11, 2014 at 10:10 PM, Anders Berg <anders.berg@avagotech.com> wrote:
(...)
>> I picked 0xb6 since I've seen some reference manuals for other AMBA
>> peripherals the use of JEDEC assigned vendor IDs in this register field (see
>> the PL390 TRM for example). So I put the LSI Logic 7-bit JEDEC ID (0x36)
>> there: [0:6] = 0x36, [7] = 1 (the MSB set to '1' to signify the use of JEDEC
>> ID instead of a "classic" AMBA vendor).
>
> Hey that's very observant, I had no clue about that scheme!
>
> Can you write a comment about this in <linux/amba/bus.h> when
> you patch it (like above the enum) so we know that in the future
> when people need to pick new IDs?

Sure, will do.

/Anders
