From: broonie@kernel.org (Mark Brown)
Date: Tue, 17 Dec 2013 13:43:19 +0000
Subject: [PATCH 1/5] ARM: sunxi: Add driver for SD/MMC hosts found on
 Allwinner sunxi SoCs
In-Reply-To: <1387058295-20641-2-git-send-email-hdegoede@redhat.com>
References: <1387058295-20641-1-git-send-email-hdegoede@redhat.com>
 <1387058295-20641-2-git-send-email-hdegoede@redhat.com>
Message-ID: <20131217134319.GC3185@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, Dec 14, 2013 at 10:58:11PM +0100, Hans de Goede wrote:

> +config MMC_SUNXI
> +	tristate "Allwinner sunxi SD/MMC Host Controller support"
> +	depends on ARCH_SUNXI

This should be ARCH_SUNXI || COMPILE_TEST to increase build coverage
especially for people doing subsystem or kernel global work.

> +	default y

As others pointed out this shouldn't be here, consider multiplatform
kernels.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20131217/5b223810/attachment.sig>
