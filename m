From: swarren@wwwdotorg.org (Stephen Warren)
Date: Wed, 22 Jan 2014 13:43:56 -0700
Subject: [PATCH 4/5] ARM: trusted_foundations: implement do_idle()
In-Reply-To: <1390299016-14105-5-git-send-email-acourbot@nvidia.com>
References: <1390299016-14105-1-git-send-email-acourbot@nvidia.com>
 <1390299016-14105-5-git-send-email-acourbot@nvidia.com>
Message-ID: <52E02D8C.7090309@wwwdotorg.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 01/21/2014 03:10 AM, Alexandre Courbot wrote:
> Support the do_idle() firmware call, which is necessary to properly
> support cpuidle.

> diff --git a/arch/arm/firmware/trusted_foundations.c b/arch/arm/firmware/trusted_foundations.c

> +#define TF_CPU_PM		 0xfffffffc
> +#define TF_CPU_PM_LP0		 0xffffffe3
> +#define TF_CPU_PM_LP1		 0xffffffe6
> +#define TF_CPU_PM_LP1_NO_MC_CLK	 0xffffffe5
> +#define TF_CPU_PM_LP2		 0xffffffe4
> +#define TF_CPU_PM_LP2_NOFLUSH_L2 0xffffffe7

Hmm. This must be Tegra-specific, not generic to any TF client, since
aren't the names of the suspend states (LP0, LP1, LP2) entirely specific
to Tegra?
