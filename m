From: plagnioj@jcrosoft.com (Jean-Christophe PLAGNIOL-VILLARD)
Date: Fri, 27 Apr 2012 09:11:04 +0200
Subject: [PATCH v3 2/4] pinctrl: pinctrl-imx: add imx pinctrl core driver
In-Reply-To: <20120427072503.GP2234@S2101-09.ap.freescale.net>
References: <1335451227-27709-1-git-send-email-b29396@freescale.com>
 <1335451227-27709-2-git-send-email-b29396@freescale.com>
 <20120426144446.GN9142@game.jcrosoft.org>
 <20120426151536.GO9142@game.jcrosoft.org>
 <20120427054842.GJ2234@S2101-09.ap.freescale.net>
 <20120427062816.GQ9142@game.jcrosoft.org>
 <20120427072503.GP2234@S2101-09.ap.freescale.net>
Message-ID: <20120427071104.GS9142@game.jcrosoft.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 15:25 Fri 27 Apr     , Shawn Guo wrote:
> On Fri, Apr 27, 2012 at 08:28:16AM +0200, Jean-Christophe PLAGNIOL-VILLARD wrote:
> > On 13:48 Fri 27 Apr     , Shawn Guo wrote:
> > > On Thu, Apr 26, 2012 at 05:15:36PM +0200, Jean-Christophe PLAGNIOL-VILLARD wrote:
> > > > We have on Imx mxc at91 and other SoC controler hich you configure per pin
> > > > 
> > > > which means one pin have multiple function and the same function is on
> > > > multiple pins
> > > > 
> > > > so the groups are just a list of possible pins
> > > > 
> > > > Instead of re-inventing bindings we do need to come with a common binding whre
> > > > it's possible
> > > > 
> > > > So instead I proppose (send in the v2) to use common way to describe the group
> > > > 
> > > Let's see how many nodes we will have in device tree.  For imx6q
> > > example, there are 332 pins and each pin has up to 8 function selects.
> > > We will end up with having 332 x 8 = 2656 sub nodes under node
> > > "functions".  Device tree simply cannot afford such a bloating.
> > device tree can offord it
> > 
> No.  Device tree maintainers has told that.  Looking into the clock DT
> binding discussion, you will find that Grant does not like to have
> even 100~200 nodes to represent an entire clock tree in the DT.
> 
> With your proposal (actually this has been proposed long time before),
> to represent the pins for a 24bit display, it easily consumes 28 nodes
> on mach-mxs, while my binding only needs one node.  So in short, the
> proposal has been discussed and it's not a sensible one.
except duplicate bindings instead having common one make no sense either

so imx, at91 and ST (STB SoC and other does have the same type of pin IP

to not come with a common bindig means we are doint the same crap as before

with switch to DT

Best Regards,
J.
