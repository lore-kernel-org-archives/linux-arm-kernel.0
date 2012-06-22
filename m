From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Fri, 22 Jun 2012 14:17:51 +0100
Subject: [RFC 0/3] Add cyclic DMA support to OMAP DMA engine driver
In-Reply-To: <20120622123013.GA7586@sirena.org.uk>
References: <20120622085911.GA19026@n2100.arm.linux.org.uk>
 <20120622123013.GA7586@sirena.org.uk>
Message-ID: <20120622131750.GB19226@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Jun 22, 2012 at 01:30:13PM +0100, Mark Brown wrote:
> On Fri, Jun 22, 2012 at 09:59:11AM +0100, Russell King - ARM Linux wrote:
> 
> > As v3.5-rc is horribly broken on my OMAP platforms, I've had to back out
> > all the sound/soc/omap changes from the last merge window to test this,
> > inspite of Peter Ujfalusi maintaining that there is nothing wrong.  I
> > can't get working audio support on the OMAP4430SDP any other way.
> 
> Do you have any details on what's wrong here?  I've not seen any
> upstream reports but there's been precious little upstream work there so
> it should be simple to identify which changes caused the breakage and
> just drop them.  There's been no public reports...

Peter took the thread off the mailing lists.

3.5-rc3 + Peter's blaze.aconf + aplay produces no audio but aplay
appears to complete in about the right time.

3.5-rc3 + Peter's blaze.aconf + aplay + sound/soc/omap reverted back to
v3.4 produces audio.

I have nothing further, other than "it produces no audio".  As I have
zero information on the SDP4430 hardware, if something doesn't work I
just stop and post a bug report.  I've no idea of the structure of the
audio implementations on OMAP platforms.  That information is kept from
me.

I suspect the key difference is I run the uImage kernels on the SDP4430
without a DT blob.  I suspect it's the DT conversion of sound/soc/omap
that's buggered it up.
