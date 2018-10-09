From: gregkh@linuxfoundation.org (Greg Kroah-Hartman)
Date: Tue, 9 Oct 2018 16:57:34 +0200
Subject: [PATCH 01/14] phy: phy-pxa-usb: add a new driver
In-Reply-To: <f54219e7b164a8eb259e956f312a090b67fd8fd8.camel@v3.sk>
References: <20180822204307.13251-1-lkundrak@v3.sk>
 <20180822204307.13251-2-lkundrak@v3.sk>
 <f36abb62-e8a4-e69f-4732-95a0db466034@ti.com>
 <1981ce54ce960d21976ce71b08a8779bfeb13be4.camel@v3.sk>
 <20181008132148.GC20703@kroah.com>
 <f54219e7b164a8eb259e956f312a090b67fd8fd8.camel@v3.sk>
Message-ID: <20181009145734.GA22668@kroah.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Oct 09, 2018 at 04:51:03PM +0200, Lubomir Rintel wrote:
> On Mon, 2018-10-08 at 15:21 +0200, Greg Kroah-Hartman wrote:
> > On Sun, Oct 07, 2018 at 08:47:28PM +0200, Lubomir Rintel wrote:
> > > On Tue, 2018-09-25 at 10:53 +0530, Kishon Vijay Abraham I wrote:
> > > > On Thursday 23 August 2018 02:12 AM, Lubomir Rintel wrote:
> > > > > Turned from arch/arm/mach-mmp/devices.c into a proper PHY driver,
> > > > > so
> > > > > that in can be instantiated from a DT.
> > > > > 
> > > > > Signed-off-by: Lubomir Rintel <lkundrak@v3.sk>
> > > > 
> > > > Acked-by: Kishon Vijay Abraham I <kishon@ti.com>
> > > > 
> > > > If this has to be merged via linux-phy tree, please let me know.
> > > 
> > > Yes, either linux-phy or the usb tree.
> > > 
> > > The EHCI patches have already been pulled into the usb tree, presumably
> > > because they got an Ack from Alan Stern. That includes "USB: EHCI:
> > > ehci-mv: use phy-pxa-usb" that depends on this. Perhaps the  rest of
> > > the patches can go via the same tree?
> > > 
> > > I haven't submitted a patchset that would have dependencies spanning
> > > across different subsystems before. I don't know what's usually done in
> > > such cases. Advice welcome.
> > > 
> > > Greg?
> > 
> > You can either send them through the same tree, or wait a release cycle
> > and get the rest in through a different one.  As I usually take the phy
> > tree into the USB tree for issues like this, I can take them all if you
> > get the phy maintainer to ack them.
> 
> I believe that would be Kishton, who acked this one (see above). Please
> add it ("PATCH 01/14] phy: phy-pxa-usb: add a new driver") to the usb
> tree than.
> 
> The rest is DT bindings and MMP2 platform changes (DT, board files and
> removal of dead code) which are not strictly dependent on this and
> don't need to go through phy or usb trees. I still need to get someone
> to review them.

When you get that done, please resend.

thanks,

greg k-h
