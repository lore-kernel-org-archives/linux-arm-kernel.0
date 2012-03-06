From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Tue, 6 Mar 2012 13:46:44 +0000
Subject: [PATCH 15/20] ASoC: fsl: make fsl_ssi driver compilable on ARM/IMX
In-Reply-To: <20120306123322.GP19635@opensource.wolfsonmicro.com>
References: <4F53F704.8080703@freescale.com>
 <20120304232817.GA13516@n2100.arm.linux.org.uk>
 <4F53FBA1.8090200@freescale.com>
 <20120305000411.GL7363@n2100.arm.linux.org.uk>
 <4F54053F.9070502@freescale.com>
 <20120305002635.GA23798@opensource.wolfsonmicro.com>
 <20120306104015.GF17370@n2100.arm.linux.org.uk>
 <20120306120646.GH19635@opensource.wolfsonmicro.com>
 <20120306122516.GH17370@n2100.arm.linux.org.uk>
 <20120306123322.GP19635@opensource.wolfsonmicro.com>
Message-ID: <20120306134644.GI17370@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Mar 06, 2012 at 12:33:22PM +0000, Mark Brown wrote:
> On Tue, Mar 06, 2012 at 12:25:16PM +0000, Russell King - ARM Linux wrote:
> 
> > Please also note that in ALSA documentation, an 'atomic' callback means
> > little with respect to race conditions.  All it means is that the callback
> > is called from a context where sleeping in the callback is not permitted.
> > The documentation does not say what is protected by the ALSA spinlocks and
> > mutexes, so without reviewing the ALSA code, driver writters have little
> > idea whether they need their own locks or not.
> 
> Well, who reads the documentation to get this stuff anyway?

Strangely, I do, and I'd bet most people writing an ALSA driver read
the "Writing an ALSA Driver" document, even though it's seven years old.
I also tend to read the code as well, though not everyone does.

> As you
> observe it's far from complete about what's what locked when and how so
> you need to go to the code to see what's actually going on, especially
> whenever you need to call back into the ALSA APIs.

The point is, during this thread I've had this 'atomic' business quoted
at me as the reason why read-modify-write of registers is safe.  That's
also proof that people other than me read that document - but not only
that, they then go on to misunderstand it and don't bother to read the
code.
