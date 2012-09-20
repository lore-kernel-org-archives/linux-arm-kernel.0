From: konrad.wilk@oracle.com (Konrad Rzeszutek Wilk)
Date: Thu, 20 Sep 2012 17:29:48 -0400
Subject: [PATCH] arm: introduce a DTS for Xen unprivileged virtual machines
In-Reply-To: <20120920111815.GC2117@linaro.org>
References: <1348076658-4511-1-git-send-email-stefano.stabellini@eu.citrix.com>
 <1348135563.11116.94.camel@hornet>
 <20120920111815.GC2117@linaro.org>
Message-ID: <20120920212948.GF27312@konrad-lan.dumpdata.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Sep 20, 2012 at 12:18:15PM +0100, Dave Martin wrote:
> On Thu, Sep 20, 2012 at 11:06:03AM +0100, Pawel Moll wrote:
> > Morning,
> > 
> > On Wed, 2012-09-19 at 18:44 +0100, Stefano Stabellini wrote:
> > > +/dts-v1/;
> > > +
> > > +/include/ "skeleton.dtsi"
> > 
> > Any particular reason to include skeleton? And I think it would be
> > better to use #address-cells = <2> and #size-cells = <2>, to be ready
> > for LPAE addresses...
> > 
> > > +/ {
> > > +	model = "XENVM-4.2";
> > > +	compatible = "xen,xenvm-4.2", "arm,vexpress";
> > > +	interrupt-parent = <&gic>;
> > > +
> > > +	chosen {
> > > +		bootargs = "earlyprintk console=hvc0 root=/dev/xvda init=/sbin/init";

earlyprintk=xen ?
