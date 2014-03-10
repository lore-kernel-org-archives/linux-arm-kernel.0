From: soren.brinkmann@xilinx.com (=?utf-8?B?U8O2cmVu?= Brinkmann)
Date: Mon, 10 Mar 2014 15:32:25 -0700
Subject: [RFC PATCH] edac: zynq: Added EDAC support for zynq ddr ecc
 controller
In-Reply-To: <531DA900.5060202@monstr.eu>
References: <4adb2b4b-2ad6-42b9-929e-cc062f817245@TX2EHSMHS021.ehs.local>
 <20140310105655.GH14999@e106331-lin.cambridge.arm.com>
 <531DA900.5060202@monstr.eu>
Message-ID: <fa35006e-055d-4ef2-9b65-a0f8cc6a0c8f@AM1EHSMHS016.ehs.local>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, 2014-03-10 at 12:58PM +0100, Michal Simek wrote:
> On 03/10/2014 11:56 AM, Mark Rutland wrote:
> > On Sun, Mar 09, 2014 at 02:57:16AM +0000, Punnaiah Choudary Kalluri wrote:
> >> Added EDAC support for reporting the ecc errors of zynq ddr controller.
> >> The ddr ecc controller corrects single bit errors and detects double bit
> >> errors
> >>
> >> Signed-off-by: Punnaiah Choudary Kalluri <punnaia@xilinx.com>
> >> ---
> >>  .../devicetree/bindings/edac/zynq_edac.txt         |   18 +
> >>  drivers/edac/Kconfig                               |    7 +
> >>  drivers/edac/Makefile                              |    1 +
> >>  drivers/edac/zynq_edac.c                           |  613 ++++++++++++++++++++
> >>  4 files changed, 639 insertions(+), 0 deletions(-)
> >>  create mode 100644 Documentation/devicetree/bindings/edac/zynq_edac.txt
> >>  create mode 100644 drivers/edac/zynq_edac.c
> >>
> >> diff --git a/Documentation/devicetree/bindings/edac/zynq_edac.txt b/Documentation/devicetree/bindings/edac/zynq_edac.txt
> >> new file mode 100644
> >> index 0000000..c21ff83
> >> --- /dev/null
> >> +++ b/Documentation/devicetree/bindings/edac/zynq_edac.txt
> >> @@ -0,0 +1,18 @@
> >> +Zynq EDAC driver, it does reports the DDR ECC single bit errors that are
> >> +corrected and double bit ecc errors that are detected by the DDR ECC controller.
> >> +ECC support for DDR is available in half-bus width(16 bit) configuration only.
> >> +
> >> +Required properties:
> >> +- compatible: Should be "xlnx,ps7-ddrc" or "xlnx,ps7-ddrc-1.00.a"
> > 
> > Is this an or or a xor?
> 
> Compatible string should be just xlnx,zynq-ddrc-1.00.a.
> Nothing with ps7.

Isn't this vendor IP? IMHO, this should be something completely
different. Or if you want some Zynq-specific compat string it should
refer to an actual version string associated with Zynq. 1.00.a is not,
AFAIK.

	S?ren
