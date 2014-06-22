From: broonie@kernel.org (Mark Brown)
Date: Sun, 22 Jun 2014 11:47:08 +0100
Subject: [Patch v2 1/3] spi: qup: Remove chip select function
In-Reply-To: <20140621185646.GA2601@qualcomm.com>
References: <1402601652-24641-1-git-send-email-agross@codeaurora.org>
 <1402601652-24641-2-git-send-email-agross@codeaurora.org>
 <20140621101303.GE5099@sirena.org.uk>
 <20140621185646.GA2601@qualcomm.com>
Message-ID: <20140622104708.GK24291@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, Jun 21, 2014 at 01:56:46PM -0500, Andy Gross wrote:
> On Sat, Jun 21, 2014 at 11:13:03AM +0100, Mark Brown wrote:
> > On Thu, Jun 12, 2014 at 02:34:10PM -0500, Andy Gross wrote:

> > > This patch removes the chip select function.  Chip select should instead be
> > > supported using GPIOs, defining the DT entry "cs-gpios", and letting the SPI
> > > core assert/deassert the chip select as it sees fit.

> > Why?

> The chip select control inside the controller is buggy.  It is supposed to
> automatically assert the chip select based on the activity in the controller,
> but it is buggy and doesn't work at all.  So instead we elect to use GPIOs.

OK, though it was in manual mode.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 819 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20140622/fa9ac4db/attachment.sig>
