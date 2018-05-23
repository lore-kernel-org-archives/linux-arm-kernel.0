From: catalin.marinas@arm.com (Catalin Marinas)
Date: Wed, 23 May 2018 18:17:22 +0100
Subject: [PATCH v4 3/3] arm64: Introduce command line parameter to
 disable CNP
In-Reply-To: <1526638022-4137-4-git-send-email-vladimir.murzin@arm.com>
References: <1526638022-4137-1-git-send-email-vladimir.murzin@arm.com>
 <1526638022-4137-4-git-send-email-vladimir.murzin@arm.com>
Message-ID: <20180523171721.ppazcyf576koimhl@armageddon.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, May 18, 2018 at 11:07:02AM +0100, Vladimir Murzin wrote:
> diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
> index 11fc28e..8f59d47 100644
> --- a/Documentation/admin-guide/kernel-parameters.txt
> +++ b/Documentation/admin-guide/kernel-parameters.txt
> @@ -2636,6 +2636,10 @@
>  
>  	noclflush	[BUGS=X86] Don't use the CLFLUSH instruction
>  
> +	nocnp		[ARM64]
> +			Disable CNP (Common not Private translations)
> +			even if it is supported by processor.
> +
>  	nodelayacct	[KNL] Disable per-task delay accounting
>  
>  	nodsp		[SH] Disable hardware DSP at boot time.

Do we actually have a use-case for this command line option? I'm not
considering hardware errata as these are handled separately in the
kernel.

-- 
Catalin
