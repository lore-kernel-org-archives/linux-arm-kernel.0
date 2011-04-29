From: nico@fluxnic.net (Nicolas Pitre)
Date: Thu, 28 Apr 2011 21:00:08 -0400 (EDT)
Subject: [PATCH] ARM: Include Makefile.boot only when it exists
In-Reply-To: <20110428152735.GU17290@n2100.arm.linux.org.uk>
References: <1303103976-4922-1-git-send-email-eric.y.miao@gmail.com>
	<20110420083258.GB1517@S2100-06.ap.freescale.net>
	<BANLkTiknesdF7cMZ=RGJAh75aW_wRpyj-w@mail.gmail.com>
	<20110428152735.GU17290@n2100.arm.linux.org.uk>
Message-ID: <alpine.LFD.2.00.1104281925500.24613@xanadu.home>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, 28 Apr 2011, Russell King - ARM Linux wrote:

> If/when we move to DT, do people think that Linus is going to accept
> having the DT files in the kernel for all these platforms, and will he
> be happy to see stuff like the files containing the OMAP clock definitions
> being constantly patched?  Remember, it's *exactly* this data which Linus
> wants out of the kernel source.

Well, here's what he said:

|But trust me, if you start doing a better job at platform code, I
|won't be complaining when I get lots of deleted code, or when I start
|getting devicetree descriptions instead of new drivers.
(http://article.gmane.org/gmane.linux.kernel/1121387)

So of course this "getting devicetree descriptions" might be interpreted 
to mean different things.

OTOH, the device tree source files can be arranged with common 
definitions in something like a header file that is included by board 
specific files.  So, at least in theory, differences between similar 
boards should be small, hopefully smaller than the equivalent in C.

Also, DT files should be a representation of the hardware which is meant 
to be stable.  If it wasn't stable, there would be no point using a data 
structure that can also be used outside of the kernel.  Remember that 
one of the selling point for DT is to be able to boot an existing kernel 
binary on yet-to-be-created hardware simply by creating the appropriate 
DT description for it.  Hence the DT files for existing hardware 
shouldn't have to change even if the kernel side implementation does.

> I suspect the answer to that is no.  So I think we should start right now
> with the idea that putting DT files - even the core SoC ones - into the
> kernel isn't going to be acceptable.

Well, if you look at arch/powerpc/boot/dts/* you'll find a bunch of 
board specific DT files in there already, and Linus has identified PPC 
as one architecture that did it right in his mind.


Nicolas
