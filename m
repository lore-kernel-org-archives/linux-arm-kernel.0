From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Fri, 4 Feb 2011 11:03:42 +0000
Subject: [PATCH 2/2] ARM: Make CONFIG_FPE_NWFPE depend on
	!CONFIG_THUMB2_KERNEL
In-Reply-To: <1291895982-4775-3-git-send-email-dave.martin@linaro.org>
References: <1291895982-4775-1-git-send-email-dave.martin@linaro.org>
	<1291895982-4775-3-git-send-email-dave.martin@linaro.org>
Message-ID: <20110204110342.GE15004@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Dec 09, 2010 at 11:59:42AM +0000, Dave Martin wrote:
> Because the nwfpe support is unlikely to be used on new platforms
> and requires CONFIG_OABI_COMPAT, which is not generally used with
> ARMv7+, we shouldn't expect to build nwfpe support into a Thumb-2
> kernel.
> 
> At present, nwfpe contains assembly code which isn't Thumb-2
> compatible, and for now it doesn't appear useful to port this
> code.

You might as well make OABI_COMPAT depend on !THUMB2_KERNEL.  OABI
userland is useless without FPA support.
