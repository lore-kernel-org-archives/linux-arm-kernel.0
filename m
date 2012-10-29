From: nbowler@elliptictech.com (Nick Bowler)
Date: Mon, 29 Oct 2012 14:13:40 -0400
Subject: [PATCH] ARM: zynq: Allow UART1 to be used as DEBUG_LL console.
In-Reply-To: <20121029165621.GF5190@beefymiracle.amer.corp.natinst.com>
References: <20121025224108.GA30705@elliptictech.com>
 <1351205254-2409-1-git-send-email-nbowler@elliptictech.com>
 <20121029165621.GF5190@beefymiracle.amer.corp.natinst.com>
Message-ID: <20121029181340.GA4760@elliptictech.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 2012-10-29 10:56 -0600, Josh Cartwright wrote:
> On Thu, Oct 25, 2012 at 06:47:34PM -0400, Nick Bowler wrote:
> > The main UART on the Xilinx ZC702 board is UART1, located at address
> > e0001000.  Add a Kconfig option to select this device as the low-level
> > debugging port.  This allows the really early boot printouts to reach
> > the USB serial adaptor on this board.
> > 
> > For consistency's sake, add a choice entry for UART0 even though it is
> > the the default if UART1 is not selected.
> > 
> > As there are currently known issues related to the UART virtual
> > mappings, this is KNOWN BROKEN, not to be merged yet!
> > 
> > Not-Yet-Signed-off-by: Nick Bowler <nbowler@elliptictech.com>
> 
> Tested-by: Josh Cartwright <josh.cartwright@ni.com>
> 
> Now that v5 of the initial zynq cleanup patchset is queued up for
> merging (with a workaround for the uart mapping problem), what would it
> take for you to sign off on this patch?

Great, I've tested this on top of the other 4 and the boot console is
working now.  I will resend the patch with my signoff.

(I wonder if UART0 has similar address problems on the ZC702 if it is
selected as the boot console... but this is harder to test as AFAIK it's
not connected to anything on this board by default, but it could in
principle be connected to something in the PL.  We can cross that bridge
if and when we get to it, I guess).

> There is some trivial merging that has to be done to get it to apply
> cleanly on v5.  See a rebased version below.

Yup, looks good.

Cheers,
-- 
Nick Bowler, Elliptic Technologies (http://www.elliptictech.com/)
