From: soren.brinkmann@xilinx.com (=?utf-8?B?U8O2cmVu?= Brinkmann)
Date: Fri, 25 Jul 2014 07:49:47 -0700
Subject: [PATCH v2 08/11] ARM: dts: zynq: Add VDMA to Parallella
In-Reply-To: <53D22799.8050903@suse.de>
References: <1406242820-20140-1-git-send-email-afaerber@suse.de>
 <1406242820-20140-9-git-send-email-afaerber@suse.de>
 <b4c4e060-2efb-4b82-be12-32c00897ec93@BY2FFO11FD023.protection.gbl>
 <53D22799.8050903@suse.de>
Message-ID: <f0a06d6e-e10a-48c1-91a3-fc99f4a772b4@BN1AFFO11FD044.protection.gbl>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, 2014-07-25 at 11:47AM +0200, Andreas F?rber wrote:
> Hi S?ren,
> 
> Am 25.07.2014 01:22, schrieb S?ren Brinkmann:
> > On Fri, 2014-07-25 at 01:00AM +0200, Andreas F?rber wrote:
> >> Signed-off-by: Andreas F?rber <afaerber@suse.de>
> >> ---
> >>  v2: New
> >>  
> >>  arch/arm/boot/dts/zynq-parallella.dts | 25 +++++++++++++++++++++++++
> >>  1 file changed, 25 insertions(+)
> >>
> >> diff --git a/arch/arm/boot/dts/zynq-parallella.dts b/arch/arm/boot/dts/zynq-parallella.dts
> >> index e60a0a9..8beaacc 100644
> >> --- a/arch/arm/boot/dts/zynq-parallella.dts
> >> +++ b/arch/arm/boot/dts/zynq-parallella.dts
> >> @@ -32,6 +32,31 @@
> >>  		bootargs = "console=ttyPS0,115200 earlyprintk root=/dev/mmcblk0p2 rootfstype=ext4 rw rootwait";
> >>  		linux,stdout-path = "/amba/serial at e0001000";
> >>  	};
> >> +
> >> +	fpga {
> > Do you really want FPGA components in this DT?
> > If somebody tries booting with this DT without programming with a
> > corresponding bitstream, the whole system might hang.
> > Just something to consider.
> 
> Well, that's related to a question that remained unanswered on v1:
> whether we may need to turn this into a .dtsi to cope with variations.
> 
> The Parallella has an on-board ?HDMI connector, and two bitstreams are
> delivered - one for HDMI and one for headless usage. In my testing I am
> using the original HDMI bitstream but serial console for lack of
> upstream HDMI drivers. Do you think we need to provide
> zynq-parallella-hdmi.dts and zynq-parallella-headless.dts? (It gets
> worse if at some point we need to handle variations of the on-board
> Epiphany chip plus the bitstreams - at least the Z7010 vs. Z7020 doesn't
> affect DT AFAICT.)
> 
> Since, as noted in the cover letter, these FPGA patches are not yet
> fully testable, I wouldn't mind deferring them, but wanted to get them
> out for review early.
> 
> http://www.parallella.org/2014/07/14/new-parallella-product-offerings/
> indicates there will be a new variation in gen2 without USB/HDMI. Would
> it be valid to #include a .dts (rather than .dtsi) to override status
> and keep number of Parallella files low?

For these FPGA devices, it would be nice if it was possible to include
a dts file. I think there were problems with that, but don't know what
the current status of that is. Then it would be possible to have the SOC
dtsi a board dts and systems with FPGA components can include the board
dts.
I also heard that some people are getting upset with all the includes
going on in the dts files.

And the next question would be: How many dts files do you really want
in the upstream kernel tree? Since we deal with FPGAs, there is
virtually and infinite number of different systems that you could
create relatively easily.

	S?ren
