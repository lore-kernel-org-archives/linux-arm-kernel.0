From: linus.walleij@linaro.org (Linus Walleij)
Date: Thu, 11 Sep 2014 15:26:01 +0200
Subject: [PATCH] spi: pl022: Add support for chip select extension
In-Reply-To: <1410360030-26634-1-git-send-email-anders.berg@avagotech.com>
References: <1410360030-26634-1-git-send-email-anders.berg@avagotech.com>
Message-ID: <CACRpkdavQBJkaC40GJkD396JkwPjSr_dzWegn8veLpG-Fcn-SQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Sep 10, 2014 at 4:40 PM, Anders Berg <anders.berg@avagotech.com> wrote:

> Add support for a extended PL022 which has an extra register for controlling up
> to five chip select signals. This controller is found on the AXM5516 SoC.
> Unfortunately the PrimeCell identification registers are identical to a
> standard ARM PL022. To work around this, the peripheral ID must be overridden
> in the device tree using the "arm,primecell-periphid" property with the value
> 0x000b6022.
>
> Signed-off-by: Anders Berg <anders.berg@avagotech.com>
(...)
> +               /*
> +                * PL022 variant that has a chip select control register whih
> +                * allows control of 5 output signals nCS[0:4].
> +                */
> +               .id     = 0x000b6022,

OK so you're defining 0xb6 to the the 8bit ID for LSI.

Do you have some special reason for this, like that it appears
in some other silicon block from LSI? Otherwise I suggest using
0x4c (uppercase 'L') so as to follow the pattern of the other
vendor IDs.

Please patch include/linux/amba/bus.h to add
AMBA_VENDOR_LSI = 0x4c (or 6b) as well, as this is the first
occurence.

Yours,
Linus Walleij
