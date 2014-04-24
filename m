From: broonie@kernel.org (Mark Brown)
Date: Thu, 24 Apr 2014 17:25:58 +0100
Subject: [PATCH] i2c: exynos5: Initialise Samsung High Speed I2C
 controller early
In-Reply-To: <1398350916-885-1-git-send-email-ch.naveen@samsung.com>
References: <1398350916-885-1-git-send-email-ch.naveen@samsung.com>
Message-ID: <20140424162558.GB12304@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Apr 24, 2014 at 08:18:36PM +0530, Naveen Krishna Chatradhi wrote:
> This patch moves initialization code to subsys_initcall() to ensure
> that the i2c bus is available early so the regulators can be quickly
> probed and available for other devices on their probe() call.

> Such solution has been proposed by Mark Brown to fix the problem of
> the regulators not beeing available on the peripheral device probe():
> http://lists.infradead.org/pipermail/linux-arm-kernel/2010-March/011971.html

What specifically is this needed for?  We *should* be able to use
deferred probe for most things, but I know that not all subsystems are
able to yet.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20140424/ef89e6fa/attachment-0001.sig>
