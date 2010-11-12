From: joe@perches.com (Joe Perches)
Date: Thu, 11 Nov 2010 20:22:54 -0800
Subject: [PATCH v4] msm: smd: Reduce driver log chatter
In-Reply-To: <1289516079-24632-1-git-send-email-davidb@codeaurora.org>
References: <1289349036-16941-1-git-send-email-davidb@codeaurora.org>
	<1289516079-24632-1-git-send-email-davidb@codeaurora.org>
Message-ID: <1289535774.6519.54.camel@Joe-Laptop>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, 2010-11-11 at 14:54 -0800, David Brown wrote:
> The MSM smd driver logs numerous messages during startup that are
> useful for debug purposes.  Change some of these to pr_debug() to
> match their purpose, and remove others that aren't really useful.

Hi David.

>  arch/arm/mach-msm/smd.c |   17 +++++++----------
> @@ -725,7 +727,7 @@ int smd_close(smd_channel_t *ch)
>  {
>  	unsigned long flags;
>  
> -	pr_info("smd_close(%p)\n", ch);
> +	pr_debug("smd_close(%p)\n", ch);

Why keep a printk for close without a printk for open?
I suggest removing this one too.
