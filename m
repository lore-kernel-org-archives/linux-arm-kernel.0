From: broonie@kernel.org (Mark Brown)
Date: Wed, 28 Jan 2015 19:38:20 +0000
Subject: [PATCH v2 02/15] spi/xilinx: Leave the IRQ always enabled.
In-Reply-To: <1422447834-23116-3-git-send-email-ricardo.ribalda@gmail.com>
References: <1422447834-23116-1-git-send-email-ricardo.ribalda@gmail.com>
 <1422447834-23116-3-git-send-email-ricardo.ribalda@gmail.com>
Message-ID: <20150128193820.GJ21293@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jan 28, 2015 at 01:23:41PM +0100, Ricardo Ribalda Delgado wrote:
> Instead of enabling the IRQ and disabling it for every transaction.
> 
> Specially the small transactions (1,2 words) benefit from removing 3 bus
> accesses.

For this particular change I don't think it matters but in general
moving things that do need to be enabled and disabled to
{un,}prepare_transfer_hardware() will avoid quite a bit of overhead
under load.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 473 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20150128/52ddb957/attachment.sig>
