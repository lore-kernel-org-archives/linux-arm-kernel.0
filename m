From: shawn.guo@freescale.com (Shawn Guo)
Date: Tue, 13 May 2014 10:40:33 +0800
Subject: i.MX6 USB OTG support is broken on linux-next
In-Reply-To: <20140513011002.GA1781@shlinux1.ap.freescale.net>
References: <20140509130046.GP2794@dragon>
 <20140510111003.GA1593@shlinux1.ap.freescale.net>
 <20140510131815.GT2794@dragon>
 <4285b0d55d2545b99c4ba6b703e65a12@BL2PR03MB226.namprd03.prod.outlook.com>
 <20140511014027.GV2794@dragon>
 <71b1887d2f014021b084df703b15dc6a@BL2PR03MB226.namprd03.prod.outlook.com>
 <20140512135437.GA8330@dragon>
 <04dad7ad8f0247b9bef4fea1db8a8bc8@BL2PR03MB226.namprd03.prod.outlook.com>
 <20140513014247.GH8330@dragon>
 <20140513011002.GA1781@shlinux1.ap.freescale.net>
Message-ID: <20140513024032.GK8330@dragon>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, May 13, 2014 at 09:10:36AM +0800, Li Jun wrote:
> Firstly, w/o USB_OTG and USB_OTG_FSM, your OTG port will work well as before
> (i.e. it can be host or can be gadget as you want, so it's enough for you if
> connect normal usb device or PC host), I assume you are not wanting more here,
> this dual role functionality actually is not the part of "CONFIG_USB_OTG";

Okay, I think this is why I was confused.  Thanks for the clarification.

The problem is how people like me who does not know Linux USB too much
get that, considering what the help text of CONFIG_USB_OTG tells people
is just like below.

config USB_OTG
        bool "OTG support"
	...
        help
          The most notable feature of USB OTG is support for a
          "Dual-Role" device, which can act as either a device
          or a host. The initial role is decided by the type of
          plug inserted and can be changed later when two dual
          role devices talk to each other.

          Select this only if your board has Mini-AB/Micro-AB
          connector.

So the text tells CONFIG_USB_OTG is there for Dual-Role device support,
while you're saying the support is not the part of CONFIG_USB_OTG.  As a
person who never looked at usb code, I'm completely confused here.

> 
> What USB_OTG + USB_OTG_FSM does is *specific* for HNP and SRP, it's based on
> OTG spec and will *not* work well with a normal usb device, that's the reason
> behind in disable USB_OTG, which is not needed, and even impact your expecting
> function in your case...

Again, the help text of CONFIG_USB_OTG does *not* tell that.

Shawn
