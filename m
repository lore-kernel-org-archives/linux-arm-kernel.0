From: paul@pwsan.com (Paul Walmsley)
Date: Tue, 21 Feb 2012 15:02:07 -0700 (MST)
Subject: [PATCH 2/3] tty: serial: OMAP: block idle while the UART is
 transferring data in PIO mode
In-Reply-To: <4F423E28.3040404@ti.com>
References: <20120126024903.31613.24730.stgit@dusk>
 <20120126025036.31613.67819.stgit@dusk> <4F423E28.3040404@ti.com>
Message-ID: <alpine.DEB.2.00.1202211456160.25023@utopia.booyaka.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Salut Beno?t,

On Mon, 20 Feb 2012, Cousson, Benoit wrote:

> 3.3-rc4 is broken in the DT case because of the serial driver. And it 
> looks like it is due to this fix.  We cannot rely on pdata anymore in 
> DT, and in that case it leads to an Oops due to NULL pdata.

Sorry about the breakage.  I agree with the diagnosis.  That code was just 
copied from the DMA errata part of the driver, so it will need to be fixed 
as well.  Otherwise the same problem will happen when DMA is enabled.

> And then we will have to add the support for all these OMAP custom hooks without pdata.

That's really the key question for the medium- to long-term...

> A basic fix (below) for the moment is to test for valid pdata inside the driver.
> I'll repost it properly if you are fine with it.

Looks fine to me, although I'd suggest fixing the DMA workaround path as 
well.

Reviewed-by: Paul Walmsley <paul@pwsan.com>


- Paul
