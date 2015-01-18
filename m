From: sylvain.rochet@finsecur.com (Sylvain Rochet)
Date: Sun, 18 Jan 2015 20:42:12 +0100
Subject: [PATCHv3 0/5] USB: host: Atmel OHCI and EHCI drivers improvements
In-Reply-To: <Pine.LNX.4.44L0.1501181220040.1499-100000@netrider.rowland.org>
References: <1421529942-18437-1-git-send-email-sylvain.rochet@finsecur.com>
 <Pine.LNX.4.44L0.1501181220040.1499-100000@netrider.rowland.org>
Message-ID: <20150118194212.GA13072@gradator.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello Alan,

On Sun, Jan 18, 2015 at 12:20:49PM -0500, Alan Stern wrote:
> On Sat, 17 Jan 2015, Sylvain Rochet wrote:
> 
> > Sylvain Rochet (5):
> >   USB: host: ehci_atmel: Add suspend/resume support
> >   USB: host: ohci_at91: Stop/start USB PLL for all sleep modes
> >   USB: host: ehci_atmel: Move global variables to private struct
> >   USB: host: ohci_at91: Move global variables to private struct
> >   USB: host: ohci_at91: usb_hcd_at91_probe(), remove useless stack
> >     initialisation
> > 
> >  drivers/usb/host/ehci-atmel.c | 102 +++++++++++++++++++++++++++++++----------
> >  drivers/usb/host/ohci-at91.c  | 104 +++++++++++++++++++++++++-----------------
> >  2 files changed, 138 insertions(+), 68 deletions(-)
> 
> These patches look pretty good to me.  Have you run them through 
> checkpatch.pl?

Just did, fixed some lines over 80 characters + Sergei suggestion about 
using struct dev_pm_ops instead of struct platform_driver.{resume,suspend}.

Sylvain
