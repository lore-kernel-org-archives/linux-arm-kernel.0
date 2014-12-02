From: arnd@arndb.de (Arnd Bergmann)
Date: Tue, 02 Dec 2014 10:13:30 +0100
Subject: [PATCH] ARM: zynq: DT: Add USB to device tree
In-Reply-To: <71b9e172438946a5ba74efb430d1418c@BN1AFFO11FD060.protection.gbl>
References: <1417459352-23401-1-git-send-email-soren.brinkmann@xilinx.com>
 <7088901.UGmPabvHQ0@wuerfel>
 <71b9e172438946a5ba74efb430d1418c@BN1AFFO11FD060.protection.gbl>
Message-ID: <2598972.HWjIWPLUn8@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Monday 01 December 2014 13:51:26 S?ren Brinkmann wrote:
> Hi Arnd,
> 
> On Mon, 2014-12-01 at 10:26PM +0100, Arnd Bergmann wrote:
> > On Monday 01 December 2014 10:42:32 Soren Brinkmann wrote:
> > > +       usb_phy0: usb-phy at 0 {
> > > +               compatible = "usb-nop-xceiv";
> > > +               #phy-cells = <0>;
> > > +       };
> > >  };
> > 
> > As discussed in an unrelated thread today, please drop the "@0" in the
> > node name, since the device has no 'reg' property.
> 
> What is the best practice for naming such nodes then? On these boards
> it's not the case, but Zynq has two USB cores. So, there may be DTs that
> will have two phys in there. Would we just do 'usb-phy-0'?
> 
> 

Grant recommended naming them "phy0" and "phy1" in this case.
The recommended node name for a phy is "phy", not "usb-phy" (I didn't
notice that earlier, but it makes sense to change both), and
I would not use a dash for the number there.

	Arnd
