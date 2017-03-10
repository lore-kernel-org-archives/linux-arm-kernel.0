From: gregkh@linuxfoundation.org (Greg Kroah-Hartman)
Date: Fri, 10 Mar 2017 15:50:30 +0100
Subject: [PATCH v4 1/3] usb: orion-echi: Add support for the Armada 3700
In-Reply-To: <87o9x9jw1g.fsf@free-electrons.com>
References: <Pine.LNX.4.44L0.1703091318010.1560-100000@iolanthe.rowland.org>
 <87o9x9jw1g.fsf@free-electrons.com>
Message-ID: <20170310145030.GA3731@kroah.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Mar 10, 2017 at 10:55:23AM +0100, Gregory CLEMENT wrote:
> Hi Alan,
>  
>  On jeu., mars 09 2017, Alan Stern <stern@rowland.harvard.edu> wrote:
> 
> > On Thu, 9 Mar 2017, Gregory CLEMENT wrote:
> >
> >> From: Hua Jing <jinghua@marvell.com>
> >> 
> >> - Add a new compatible string for the Armada 3700 SoCs
> >> 
> >> - add sbuscfg support for orion usb controller driver. For the SoCs
> >>   without hlock, need to program BAWR/BARD/AHBBRST fields in the sbuscfg
> >>   register to guarantee the AHB master's burst would not overrun or
> >>   underrun the FIFO.
> >> 
> >> - the sbuscfg register has to be set after the usb controller reset,
> >>   otherwise the value would be overridden to 0. In order to do this, the
> >>   reset callback is registered.
> >> 
> >> [gregory.clement at free-electrons.com: - reword commit and comments
> >> 				     - fix error path in ehci_orion_drv_reset()
> >> 				     - fix checkpatch warning]
> >> Signed-off-by: Hua Jing <jinghua@marvell.com>
> >> Signed-off-by: Gregory CLEMENT <gregory.clement@free-electrons.com>
> >> Reviewed-by: Andrew Lunn <andrew@lunn.ch>
> >
> > Acked-by: Alan Stern <stern@rowland.harvard.edu>
> 
> Thanks!
> 
> And what about the second patch "usb: host: Allow to build ehci orion
> with mvebu SoCs " ?
> 
> I don't remember what is the workflow for the usb subsystem. Will you do
> a pull request to GKH? Or maybe he collects himself the patch once you
> give your acked-by.
> 
> I will take care of the third patch and apply on the mvebu/dt64 branch
> now that you agree the extension for the driver.

I'll take all of these once they look "good enough".  Give me a week or
so to get to all of the pending patches in my queue...

thanks,

greg k-h
