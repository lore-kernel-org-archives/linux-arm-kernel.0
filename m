From: catalin.marinas@arm.com (Catalin Marinas)
Date: Fri, 15 Aug 2014 16:28:32 +0100
Subject: [PATCH 4/6] arm64: Add DTS support for FSL's LS2085A SoC
In-Reply-To: <29cf47df79b145ea928da6944ff3de57@BN1PR03MB220.namprd03.prod.outlook.com>
References: <1408096156-29772-1-git-send-email-bhupesh.sharma@freescale.com>
 <1408096156-29772-5-git-send-email-bhupesh.sharma@freescale.com>
 <20140815101249.GA19939@localhost>
 <af793f09683b48b5a0db42a482210c4a@BY2PR0301MB0743.namprd03.prod.outlook.com>
 <20140815131026.GB18863@arm.com>
 <29cf47df79b145ea928da6944ff3de57@BN1PR03MB220.namprd03.prod.outlook.com>
Message-ID: <20140815152832.GE18863@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Aug 15, 2014 at 03:31:48PM +0100, bhupesh.sharma at freescale.com wrote:
> > On Fri, Aug 15, 2014 at 01:53:13PM +0100, Stuart Yoder wrote:
> > > > On Fri, Aug 15, 2014 at 10:49:13AM +0100, Bhupesh Sharma wrote:
> > > > > +	cpus {
> > > > > +		#address-cells = <2>;
> > > > > +		#size-cells = <0>;
> > > > > +
> > > > > +		/* We have 4 clusters having 2 Cortex-A57 cores each */
> > > > > +		cpu at 0 {
> > > > > +			device_type = "cpu";
> > > > > +			compatible = "arm,cortex-a57";
> > > > > +			reg = <0x0 0x0>;
> > > > > +			enable-method = "spin-table";
> > > > > +			cpu-release-addr = <0x0 0x8000fff8>;
> > > > > +		};
> > > >
> > > > Why not PSCI?
> > >
> > > It simply is where we are today-- we don't have functioning PSCI yet
> > > but plan to get there over time.
> > 
> > Thanks for clarification.
> > 
> > > All the existing device trees
> > > in arch/arm64 use "spin-table", so it seems that other platforms are
> > > in the same situation:
> > >    apm-storm.dtsi
> > 
> > Not possible because there is no EL3 mode on the CPU implementation.
> > 
> > >    foundation-v8.dts
> > >    rtsm_ve-aemv8a.dts
> > 
> > These work with the latest boot wrapper (which overrides the DT nodes and
> > passes the PSCI information).
> 
> Right. We are working on our PSCI handler implementation in EL3 and the spin-table
> approach it something we are currently supporting on the simulator model using
> u-boot bootloader setting up the spin-tables.
> 
> Our patches for implementing spin-table approach in armv8 u-boot are already under
> review and corresponding rework [1].

It would be better if you helped with this effort to bring PSCI to
U-Boot (ARMv7 currently but easy to port to AArch64):

https://git.kernel.org/cgit/linux/kernel/git/maz/u-boot.git/log/?h=wip/psci-v4
https://git.kernel.org/cgit/linux/kernel/git/maz/u-boot.git/log/?h=wip/psci-v4-a20

-- 
Catalin
