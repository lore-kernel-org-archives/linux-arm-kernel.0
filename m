From: broonie@opensource.wolfsonmicro.com (Mark Brown)
Date: Wed, 22 Aug 2012 20:27:23 +0100
Subject: [PATCH v2 1/2] ARM: clk-imx35: Fix SSI clock registration
In-Reply-To: <1345466362-2576-1-git-send-email-fabio.estevam@freescale.com>
References: <1345466362-2576-1-git-send-email-fabio.estevam@freescale.com>
Message-ID: <20120822192723.GS7995@opensource.wolfsonmicro.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Aug 20, 2012 at 09:39:22AM -0300, Fabio Estevam wrote:
> SSI block has two types of clock:
> 
> ipg: bus clock, the clock needed for accessing registers.
> per: peripheral clock, the clock needed for generating the bit rate.
> 
> Currently SSI driver only supports slave mode and only need to handle
> the ipg clock, because the peripheral clock comes from the master codec.
> 
> Only register the ipg clock and do not register the peripheral clock for ssi.

Tested-by: Mark Brown <broonie@opensource.wolfsonmicro.com>

in that it stops boot hanging on the board, though it still doesn't make
AC'97 come out of reset happily.  That's probably some separate issue
(pinmux perhaps?) though.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20120822/ebdabfcf/attachment.sig>
