From: dave.martin@linaro.org (Dave Martin)
Date: Thu, 20 Sep 2012 12:18:15 +0100
Subject: [PATCH] arm: introduce a DTS for Xen unprivileged virtual machines
In-Reply-To: <1348135563.11116.94.camel@hornet>
References: <1348076658-4511-1-git-send-email-stefano.stabellini@eu.citrix.com>
 <1348135563.11116.94.camel@hornet>
Message-ID: <20120920111815.GC2117@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Sep 20, 2012 at 11:06:03AM +0100, Pawel Moll wrote:
> Morning,
> 
> On Wed, 2012-09-19 at 18:44 +0100, Stefano Stabellini wrote:
> > +/dts-v1/;
> > +
> > +/include/ "skeleton.dtsi"
> 
> Any particular reason to include skeleton? And I think it would be
> better to use #address-cells = <2> and #size-cells = <2>, to be ready
> for LPAE addresses...
> 
> > +/ {
> > +	model = "XENVM-4.2";
> > +	compatible = "xen,xenvm-4.2", "arm,vexpress";
> > +	interrupt-parent = <&gic>;
> > +
> > +	chosen {
> > +		bootargs = "earlyprintk console=hvc0 root=/dev/xvda init=/sbin/init";
> > +	};

Are you sure this default command line is appropriate?

I don't normally like to see default command lines unless they really
add something which is crucial for the board to work.

None of those args looks vital to me.  They are configuration choices
and should be left up to the user.

Cheers
---Dave
