From: broonie@kernel.org (Mark Brown)
Date: Tue, 31 Oct 2017 20:01:43 +0000
Subject: [PATCH v3 2/4] spi: imx: Fix failure path leak on GPIO request
 error
In-Reply-To: <20171031194907.29108-3-tpiepho@impinj.com>
References: <20171031194907.29108-1-tpiepho@impinj.com>
 <20171031194907.29108-3-tpiepho@impinj.com>
Message-ID: <20171031200143.iwhoennvpwvqspnf@sirena.co.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Oct 31, 2017 at 12:49:05PM -0700, Trent Piepho wrote:
> If the code that requests any chip select GPIOs fails, the cleanup of
> spi_bitbang_start() by calling spi_bitbang_stop() is not done.  Add this
> to the failure path.

Please don't resubmit patches that have already been applied, you should
submit patches against current code in the tree you're expecting things
to be applied to.  If any updates are needed to a patch that's already
been applied you should submit incremental patches which make those
updates.  This avoids having to change published git commits which could
cause problems for people working against git.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 488 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20171031/533efddf/attachment.sig>
