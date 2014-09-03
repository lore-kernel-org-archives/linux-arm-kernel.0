From: mark.rutland@arm.com (Mark Rutland)
Date: Wed, 3 Sep 2014 18:53:40 +0100
Subject: [PATCH V2 4/6] arm64: Add DTS support for FSL's LS2085A SoC
In-Reply-To: <1409764991.21254.139.camel@smoke>
References: <1409219706-14843-1-git-send-email-bhupesh.sharma@freescale.com>
 <1409219706-14843-5-git-send-email-bhupesh.sharma@freescale.com>
 <1409764991.21254.139.camel@smoke>
Message-ID: <20140903175340.GN3127@leverpostej>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Geoff,

On Wed, Sep 03, 2014 at 06:23:11PM +0100, Geoff Levand wrote:
> Hi Bhupesh,
> 
> On Thu, 2014-08-28 at 15:25 +0530, Bhupesh Sharma wrote:
> > This patch adds the device tree support for FSL LS2085A SoC
> > based on ARMv8 architecture.
> > +	cpus {
> > +		#address-cells = <2>;
> > +		#size-cells = <0>;
> > +
> > +		/* We have 4 clusters having 2 Cortex-A57 cores each */
> > +		cpu at 0 {
> > +			device_type = "cpu";
> > +			compatible = "arm,cortex-a57";
> > +			reg = <0x0 0x0>;
> > +		};
> 
> arm64 needs a cpu enable-method property.  Is your boot loader adding
> that?

That's the plan. If you take a look on the U-Boot mailing list you'll
see there are patches under review which do just that, along with the
basis of a PSCI 0.2 implementation.

Note that whether or not the in-kernel dts should have an enable-method
is under discussion in a subsequent (v3) posting [1,2] of this series.

> Be aware that if you have set it up this way, users will not be able to
> use this file with kexec's --dtb=FILE to specify a 2nd stage DT file.
> kexec will use a copy of the DT from the 1st stage in this case.

Surely the latter is the default and the former is the "trust me I know
what I'm doing" case?

In general there are other things you might need to fill in anyhow (like
dynamically populated memory), so I don't see that as a big isssue
(though admittedly painful if you're testing things in that area).

Mark.

[1] http://lists.infradead.org/pipermail/linux-arm-kernel/2014-September/284076.html
[2] http://lists.infradead.org/pipermail/linux-arm-kernel/2014-September/284106.html
