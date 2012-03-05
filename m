From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Mon, 5 Mar 2012 00:04:11 +0000
Subject: [PATCH 15/20] ASoC: fsl: make fsl_ssi driver compilable on ARM/IMX
In-Reply-To: <4F53FBA1.8090200@freescale.com>
References: <1330788001-10158-1-git-send-email-shawn.guo@linaro.org>
 <1330788001-10158-16-git-send-email-shawn.guo@linaro.org>
 <4F53F704.8080703@freescale.com>
 <20120304232817.GA13516@n2100.arm.linux.org.uk>
 <4F53FBA1.8090200@freescale.com>
Message-ID: <20120305000411.GL7363@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, Mar 04, 2012 at 11:32:50PM +0000, Tabi Timur-B04825 wrote:
> Russell King - ARM Linux wrote:
> > Is the SCR shared between capture and playback?  In that case, what
> > makes this read-modify-write thread safe?
> 
> What's "SCR"?

I assumed you knew the code you were commenting on.

                clrbits32(&ssi->scr, CCSR_SSI_SCR_SSIEN);

The register these functions seem to be used on appears to be called
'SCR'.

> It's not thread-safe on PPC, but then neither is the entire function.  You 
> can't have two threads attempt to initialize the hardware at the same 
> time.

Why do you say "can't" - what prevents it?  If nothing, then this stuff
is buggy when preempt is enabled, or you're running on SMP.
