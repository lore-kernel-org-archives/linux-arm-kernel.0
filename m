From: broonie@kernel.org (Mark Brown)
Date: Mon, 7 Jul 2014 08:32:44 +0100
Subject: [PATCH 1/3 v5] spi: s3c64xx: fix broken "cs_gpios" usage in the
 driver
In-Reply-To: <CAHfPSqAXs=5VLLEV-XVw5YJo=-9QFn9KA8oG_A0CfNykcVwnCQ@mail.gmail.com>
References: <1402631992-500-1-git-send-email-ch.naveen@samsung.com>
 <20140702165651.GK410@sirena.org.uk>
 <CAHfPSqAXs=5VLLEV-XVw5YJo=-9QFn9KA8oG_A0CfNykcVwnCQ@mail.gmail.com>
Message-ID: <20140707073244.GC30458@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Jul 07, 2014 at 11:51:38AM +0530, Naveen Krishna Ch wrote:
> On 2 July 2014 22:26, Mark Brown <broonie@kernel.org> wrote:
> > On Fri, Jun 13, 2014 at 09:29:50AM +0530, Naveen Krishna Chatradhi wrote:

> >> Hence, spi-s3c64xx.c is broken since "Jun 21 11:26:12 2013" and
> >> considering the time with no compliants about the breakage.

> > I'm not clear what the breakage is?  Some boards are broken but what's
> > the driver issue?

> ToT was broken for few boards
> exynos4412-trats2.dts, exynos4210-smdkv310.dts and exynos5250-smdk5250.dts

> With some DTS changes SPI works well, spi-s3c64xx.c driver had no issues.

No, you're not answering my question - to repeat, what is the breakage?

> > Also I'd need to check but are you sure that GPIO 0 is not valid?

> gpio_is_valid() returns true for
> "number >= 0 && number < ARCH_NR_GPIOS"

Right, so this means that any board that is using the internal chip
select with zero as default in their platform data is broken by this
change.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20140707/462d6fc2/attachment.sig>
