From: joe@perches.com (Joe Perches)
Date: Tue, 09 Nov 2010 16:56:29 -0800
Subject: [PATCH v2] msm: smd: Reduce driver log chatter
In-Reply-To: <1289350168-20034-1-git-send-email-davidb@codeaurora.org>
References: <1289349036-16941-1-git-send-email-davidb@codeaurora.org>
	<1289350168-20034-1-git-send-email-davidb@codeaurora.org>
Message-ID: <1289350589.28590.74.camel@Joe-Laptop>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, 2010-11-09 at 16:49 -0800, David Brown wrote:
> The MSM smd driver logs numerous messages during startup that are
> useful for debug purposes.  Change these to pr_debug() to match their
> purpose.
> diff --git a/arch/arm/mach-msm/smd.c b/arch/arm/mach-msm/smd.c
[]
> +#define pr_fmt(fmt) KBUILD_MODNAME ": " fmt

If you add this, you probably want to strip
a few prefixes from the formats.

> +
>  #include <linux/platform_device.h>
>  #include <linux/module.h>
>  #include <linux/fs.h>
> @@ -89,7 +91,7 @@ static void smd_diag(void)
[]
> -		pr_info("smem: DIAG '%s'\n", x);
> +		pr_debug("smem: DIAG '%s'\n", x);

probably just
		pr_debug("DIAG '%s'\n", x);

>  	}
>  }
>  
> @@ -312,7 +314,7 @@ static void smd_state_change(struct smd_channel *ch,
[]
> -	pr_info("SMD: ch %d %d -> %d\n", ch->n, last, next);
> +	pr_debug("SMD: ch %d %d -> %d\n", ch->n, last, next);

	pr_debug("ch %d %d -> %d\n", ch->n, last, next);
