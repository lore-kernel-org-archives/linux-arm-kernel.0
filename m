From: stefano.stabellini@eu.citrix.com (Stefano Stabellini)
Date: Fri, 21 Sep 2012 12:17:15 +0100
Subject: [PATCH] arm: introduce a DTS for Xen unprivileged virtual machines
In-Reply-To: <20120920212948.GF27312@konrad-lan.dumpdata.com>
References: <1348076658-4511-1-git-send-email-stefano.stabellini@eu.citrix.com>
 <1348135563.11116.94.camel@hornet> <20120920111815.GC2117@linaro.org>
 <20120920212948.GF27312@konrad-lan.dumpdata.com>
Message-ID: <alpine.DEB.2.02.1209211214520.29232@kaball.uk.xensource.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, 20 Sep 2012, Konrad Rzeszutek Wilk wrote:
> On Thu, Sep 20, 2012 at 12:18:15PM +0100, Dave Martin wrote:
> > On Thu, Sep 20, 2012 at 11:06:03AM +0100, Pawel Moll wrote:
> > > Morning,
> > > 
> > > On Wed, 2012-09-19 at 18:44 +0100, Stefano Stabellini wrote:
> > > > +/dts-v1/;
> > > > +
> > > > +/include/ "skeleton.dtsi"
> > > 
> > > Any particular reason to include skeleton? And I think it would be
> > > better to use #address-cells = <2> and #size-cells = <2>, to be ready
> > > for LPAE addresses...
> > > 
> > > > +/ {
> > > > +	model = "XENVM-4.2";
> > > > +	compatible = "xen,xenvm-4.2", "arm,vexpress";
> > > > +	interrupt-parent = <&gic>;
> > > > +
> > > > +	chosen {
> > > > +		bootargs = "earlyprintk console=hvc0 root=/dev/xvda init=/sbin/init";
> 
> earlyprintk=xen ?
> 

earlyprintk is not "selectable" on ARM (that would be a nice addition
though). It just goes to the configured uart, that is the only piece of
hardware that is being emulated by Xen at the moment.

In any case I have removed anything debug related, including
earlyprintk, from the default bootargs.
