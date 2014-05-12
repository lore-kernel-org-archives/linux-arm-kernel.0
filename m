From: shawn.guo@freescale.com (Shawn Guo)
Date: Mon, 12 May 2014 21:54:39 +0800
Subject: i.MX6 USB OTG support is broken on linux-next
In-Reply-To: <71b1887d2f014021b084df703b15dc6a@BL2PR03MB226.namprd03.prod.outlook.com>
References: <20140509130046.GP2794@dragon>
 <20140510111003.GA1593@shlinux1.ap.freescale.net>
 <20140510131815.GT2794@dragon>
 <4285b0d55d2545b99c4ba6b703e65a12@BL2PR03MB226.namprd03.prod.outlook.com>
 <20140511014027.GV2794@dragon>
 <71b1887d2f014021b084df703b15dc6a@BL2PR03MB226.namprd03.prod.outlook.com>
Message-ID: <20140512135437.GA8330@dragon>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, May 12, 2014 at 09:22:33AM +0800, Chen Peter-B29397 wrote:
>  
> > >
> > > So when the board is OTG & EH (CONFIG_USB_OTG is set), it should have
> > > TPL according to spec. In fact, even the CONFIG_USB_OTG_WHITELIST is
> > > not set, the non-TPL devices have not worked well, eg, it will not be
> > > enumerated again after it has disconnected from host 10 seconds later
> > > due to vbus has turned off by host.
> > 
> > So all in all, it sounds to me that in my case, USB_OTG_FSM shouldn't be
> > set, neither in defconfig nor manually in menuconfig, right?
> > 
> > What about USB_OTG?  Can I set it in defconfig or manually in menuconfig?
> > 
> 
> In your case, you should not set CONFIG_USB_OTG no matter at defconfig
> and at menuconfig.

Hmm, at least in my testing (USB mouse/keyboard connected to OTG port),
it works as before even I enable CONFIG_USB_OTG, as long as I do *not*
enable CONFIG_USB_OTG_FSM.

Since it works for my case, I'm wondering why you think I shouldn't
enable CONFIG_USB_OTG at all.

Shawn
