From: broonie@kernel.org (Mark Brown)
Date: Tue, 23 Apr 2013 16:56:30 +0100
Subject: [PATCH] ASoC: don't call of_dma_request_slave_channel directly
In-Reply-To: <1366732475-479886-3-git-send-email-arnd@arndb.de>
References: <1366732475-479886-1-git-send-email-arnd@arndb.de>
 <1366732475-479886-3-git-send-email-arnd@arndb.de>
Message-ID: <20130423155629.GS5019@opensource.wolfsonmicro.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Apr 23, 2013 at 05:54:33PM +0200, Arnd Bergmann wrote:
> The exported interface for device drivers is dma_request_slave_channel,
> not of_dma_request_slave_channel. The former does not depend on device
> tree but also works with ACPI and other interfaces providing an
> abstraction for DMA channels.

> This fixes link errors when building ALSA as a loadable module.

This has already been changed separately, I'm surprised this applies
against current code.  Though one does have to wonder why it's in the
header file if it's not a supported API...
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20130423/81bf0488/attachment.sig>
