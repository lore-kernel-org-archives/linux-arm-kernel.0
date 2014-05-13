From: shawn.guo@freescale.com (Shawn Guo)
Date: Tue, 13 May 2014 09:42:48 +0800
Subject: i.MX6 USB OTG support is broken on linux-next
In-Reply-To: <04dad7ad8f0247b9bef4fea1db8a8bc8@BL2PR03MB226.namprd03.prod.outlook.com>
References: <20140509130046.GP2794@dragon>
 <20140510111003.GA1593@shlinux1.ap.freescale.net>
 <20140510131815.GT2794@dragon>
 <4285b0d55d2545b99c4ba6b703e65a12@BL2PR03MB226.namprd03.prod.outlook.com>
 <20140511014027.GV2794@dragon>
 <71b1887d2f014021b084df703b15dc6a@BL2PR03MB226.namprd03.prod.outlook.com>
 <20140512135437.GA8330@dragon>
 <04dad7ad8f0247b9bef4fea1db8a8bc8@BL2PR03MB226.namprd03.prod.outlook.com>
Message-ID: <20140513014247.GH8330@dragon>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, May 13, 2014 at 08:25:18AM +0800, Chen Peter-B29397 wrote:
>  
> > > >
> > >
> > > In your case, you should not set CONFIG_USB_OTG no matter at defconfig
> > > and at menuconfig.
> > 
> > Hmm, at least in my testing (USB mouse/keyboard connected to OTG port),
> > it works as before even I enable CONFIG_USB_OTG, as long as I do *not*
> > enable CONFIG_USB_OTG_FSM.
> > 
> > Since it works for my case, I'm wondering why you think I shouldn't
> > enable CONFIG_USB_OTG at all.
> > 
> 
> If your device is not OTG device, there is no reason you need to enable
> CONFIG_USB_OTG.

Whether I should enable CONFIG_USB_OTG depends on what devices I will
use?  This is insane to me.

Look, there is an USB OTG port on my board, and it should just be the
reason that's good enough for me to build a kernel with CONFIG_USB_OTG,
shouldn't it?  I do not even know what type of devices will be plugged
into this USB OTG port when I was building the kernel.

Shawn

> Yes, it may work for some devices when enable CONFIG_USB_OTG,
> but it will confuse other host or device which is connected with you, eg,
> your device will report your have supported some otg capabilities, eg, SRP or
> HNP.
