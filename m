From: broonie@kernel.org (Mark Brown)
Date: Sun, 8 Mar 2015 18:56:27 +0000
Subject: [PATCH 05/10] ARM: s3c64xx: enable sparse IRQ support
In-Reply-To: <20150306174316.GA26692@opensource.wolfsonmicro.com>
References: <1425299763-4066822-1-git-send-email-arnd@arndb.de>
 <1425299763-4066822-6-git-send-email-arnd@arndb.de>
 <20150306174316.GA26692@opensource.wolfsonmicro.com>
Message-ID: <20150308185627.GU28806@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Mar 06, 2015 at 05:43:16PM +0000, Charles Keepax wrote:

> Cragganmore, I need to look into it a bit more but it looks like
> one of the PMICs can't allocate its IRQs:

> [    0.961455] wm831x 1-0034: WM8311 revision C
> [    0.965066] wm831x 1-0034: Failed to allocate IRQs: -17

> And the CODEC can't request its IRQ:

> [    4.252735] arizona spi0.1: WM5102 revision C
> [    4.269763] arizona spi0.1: Failed to request primary IRQ 263: -22

> Hopefully I can look into this a little more next week.

The second is a knock on from the first - the CODEC interrupt line is
connected to the PMIC so since the PMIC can't allocate its IRQ range the
CODEC can't request it.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 473 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20150308/8268abcb/attachment.sig>
