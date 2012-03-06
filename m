From: tiwai@suse.de (Takashi Iwai)
Date: Tue, 06 Mar 2012 14:46:24 +0100
Subject: [alsa-devel] [PATCH 15/20] ASoC: fsl: make fsl_ssi driver
 compilable on ARM/IMX
In-Reply-To: <20120306133818.GV19635@opensource.wolfsonmicro.com>
References: <20120304232817.GA13516@n2100.arm.linux.org.uk>
 <4F53FBA1.8090200@freescale.com>
 <20120305000411.GL7363@n2100.arm.linux.org.uk>
 <4F54053F.9070502@freescale.com>
 <20120305002635.GA23798@opensource.wolfsonmicro.com>
 <20120306104015.GF17370@n2100.arm.linux.org.uk>
 <20120306120646.GH19635@opensource.wolfsonmicro.com>
 <20120306122516.GH17370@n2100.arm.linux.org.uk>
 <20120306123322.GP19635@opensource.wolfsonmicro.com>
 <s5h4nu17tdn.wl%tiwai@suse.de>
 <20120306133818.GV19635@opensource.wolfsonmicro.com>
Message-ID: <s5h1up57sgf.wl%tiwai@suse.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

At Tue, 6 Mar 2012 13:38:18 +0000,
Mark Brown wrote:
> 
> On Tue, Mar 06, 2012 at 02:26:28PM +0100, Takashi Iwai wrote:
> > Mark Brown wrote:
> > > On Tue, Mar 06, 2012 at 12:25:16PM +0000, Russell King - ARM Linux wrote:
> 
> > > whenever you need to call back into the ALSA APIs.  Though of course I'm
> > > pretty sure there's a bunch of uniprocessor assumptions through the body
> > > of driver code anyway...
> 
> > Not that much actually.  On the contrary, because of the current
> > design allowing concurrent accesses, many codes have been written
> > rather in too complex and messy ways.  It could have been much
> > simplified if we didn't consider the concurrent accesses to each
> > substream.
> 
> Right, but I'm fairly sure that at least some of the driver code is
> relying on uniprocessor assumptions for what it's doing - there's a
> bunch of things that can't happen on unipocessor that can happen on
> SMP (or preempting) systems.

Yeah, the driver codes.  There must be handful such ones...


Takashi
