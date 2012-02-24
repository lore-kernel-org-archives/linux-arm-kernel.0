From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Fri, 24 Feb 2012 23:15:02 +0000
Subject: [PATCH 4/4] ASoC: fsl: make fsl_ssi driver compilable on ARM/IMX
In-Reply-To: <4F4817AC.7050406@freescale.com>
References: <4F465A33.3020208@ru.mvista.com> <4F465EE5.4010908@freescale.com>
 <20120223165242.GB22562@n2100.arm.linux.org.uk>
 <4F4671BB.7060409@freescale.com>
 <20120223171407.GC22562@n2100.arm.linux.org.uk>
 <4F480120.6080409@freescale.com>
 <20120224215448.GA15120@n2100.arm.linux.org.uk>
 <4F480871.9020206@freescale.com>
 <20120224223512.GB15120@n2100.arm.linux.org.uk>
 <4F4817AC.7050406@freescale.com>
Message-ID: <20120224231501.GD15120@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Feb 24, 2012 at 05:05:16PM -0600, Timur Tabi wrote:
> Russell King - ARM Linux wrote:
> 
> > Ho hum.  So, what that's saying to me is that even implementing in_32be()
> > on ARM results in rubbish because it wouldn't be big endian there.
> 
> Well, the "be" in in_be32() means to assume that 32-bit integer is stored
> in big-endian format, and to convert it to native format during the read.
>  An ARM implementation of in_be32() would include byte-swapping.

So, let's go around this loop again.

What would be wrong with converting in_be32() in these drivers to
instead ioread32be()?
