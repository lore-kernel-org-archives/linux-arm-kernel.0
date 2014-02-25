From: will.deacon@arm.com (Will Deacon)
Date: Tue, 25 Feb 2014 18:06:59 +0000
Subject: [PATCH 03/18] arm64: boot protocol documentation update for GICv3
In-Reply-To: <1391607050-540-4-git-send-email-marc.zyngier@arm.com>
References: <1391607050-540-1-git-send-email-marc.zyngier@arm.com>
 <1391607050-540-4-git-send-email-marc.zyngier@arm.com>
Message-ID: <20140225180658.GH23136@mudshark.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Feb 05, 2014 at 01:30:35PM +0000, Marc Zyngier wrote:
> Linux has some requirements that must be satisfied in order to boot
> on a system built with a GICv3.
> 
> Signed-off-by: Marc Zyngier <marc.zyngier@arm.com>
> ---
>  Documentation/arm64/booting.txt | 7 +++++++
>  1 file changed, 7 insertions(+)
> 
> diff --git a/Documentation/arm64/booting.txt b/Documentation/arm64/booting.txt
> index a9691cc..4a02ebd 100644
> --- a/Documentation/arm64/booting.txt
> +++ b/Documentation/arm64/booting.txt
> @@ -131,6 +131,13 @@ Before jumping into the kernel, the following conditions must be met:
>    the kernel image will be entered must be initialised by software at a
>    higher exception level to prevent execution in an UNKNOWN state.
>  
> +  For systems with a GICv3 interrupt controller, it is expected that:
> +  - ID_AA64PFR0_EL1.GIC (bits [27:24]) must have the value 0b0001

Since ID_AA64PFR0_EL1 is read-only at all exception levels, I don't see the
value of this statement.

> +  - If EL3 is present, it must program ICC_SRE_EL3.Enable (bit 3) to
> +    0b1 and ICC_SRE_EL3.SRE (bit 0) to 0b1.
> +  - If the kernel is entered at EL1, EL2 must set ICC_SRE_EL2.Enable
> +    (bit 3) to 0b1 and ICC_SRE_EL2.SRE (bit 0) to 0b1.

Does this force the kernel to use SRE?

Will
