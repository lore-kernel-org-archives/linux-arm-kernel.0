From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Fri, 8 Jul 2011 10:07:21 +0100
Subject: [PATCH 0/7] Re-organize linker layouts
In-Reply-To: <4E165597.90002@codeaurora.org>
References: <20110706102245.GO8286@n2100.arm.linux.org.uk>
	<4E15ECB6.40100@codeaurora.org>
	<20110707223620.GG20403@n2100.arm.linux.org.uk>
	<4E165597.90002@codeaurora.org>
Message-ID: <20110708090721.GC2414@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Jul 07, 2011 at 05:55:51PM -0700, Stephen Boyd wrote:
> On 07/07/2011 03:36 PM, Russell King - ARM Linux wrote:
> > Oh, what did you use instead?  I thought no one used the Image files
> > anymore...
> 
> I used an Image. Android bootloaders are perfectly fine booting those.
> Plus, the zreladdr for every MSM post 7x00a isn't upstream.

Ah, ok.  Thanks for letting me know and thanks for the tested-by.

> Which reminds me, the zreladdr for every MSM besides 7x00a and 8x50 is
> 0xX0208000 which doesn't play nicely with AUTO_ZRELADDR. I wish we could
> fix that.

And there's probably platforms which need it the existing way...

There's also platforms where the zImage is loaded at some predetermined
offset into RAM to give the decompressor room to directly place the
kernel in its final location too, which will be buggered by
AUTO_ZRELADDR.
