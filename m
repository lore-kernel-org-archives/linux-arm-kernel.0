From: will.deacon@arm.com (Will Deacon)
Date: Thu, 11 Aug 2011 09:46:26 +0100
Subject: Enabling runtime P2V by default (Re: [PATCH 3/5] mach-u300:
	patch physoffset by default)
In-Reply-To: <20110811082413.GA4775@n2100.arm.linux.org.uk>
References: <1312918898-11894-1-git-send-email-linus.walleij@stericsson.com>
	<20110810091635.GF1831@n2100.arm.linux.org.uk>
	<20110810092206.GE10121@e102144-lin.cambridge.arm.com>
	<20110810092955.GG1831@n2100.arm.linux.org.uk>
	<20110811082413.GA4775@n2100.arm.linux.org.uk>
Message-ID: <20110811084624.GA25103@e102144-lin.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Russell,

On Thu, Aug 11, 2011 at 09:24:13AM +0100, Russell King - ARM Linux wrote:
> Right, I'm now committing a patch to hide the option unless EMBEDDED
> is enabled.  I think this means we should get rid of the 'select
> ARM_PATCH_PHYS_VIRT' statements from the various platforms, so that
> folk can optimize away that code if they know what they're doing.
> 
> Note: this patch will conflict with the removal of the 16-bit P2V
> patching, so we need to sort that out.
> 
> 8<---------
> From: Russell King - ARM Linux <linux@arm.linux.org.uk>
> ARM: enable ARM_PATCH_PHYS_VIRT by default
> 
> Enable virtual to physical translation patching by default in all
> kernels.  Hide the option behind EMBEDDED.
> 
> This can still be turned off if people desire, and they know what
> they're doing, to shrink the size of the kernel to a minimum.
> 
> Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>
> ---
>  arch/arm/Kconfig |    8 ++++++--
>  1 files changed, 6 insertions(+), 2 deletions(-)

With the typo fix, you can have my ack if you like:

Acked-by: Will Deacon <will.deacon@arm.com>

Cheers,

Will
