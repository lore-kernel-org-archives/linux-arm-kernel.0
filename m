From: lorenzo.pieralisi@arm.com (Lorenzo Pieralisi)
Date: Wed, 24 Apr 2013 10:29:14 +0100
Subject: [RFC PATCH v2 03/13] ARM: mach-at91: cpus/cpu node dts updates
In-Reply-To: <20130423195259.GJ4998@game.jcrosoft.org>
References: <1366644455-16550-1-git-send-email-lorenzo.pieralisi@arm.com>
 <1366644455-16550-4-git-send-email-lorenzo.pieralisi@arm.com>
 <51768892.7060807@gmail.com>
 <20130423135304.GG22946@e102568-lin.cambridge.arm.com>
 <20130423195259.GJ4998@game.jcrosoft.org>
Message-ID: <20130424092914.GA1561@e102568-lin.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Apr 23, 2013 at 08:52:59PM +0100, Jean-Christophe PLAGNIOL-VILLARD wrote:
> On 14:53 Tue 23 Apr     , Lorenzo Pieralisi wrote:
> > On Tue, Apr 23, 2013 at 02:11:46PM +0100, Rob Herring wrote:
> > > On 04/22/2013 10:27 AM, Lorenzo Pieralisi wrote:
> > > > This patch updates the in-kernel dts files according to the latest cpus
> > > > and cpu bindings updates for ARM.
> > > > 
> > > > Signed-off-by: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
> > > > ---
> > > >  arch/arm/boot/dts/at91sam9260.dtsi | 2 +-
> > > >  arch/arm/boot/dts/at91sam9263.dtsi | 2 +-
> > > >  arch/arm/boot/dts/at91sam9g45.dtsi | 2 +-
> > > >  arch/arm/boot/dts/at91sam9n12.dtsi | 2 +-
> > > >  4 files changed, 4 insertions(+), 4 deletions(-)
> > > > 
> > > > diff --git a/arch/arm/boot/dts/at91sam9260.dtsi b/arch/arm/boot/dts/at91sam9260.dtsi
> > > > index cb7bcc5..2e9de85 100644
> > > > --- a/arch/arm/boot/dts/at91sam9260.dtsi
> > > > +++ b/arch/arm/boot/dts/at91sam9260.dtsi
> > > > @@ -33,7 +33,7 @@
> > > >  	};
> > > >  	cpus {
> > > >  		cpu at 0 {
> > > > -			compatible = "arm,arm926ejs";
> > > > +			compatible = "arm,arm926";
> > > 
> > > I don't understand why you are doing this. If this does not match the
> > > documentation, fix the documentation. We can't continue on changing dts
> > > files without reqard to breaking compatibility.
> > 
> > IMHO compatibility is already broken. There are a number of dts in the
> > kernel missing cpus and cpu nodes, others with cpu nodes missing
> > device_type = "cpu", missing cpu nodes compatible properties and the list
> > goes on and on. Those files got merged in the kernel before bindings were
> > properly defined for ARM so at that point in time the only reference was the
> > ePAPR and still, it was not followed (eg my broken patch above fails to add
> > device_type = "cpu" to the cpu node, should I change the documentation (ePAPR)
> > to make the dts above compliant ? I do not think so, I reckon we should fix
> > all dts and force them to comply with the ePAPR and the in-kernel bindings).
> > 
> > If we do not set in stone the bindings and draw a line now, this stuff will
> > go wild, it is already in a state that I do not like much.
> > 
> > The reason we are patching the compatible property above is to avoid having
> > compatible properties containing suffixes for CPUs, we do not deem that
> > necessary, see:
> > 
> > http://lists.infradead.org/pipermail/linux-arm-kernel/2013-January/145305.html
> > 
> > That's just my opinion, open to change it to find a proper solution to this
> > issue as long as we make progress.
> 
> I do not agree when you set the compatible you need to be preceise the cpu is
> a arm926ejs not a arm926

I updated the bindings with all processor variants so that we will all
be happy again (I hope). My comments still stand though and these dts need
patching, I am posting the required changes in v3.

Lorenzo
