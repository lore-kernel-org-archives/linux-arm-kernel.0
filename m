From: broonie@kernel.org (Mark Brown)
Date: Sat, 21 Jun 2014 11:12:04 +0100
Subject: [Patch v2 2/3] spi: qup: Fix order of spi_register_master
In-Reply-To: <1402601652-24641-3-git-send-email-agross@codeaurora.org>
References: <1402601652-24641-1-git-send-email-agross@codeaurora.org>
 <1402601652-24641-3-git-send-email-agross@codeaurora.org>
Message-ID: <20140621101204.GD5099@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Jun 12, 2014 at 02:34:11PM -0500, Andy Gross wrote:
> This patch moves the devm_spi_register_master below the initialization of the
> runtime_pm.  If done in the wrong order, the spi_register_master fails if any
> probed slave devices issue SPI transactions.

Applied, thanks.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 819 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20140621/6f7dbc81/attachment.sig>
