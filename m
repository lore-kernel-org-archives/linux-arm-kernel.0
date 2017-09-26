From: mdf@kernel.org (Moritz Fischer)
Date: Tue, 26 Sep 2017 10:50:18 -0700
Subject: [PATCH 1/2] arm: dts: Add support for National Instruments
 Project Sulfur SDRs
In-Reply-To: <6b87e902-3201-6710-4921-d465dea19dcd@xilinx.com>
References: <20170911232223.91894-1-mdf@kernel.org>
 <314acb1f-1f0f-7893-70a8-9379c01112ac@xilinx.com>
 <20170925161136.GA12943@tyrael.ni.corp.natinst.com>
 <6b87e902-3201-6710-4921-d465dea19dcd@xilinx.com>
Message-ID: <20170926175018.GA14962@tyrael.ni.corp.natinst.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Michal,

On Tue, Sep 26, 2017 at 02:54:48PM +0200, Michal Simek wrote:
> Hi,
> 
> On 25.9.2017 18:11, Moritz Fischer wrote:
> > Hi Michal,
> > 
> > On Mon, Sep 25, 2017 at 10:19:44AM +0200, Michal Simek wrote:
> >> Hi Moritz
> >>
> >> sorry for delay.
> > 
> > No problem.
> > 
> >>
> >> On 12.9.2017 01:22, Moritz Fischer wrote:
> >>> Add support for the National Instruments Project Sulfur SDR
> >>> motherboards Rev 2,3 and 4.
> >>>
> >>> Signed-off-by: Moritz Fischer <mdf@kernel.org>
> >>> ---
> >>>  arch/arm/boot/dts/Makefile                |   3 +
> >>>  arch/arm/boot/dts/zynq-ni-sulfur-rev2.dts |  84 +++++++++++++++++++
> >>>  arch/arm/boot/dts/zynq-ni-sulfur-rev3.dts | 118 ++++++++++++++++++++++++++
> >>>  arch/arm/boot/dts/zynq-ni-sulfur-rev4.dts |  26 ++++++
> >>>  arch/arm/boot/dts/zynq-ni-sulfur.dtsi     | 133 ++++++++++++++++++++++++++++++
> >>>  5 files changed, 364 insertions(+)
> >>>  create mode 100644 arch/arm/boot/dts/zynq-ni-sulfur-rev2.dts
> >>>  create mode 100644 arch/arm/boot/dts/zynq-ni-sulfur-rev3.dts
> >>>  create mode 100644 arch/arm/boot/dts/zynq-ni-sulfur-rev4.dts
> >>>  create mode 100644 arch/arm/boot/dts/zynq-ni-sulfur.dtsi
> >>
> >> Is this publicly available board?
> > 
> > Will be in Q1 2018 was announced at GRCon'17 ([1]).
> > Some of the Rev3s are currently deployed in Norway as part of a radar
> > system.
> > 
> >> I am not quite sure we should apply these dts files. There are a lot of
> >> boards with zynq and there must be any strong argument for applying this
> >> to the tree. For arm32 with even flat tree structure.
> > 
> > What's the issue with merging them, except for having 3 more files? 
> 
> For me this is not a problem because on Linux side it is not increasing
> build time.
> I want to see the value for community. All xilinx platforms are
> evaluation generic purpose boards which are showing how to connect stuff
> together.
> On the other hand this is real product.

Uh.

> I would let arm-soc maintainer to decide if this is fine or not. I
> definitely don't want to end up in situation that we will have dts for
> real products which are not bringing any value for others.

Sure, it's the maintainers call.

I do intend to have my customers run mainline on it eventually, currently
I'm a handful of patches away from making that happen. So yes, running
mainline is a usecase that matters to me.

It is one thing to keep bitching about vendor kernels as a community
continuously, but then if someone goes through the effort and actually
tries to run mainline, you give them crap like that above.

Our products usually come with full schematics [1], firmware, fpga code and all
available, I don't know what makes them less useful to the community as a
platform to experiment and develop on than Xilinx eval boards.

There's several people that I know of both hobbyists and companies that
build systems around these platforms, so I don't know ...

- Moritz

[1] http://files.ettus.com/schematics/
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 488 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20170926/9b76af0d/attachment.sig>
