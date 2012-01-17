From: swarren@nvidia.com (Stephen Warren)
Date: Tue, 17 Jan 2012 11:32:37 -0800
Subject: Pinmux bindings proposal
In-Reply-To: <20120117141322.GA31687@S2101-09.ap.freescale.net>
References: <74CDBE0F657A3D45AFBB94109FB122FF17801D202F@HQMAIL01.nvidia.com>
 <7FE21149F4667147B645348EC6057885091DEA@039-SN2MPN1-013.039d.mgd.msft.net>
 <20120117082334.GA31295@S2101-09.ap.freescale.net>
 <7FE21149F4667147B645348EC6057885092D56@039-SN2MPN1-013.039d.mgd.msft.net>
 <20120117141322.GA31687@S2101-09.ap.freescale.net>
Message-ID: <74CDBE0F657A3D45AFBB94109FB122FF17801D22FA@HQMAIL01.nvidia.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Shawn Guo wrote at Tuesday, January 17, 2012 7:13 AM:
> On Tue, Jan 17, 2012 at 09:46:42AM +0000, Dong Aisheng-B29396 wrote:
> ...
> > I guess Stephen's idea is to retrieving the function name and group name
> > From the pinctrl driver since Tagre prefers to define those things in driver
> > Rather than in board file or soc.dts file.
> > But it does not fit for IMX since we define it in soc.dts.
>
> Hmm, when he came up with this proposal and said it should work for
> Tegra, I assume he plans to move those from Tegra pinctrl driver into
> device tree.  Stephen?

I plan to have the following:

tegra20.dtsi:

A regular device node for the pin controller, listing just the basic
device tree properties: "compatible" and "regs".

${board}.dts:

Each device node lists its pin mux/config setup using the bindings we
decide upon.

drivers/pinctrl/pinctrl-tegra20.c:

Static tables listing all pins, pin groups, mux functions, and pin
configuration options that Tegra supports.

-- 
nvpublic
