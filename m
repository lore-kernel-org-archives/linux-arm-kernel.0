From: stefano.stabellini@eu.citrix.com (Stefano Stabellini)
Date: Thu, 20 Sep 2012 12:56:30 +0100
Subject: [PATCH] arm: introduce a DTS for Xen unprivileged virtual machines
In-Reply-To: <1348136222.26501.19.camel@zakaz.uk.xensource.com>
References: <1348076658-4511-1-git-send-email-stefano.stabellini@eu.citrix.com>
 <1348136222.26501.19.camel@zakaz.uk.xensource.com>
Message-ID: <alpine.DEB.2.02.1209201240110.29232@kaball.uk.xensource.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, 20 Sep 2012, Ian Campbell wrote:
> On Wed, 2012-09-19 at 18:44 +0100, Stefano Stabellini wrote:
> > +/include/ "skeleton.dtsi"
> > +
> > +/ {
> > +	model = "XENVM-4.2";
> 
> Why the shouty caps?

It looks like that model names are always capital, at least in the
vexpress family.


> Did you mean 4.3 here and throughout?

Nope, after all this is the fruit of the work we did on Xen 4.2, mostly
already upstream. By the time of the 4.3 release we might have a
different dts.


> > +	compatible = "xen,xenvm-4.2", "arm,vexpress";
> 
> Is this second compatible thing actually true? We don't actually emulate
> much (anything?) of what would be on a real vexpress motherboard.
> 
> "arm,vexpress" is used only in v2m.c and I don't think we want the
> majority of that -- we don't provide any of the peripherals which it
> registers.
> 
> I think the only things we might want out of that lot are the arch timer
> and perhaps the uart0 (as a debug port).
> 
> I suspect we should have our own xen machine .c.
> 
> [...]

It is true that we are "arm,vexpress" compatible at the moment.
Also we need to be unless we want to introduce our own arch/arm/mach-xen
that I think is overkill.

Versatile Express is flexible enough to be a good base for our own
virtual machine platform, especially if the maintainers keep an eye on
getting everything through DT and not expecting devices just to be there
;-)


> > +	gic: interrupt-controller at 2c001000 {
> > +		compatible = "arm,cortex-a9-gic";
> 
> Don't we mean "arm,cortex-a15-gic" here? That's what we actually
> provide. I'm not sure how the a9 and a15 differ.

The GIC that comes with vexpress is a9 compatible.
