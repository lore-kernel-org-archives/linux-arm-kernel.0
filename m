From: computersforpeace@gmail.com (Brian Norris)
Date: Wed, 12 Aug 2015 19:00:04 -0700
Subject: [PATCH v2 1/2] mtd: spi-nor: add driver for NXP SPI Flash
 Interface (SPIFI)
In-Reply-To: <CAGhQ9VzU+J1ZT45e-yZ+BAmyZvLUm1cyXE2T__O_4gGjtHrX-w@mail.gmail.com>
References: <1433106362-6032-1-git-send-email-manabian@gmail.com>
 <1433106362-6032-2-git-send-email-manabian@gmail.com>
 <5570692E.2050603@vanguardiasur.com.ar>
 <CAGhQ9VzU+J1ZT45e-yZ+BAmyZvLUm1cyXE2T__O_4gGjtHrX-w@mail.gmail.com>
Message-ID: <20150813020004.GA108786@google.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Jun 04, 2015 at 05:58:07PM +0200, Joachim Eastwood wrote:
> On 4 June 2015 at 17:05, Ezequiel Garcia <ezequiel@vanguardiasur.com.ar> wrote:
> > I think the "auto-detect" quirk is really needed, or you are will
> > otherwise fail to probe with the generic "jedec,spi-nor" compatible
> > string.
[...]
> Note that this code was copied from fsl-quadspi so I assume it has the
> same problem.

Yes, fsl-quadspi gets this a bit wrong, I think. But spi_nor_scan()
didn't have a notion of "NULL means autodetect" when it was first
written. The framework is still evolving a bit.

I have a simple patch for fsl-quadspi to fix this up now, but I don't
have the HW. Maybe I'll send with a RFT.

Brian
