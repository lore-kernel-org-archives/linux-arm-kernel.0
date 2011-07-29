From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Fri, 29 Jul 2011 11:32:39 +0100
Subject: [PATCH 2/2] ARM: msm: Remove PLAT_PHYS_OFFSETS from MSM targets
In-Reply-To: <1311884291-5409-2-git-send-email-davidb@codeaurora.org>
References: <1311794355-26988-2-git-send-email-sboyd@codeaurora.org>
	<1311884291-5409-1-git-send-email-davidb@codeaurora.org>
	<1311884291-5409-2-git-send-email-davidb@codeaurora.org>
Message-ID: <20110729103239.GC25640@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Jul 28, 2011 at 01:18:11PM -0700, David Brown wrote:
> Now that MSM can boot with the phys offset patching, eliminate the
> definitions of the phys offsets, and instead select
> ARM_PATCH_PHYS_VIRT.

I think it may be better to remove the EXPERIMENTAL status of
ARM_PATCH_PHYS_VIRT, and make the option default to 'y' now, so that
we start building all kernels with this enabled.  If people don't
want it (and know what they're doing) they can disable it manually
(maybe make the option only appear for EXPERT).

Lets see about that after this merge window is over.
