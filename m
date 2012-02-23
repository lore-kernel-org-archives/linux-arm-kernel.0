From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Thu, 23 Feb 2012 16:52:42 +0000
Subject: [PATCH 4/4] ASoC: fsl: make fsl_ssi driver compilable on ARM/IMX
In-Reply-To: <4F465EE5.4010908@freescale.com>
References: <1329979644-31046-1-git-send-email-shawn.guo@linaro.org>
 <1330008519-3584-1-git-send-email-shawn.guo@linaro.org>
 <1330008519-3584-5-git-send-email-shawn.guo@linaro.org>
 <4F465A33.3020208@ru.mvista.com> <4F465EE5.4010908@freescale.com>
Message-ID: <20120223165242.GB22562@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Feb 23, 2012 at 09:44:37AM -0600, Timur Tabi wrote:
> Sergei Shtylyov wrote:
> >     These functions are not equivalent concerning endianness. You should 
> > probably have used readl_be() instead, else it won't work on PPC anymore.
> 
> readl_be() is not good enough, either.  The in/out_be functions have
> specific syncronization instructions in them, so that the operations
> conform to the PowerPC instruction ordering architecture.

Is your readl() or readl_be() unordered then?  Wouldn't that be buggy
between coherent DMA accesses and accessing, eg, a PCI peripheral to
enable or read DMA status?
