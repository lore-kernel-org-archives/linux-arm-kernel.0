From: peter.senna@collabora.com (Peter Senna Tschudin)
Date: Mon, 8 May 2017 19:15:06 +0200
Subject: Regression: 442ec4c04d1: PCI: dwc: all: Split struct pcie_port
 into host-only and core structures
In-Reply-To: <1d5b46a7-b8ed-f58d-0064-bb19f664cd5c@ti.com>
References: <20170508150224.GA7458@collabora.com>
 <967686bf-5f1b-29aa-ee2f-b976addbe98f@ti.com>
 <1d5b46a7-b8ed-f58d-0064-bb19f664cd5c@ti.com>
Message-ID: <20170508171506.GA9791@collabora.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, May 08, 2017 at 09:20:36PM +0530, Kishon Vijay Abraham I wrote:
> Hi,
> 
> On Monday 08 May 2017 09:09 PM, Kishon Vijay Abraham I wrote:
> > Hi,
> > 
> > On Monday 08 May 2017 08:32 PM, Peter Senna Tschudin wrote:
> >> Hello Kishon,
> >>
> >> Our iMX6 hardware (imx6q-b850v3.dts) is not booting with latest
> >> linux-next and I could bisect until:
> >>
> >> commit 442ec4c04d1235f8c664a74004dae54a7a574d18
> >> Author: Kishon Vijay Abraham I <kishon@ti.com>
> >> Date:   Wed Feb 15 18:48:14 2017 +0530
> >>
> >>     PCI: dwc: all: Split struct pcie_port into host-only and core structures
> >>
> >> Which seem to be causing our issues. Our device (imx6q-b850v3.dts) boots
> >> fine with 4.10, and also boots if we disable pcie with:
> >>
> >> diff --git a/arch/arm/boot/dts/imx6q-b850v3.dts b/arch/arm/boot/dts/imx6q-b850v3.dts
> >> index 2c1e98e..e655fd7 100644
> >> --- a/arch/arm/boot/dts/imx6q-b850v3.dts
> >> +++ b/arch/arm/boot/dts/imx6q-b850v3.dts
> >> @@ -212,3 +212,8 @@
> >>                 };
> >>         };
> >>  };
> >> +
> >> +&pcie {
> >> +        status = "disabled";
> >> +};
> >>
> >> But otherwise our system freezes while initializing PCI, see dmesg with
> >> some more information. Is this something specific of our system/dt or
> >> can this be a bug that is affecting others as well?
> > 
> > Haven't seen this in dra7xx. I've tried with few ethernet PCIe cards and also a
> > PCIe-to-PCI bridge.
> 
> Can you enable PCI_DEBUG and share the logs?

Enabling CONFIG_PCI_DEBUG did not change anything on the output on the
scenario that does not work, suggestions? And unfortuantely the
parameter pci=earlydump seems to be x86 only...
