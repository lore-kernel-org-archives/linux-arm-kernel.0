From: timur@freescale.com (Timur Tabi)
Date: Fri, 24 Feb 2012 16:00:17 -0600
Subject: [PATCH 4/4] ASoC: fsl: make fsl_ssi driver compilable on ARM/IMX
In-Reply-To: <20120224215448.GA15120@n2100.arm.linux.org.uk>
References: <1329979644-31046-1-git-send-email-shawn.guo@linaro.org>
 <1330008519-3584-1-git-send-email-shawn.guo@linaro.org>
 <1330008519-3584-5-git-send-email-shawn.guo@linaro.org>
 <4F465A33.3020208@ru.mvista.com> <4F465EE5.4010908@freescale.com>
 <20120223165242.GB22562@n2100.arm.linux.org.uk>
 <4F4671BB.7060409@freescale.com>
 <20120223171407.GC22562@n2100.arm.linux.org.uk>
 <4F480120.6080409@freescale.com>
 <20120224215448.GA15120@n2100.arm.linux.org.uk>
Message-ID: <4F480871.9020206@freescale.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Russell King - ARM Linux wrote:
> BenH tells me that he'll accept patches which converts in_32be() to
> ioread32be(), as in_32be() is ancient PPC cruft that needs to die.

Where did he say this?  in_be32() (and its variants) are used EVERYWHERE
in PowerPC code.

Also, keep in mind that on ARM, ioread32be() is probably wrong, because we
want to read the register as little-endian.  The SSI audio controller is
little-endian on i.MX chips and big-endian on PowerPC chip.  So we really
need a native-endian variant of ioread32be().  ioread32() is little-endian
on PowerPC, so we can't use that.

-- 
Timur Tabi
Linux kernel developer at Freescale
