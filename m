From: broonie@kernel.org (Mark Brown)
Date: Mon, 26 May 2014 16:43:56 +0100
Subject: [PATCH v2 5/5] regulator: axp20x: resolve self dependency issue
In-Reply-To: <1401116292-24066-6-git-send-email-boris.brezillon@free-electrons.com>
References: <1401116292-24066-1-git-send-email-boris.brezillon@free-electrons.com>
 <1401116292-24066-6-git-send-email-boris.brezillon@free-electrons.com>
Message-ID: <20140526154356.GZ22111@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, May 26, 2014 at 04:58:12PM +0200, Boris BREZILLON wrote:
> Some regulators might take their power supply from other regulators defined
> by the same PMIC.
> 
> Retry regulators registration until all regulators are registered or the
> last iteration didn't manage to register any new regulator (which means
> there's an external dependency missing and we can thus return
> EPROBE_DEFER).

This is going to apply to most PMICs - we should factor this out into
the core rather than implementing it individual drivers.  It works
normally because typically the dependency is from DCDCs to LDOs and so
with common naming schemes alphabetic sorting saves us.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20140526/de651b6f/attachment.sig>
