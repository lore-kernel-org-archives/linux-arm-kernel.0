From: richardcochran@gmail.com (Richard Cochran)
Date: Mon, 13 Jun 2011 07:58:31 +0200
Subject: [PATCH] arm: fix regression in ixp4xx clocksource
In-Reply-To: <20110612135159.GH10283@n2100.arm.linux.org.uk>
References: <20110530084307.GA28953@riccoc20.at.omicron.at>
	<20110601225826.GR3660@n2100.arm.linux.org.uk>
	<20110611051510.GA3283@riccoc20.at.omicron.at>
	<20110612135159.GH10283@n2100.arm.linux.org.uk>
Message-ID: <20110613055831.GA3757@riccoc20.at.omicron.at>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, Jun 12, 2011 at 02:51:59PM +0100, Russell King - ARM Linux wrote:
>
> It's basically a problem, and its one of the unfortunate prices paid
> by consolidating code - things become harder and less efficient to do.
> 
> In this case, I think we need a set of _be() clocksource accessors in
> mmio.c, and leave it up to the platform to select the correct accessor.

So, is IXP the only machine that would need such accessors?

If so, then I think just using my patch as a single exception would be
fine (maybe adding a comment justifying the exception).

Thanks,
Richard
