From: broonie@kernel.org (Mark Brown)
Date: Fri, 7 Nov 2014 10:13:10 +0000
Subject: [PATCH] spi: s3c64xx: add support for exynos7 SPI controller
In-Reply-To: <CAAgF-BfGwcNzMx0meFVkJqNMTbQ4_PP1PZ3i6edOm6U3bc26_Q@mail.gmail.com>
References: <1415267509-16653-1-git-send-email-padma.v@samsung.com>
 <20141106102636.GT8509@sirena.org.uk>
 <CAAgF-BfGwcNzMx0meFVkJqNMTbQ4_PP1PZ3i6edOm6U3bc26_Q@mail.gmail.com>
Message-ID: <20141107101310.GA8509@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Nov 07, 2014 at 02:01:57PM +0530, Padma Venkat wrote:

> CS can also be controlled automatically by setting AUTO_N_MANUAL to 1
> in CS_CFG. When it is auto CS automatically toggles between packet to
> packet. NCS_TIME_COUNT in CS_CFG controls the inactive period. The
> driver by default uses manual mode. But on exynos7 the manual mode is
> removed.

OK, but what's a packet here?

> I tested the driver with wm5110 codec.

Did you try firmware downloads or something else that generates multiple
transfers in a message?  Normal register writes will use a single
transfer so I'd expect them to just work.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 473 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20141107/83c9de90/attachment.sig>
