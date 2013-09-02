From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Mon, 2 Sep 2013 15:16:31 +0100
Subject: [alsa-devel] [PATCH 00/14] SPDIF support
In-Reply-To: <20130902140632.GQ3084@sirena.org.uk>
References: <20130901123433.GR6617@n2100.arm.linux.org.uk>
 <20130902140632.GQ3084@sirena.org.uk>
Message-ID: <20130902141631.GV6617@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Sep 02, 2013 at 03:06:32PM +0100, Mark Brown wrote:
> On Sun, Sep 01, 2013 at 01:34:33PM +0100, Russell King - ARM Linux wrote:
> > This is where those who are using mainline kernels with DT on Dove
> > platforms (like Jean-Francois and Sebastian) need a working solution to
> > this in a form which they can come up with a representative DT solution.
> > This is not a one-person effort - there's multiple efforts working on
> > this, and it's all inter-linked.
> 
> Yes, and this is one of the reasons for suggesting getting either/or
> support merged - it will help things like the binding definition
> progress (as well as being useful for any users with a S/PDIF only
> system).

Sorry, but I believe the exact opposite:

1. The DAI link binding created for a dual-DAI driver is completely
   different from the DAI link binding for a DPCM driver.  The dual
   DAI link binding will have to be completely rewritten when the
   driver is converted to DPCM.

2. When the driver is converted to DPCM, it must use DPCM for
   everything, otherwise it has no way to know which of SPDIF or I2S to
   enable.  The only way I know to work around that is to add additional
   routes to link up the AIF widgets, and that's the solution you're all
   telling me is not acceptable, as per the patch set at the start of
   this thread.
