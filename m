From: linus.walleij@linaro.org (Linus Walleij)
Date: Wed, 18 Jan 2012 13:20:27 +0100
Subject: [PATCH] RFC: spi/sa1100: rewrite the SA1100 SPI driver
In-Reply-To: <CACRpkdbynmvcjOY=7_6wK3YTJHpS16Y0fU-Ka3-qw6Vt+eXy0A@mail.gmail.com>
References: <1326841236-25178-1-git-send-email-linus.walleij@linaro.org>
 <20120117231314.GA1068@n2100.arm.linux.org.uk>
 <CACRpkdbynmvcjOY=7_6wK3YTJHpS16Y0fU-Ka3-qw6Vt+eXy0A@mail.gmail.com>
Message-ID: <CACRpkdZH4EKN0FydW5S90BvL9jKanLSXpQcyoVngMem0qed+Fw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jan 18, 2012 at 1:13 PM, Linus Walleij <linus.walleij@linaro.org> wrote:
> On Wed, Jan 18, 2012 at 12:13 AM, Russell King - ARM Linux
> <linux@arm.linux.org.uk> wrote:
>
>> The SSP interface is more than just SPI (it's microwire and TI format,
>> and I have a working ASoC driver for the Assabet.)
>
> We usually merge drivers for microwire, TI, Motorola ... etc into
> drivers/spi as well. It's a good enough fit, the differences are very
> small. This is how we configure mode from the PL022 driver platform data:

By the way, the similarities between the SA1100 SSP and the PL022
SSP/SPI were striking so I had a look at the register maps, but while
many of the registers are similarly named and many of the same bits
exist these bits are in wildly different places, so it's not directly
mergeable.

It looks like the PL022 SSP is a hardware based on the SA1100 SSP
datasheet or even the VHDL code for it.

PrimeCell geneaology is one of these funny things, If I find genetic
evidence, i.e. the hardware happen to have the same obscure bugs,
then I cosider the ancestry proven...

Yours,
Linus Walleij
