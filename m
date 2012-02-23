From: timur@freescale.com (Timur Tabi)
Date: Thu, 23 Feb 2012 11:04:59 -0600
Subject: [PATCH 4/4] ASoC: fsl: make fsl_ssi driver compilable on ARM/IMX
In-Reply-To: <20120223165242.GB22562@n2100.arm.linux.org.uk>
References: <1329979644-31046-1-git-send-email-shawn.guo@linaro.org>
 <1330008519-3584-1-git-send-email-shawn.guo@linaro.org>
 <1330008519-3584-5-git-send-email-shawn.guo@linaro.org>
 <4F465A33.3020208@ru.mvista.com> <4F465EE5.4010908@freescale.com>
 <20120223165242.GB22562@n2100.arm.linux.org.uk>
Message-ID: <4F4671BB.7060409@freescale.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Russell King - ARM Linux wrote:
> Is your readl() or readl_be() unordered then?  

Yes.  At least, it sure looks like it is.

> Wouldn't that be buggy
> between coherent DMA accesses and accessing, eg, a PCI peripheral to
> enable or read DMA status?

I think so.

We almost never use readl.  I see that it is used in some places, but
honestly I can't see how it can be valid.  For instance, the mpic driver
uses it in mpic_startup_ht_interrupt().  I don't understand how that's
valid, since there's nothing preventing the readl() from happening
*before* the writeb.

I'll have to ask around, because I'm sure I'm missing something.

-- 
Timur Tabi
Linux kernel developer at Freescale
