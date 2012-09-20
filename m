From: stefano.stabellini@eu.citrix.com (Stefano Stabellini)
Date: Thu, 20 Sep 2012 13:39:58 +0100
Subject: [PATCH] arm: introduce a DTS for Xen unprivileged virtual machines
In-Reply-To: <1348143533.26501.28.camel@zakaz.uk.xensource.com>
References: <1348076658-4511-1-git-send-email-stefano.stabellini@eu.citrix.com>
 <1348136222.26501.19.camel@zakaz.uk.xensource.com>
 <alpine.DEB.2.02.1209201240110.29232@kaball.uk.xensource.com>
 <1348143533.26501.28.camel@zakaz.uk.xensource.com>
Message-ID: <alpine.DEB.2.02.1209201333460.29232@kaball.uk.xensource.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, 20 Sep 2012, Ian Campbell wrote:
> > Versatile Express is flexible enough to be a good base for our own
> > virtual machine platform, especially if the maintainers keep an eye on
> > getting everything through DT and not expecting devices just to be there
> > ;-)
> 
> Perhaps what we want is a stricter subset of the stuff in mach-vexpress
> then. But if so then this should be expressed both in the DT and in the
> code, not just papered over by declaring things compatible when they are
> not.

But it is already expressed in the DT, by removing all the device nodes
we don't emulated. And it is already expressed in the code, by fully
discovering peripherals via DT, therefore not trying to initialize
non-present devices.


> > > > +	gic: interrupt-controller at 2c001000 {
> > > > +		compatible = "arm,cortex-a9-gic";
> > > 
> > > Don't we mean "arm,cortex-a15-gic" here? That's what we actually
> > > provide. I'm not sure how the a9 and a15 differ.
> > 
> > The GIC that comes with vexpress is a9 compatible.
> 
> The GIC which Xen emulates is the one which matters here though, and
> that is an a15.

The a15 gic is still a9 compatible. OK to be precise I am going to add
"arm,cortex-a15-gic", but I cannot really remove "arm,cortex-a9-gic".
