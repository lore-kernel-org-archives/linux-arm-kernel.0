From: broonie@kernel.org (Mark Brown)
Date: Wed, 24 Sep 2014 09:30:35 +0100
Subject: [PATCH] spi: qup: Fix incorrect block transfers
In-Reply-To: <20140923192613.GA5975@qualcomm.com>
References: <1411360048-3388-1-git-send-email-agross@codeaurora.org>
 <1411464267.18580.46.camel@iivanov-dev>
 <20140923192613.GA5975@qualcomm.com>
Message-ID: <20140924083035.GY4015@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Sep 23, 2014 at 02:26:13PM -0500, Andy Gross wrote:
> On Tue, Sep 23, 2014 at 12:24:27PM +0300, Ivan T. Ivanov wrote:
> > On Sun, 2014-09-21 at 23:27 -0500, Andy Gross wrote:

> > > This patch fixes a number of errors with the QUP block transfer mode.  Errors
> > > manifested themselves as input underruns, output overruns, and timed out
> > > transactions.

> > At what speeds are you seeing those errors?

> We've tried 25MHz and 50MHz.  Both fail in the same way.  Keep in mind this is
> definitely a timing / race issue and it probably also dependent on the latency
> of the attached device.  I cannot reproduce this at all on my IPQ8064 based
> board, but others can.

With SPI everything is entirely clocked from the master - the attached
device can't cause any of those issues unless there's an electrical
problem that *really* upsets the master.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 473 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20140924/621b7a2c/attachment.sig>
