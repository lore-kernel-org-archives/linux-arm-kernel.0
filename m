From: stern@rowland.harvard.edu (Alan Stern)
Date: Tue, 4 Sep 2012 10:34:44 -0400 (EDT)
Subject: [PATCH] USB: ohci-at91: fix PIO handling in relation with number
 of ports
In-Reply-To: <5045BB6A.8060309@atmel.com>
Message-ID: <Pine.LNX.4.44L0.1209041032520.1605-100000@iolanthe.rowland.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, 4 Sep 2012, Nicolas Ferre wrote:

> On 08/29/2012 11:49 AM, Nicolas Ferre :
> > If the number of ports present on the SoC/board is not the maximum
> > and that the platform data is not filled with all data, there is
> > an easy way to mess the PIO setup for this interface.
> > This quick fix addresses mis-configuration in USB host platform data
> > that is common in at91 boards since commit 0ee6d1e (USB: ohci-at91:
> > change maximum number of ports) that did not modified the associatd
> > board files.
> > 
> > Reported-by: Klaus Falkner <klaus.falkner@solectrix.de>
> > Signed-off-by: Nicolas Ferre <nicolas.ferre@atmel.com>
> > Cc: Alan Stern <stern@rowland.harvard.edu>
> > Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> > Cc: linux-usb at vger.kernel.org
> > Cc: Stable <stable@vger.kernel.org> [3.4+]
> 
> Alan, Greg, gentle ping...
> 
> I really would like to seen it landing in stable soon...
> 
> Thanks, best regards,

Sorry for the delay.  I feel a little uncomfortable judging board-level 
changes like this, since I know nothing about the hardware details.

Still, for what it's worth, this patch is okay as far as the core 
ohci-hcd driver components are concerned.  So...

Acked-by: Alan Stern <stern@rowland.harvard.edu>
