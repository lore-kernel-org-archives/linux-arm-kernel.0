From: christoffer.dall@linaro.org (Christoffer Dall)
Date: Fri, 9 May 2014 16:05:38 +0200
Subject: [PATCH v3 04/19] arm64: boot protocol documentation update for
 GICv3
In-Reply-To: <1397655591-2761-5-git-send-email-marc.zyngier@arm.com>
References: <1397655591-2761-1-git-send-email-marc.zyngier@arm.com>
 <1397655591-2761-5-git-send-email-marc.zyngier@arm.com>
Message-ID: <20140509140538.GE3362@lvm>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Apr 16, 2014 at 02:39:36PM +0100, Marc Zyngier wrote:
> Linux has some requirements that must be satisfied in order to boot
> on a system built with a GICv3.
> 
> Signed-off-by: Marc Zyngier <marc.zyngier@arm.com>
> ---
>  Documentation/arm64/booting.txt | 6 ++++++
>  1 file changed, 6 insertions(+)
> 
> diff --git a/Documentation/arm64/booting.txt b/Documentation/arm64/booting.txt
> index a9691cc..be765b6 100644
> --- a/Documentation/arm64/booting.txt
> +++ b/Documentation/arm64/booting.txt
> @@ -131,6 +131,12 @@ Before jumping into the kernel, the following conditions must be met:
>    the kernel image will be entered must be initialised by software at a
>    higher exception level to prevent execution in an UNKNOWN state.
>  
> +  For systems with a GICv3 interrupt controller, it is expected that:
> +  - If EL3 is present, it must program ICC_SRE_EL3.Enable (bit 3) to
> +    0b1 and ICC_SRE_EL3.SRE (bit 0) to 0b1.
> +  - If the kernel is entered at EL1, EL2 must set ICC_SRE_EL2.Enable
> +    (bit 3) to 0b1 and ICC_SRE_EL2.SRE (bit 0) to 0b1.
> +
>  The requirements described above for CPU mode, caches, MMUs, architected
>  timers, coherency and system registers apply to all CPUs.  All CPUs must
>  enter the kernel in the same exception level.
> -- 
> 1.8.3.4
> 
Acked-by: Christoffer Dall <christoffer.dall@linaro.org>
