From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Sun, 8 Jul 2012 18:48:49 +0100
Subject: [PATCH v2 1/4] usb: chipidea: pci: make platformdata static
In-Reply-To: <CANg6MZh7+eyMa97a73bNTFfd8SGNRMTx=3F1-DYT13R=VR+p1w@mail.gmail.com>
References: <1340891629-13145-1-git-send-email-mkl@pengutronix.de>
 <1340891629-13145-2-git-send-email-mkl@pengutronix.de>
 <20120628140603.GA2799@richard-laptop>
 <CANg6MZh7+eyMa97a73bNTFfd8SGNRMTx=3F1-DYT13R=VR+p1w@mail.gmail.com>
Message-ID: <20120708174849.GG31508@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, Jul 08, 2012 at 11:10:04PM +0800, Richard Zhao wrote:
> On Thu, Jun 28, 2012 at 10:06 PM, Richard Zhao <linuxzsc@gmail.com> wrote:
> > On Thu, Jun 28, 2012 at 03:53:46PM +0200, Marc Kleine-Budde wrote:
> >> Signed-off-by: Marc Kleine-Budde <mkl@pengutronix.de>
> >> ---
> >>  drivers/usb/chipidea/ci13xxx_pci.c |    6 +++---
> >>  1 file changed, 3 insertions(+), 3 deletions(-)
> >>
> >> diff --git a/drivers/usb/chipidea/ci13xxx_pci.c b/drivers/usb/chipidea/ci13xxx_pci.c
> >> index 918e149..9f5c171 100644
> >> --- a/drivers/usb/chipidea/ci13xxx_pci.c
> >> +++ b/drivers/usb/chipidea/ci13xxx_pci.c
> >> @@ -23,17 +23,17 @@
> >>  /******************************************************************************
> >>   * PCI block
> >>   *****************************************************************************/
> >> -struct ci13xxx_platform_data pci_platdata = {
> >> +static struct ci13xxx_platform_data pci_platdata = {
> > what about adding __devinitdata?
> Marc, what do you think?

Not on statically declared platform data.  That's always a mistake.
