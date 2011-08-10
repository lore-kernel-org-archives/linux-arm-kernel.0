From: tixy@yxit.co.uk (Tixy)
Date: Wed, 10 Aug 2011 12:38:29 +0100
Subject: [RFC PATCH 1/5] ARM: Make cpu_alignment into a global variable
In-Reply-To: <1312971223-28165-2-git-send-email-dave.martin@linaro.org>
References: <1312971223-28165-1-git-send-email-dave.martin@linaro.org>
	<1312971223-28165-2-git-send-email-dave.martin@linaro.org>
Message-ID: <1312976309.7800.27.camel@computer2>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Shouldn't the title of this patch no have 'cpu_architecture' rather than
'cpu_alignment'?

On Wed, 2011-08-10 at 11:13 +0100, Dave Martin wrote:
> @@ -114,6 +115,7 @@ struct cpu_cache_fns cpu_cache __read_mostly;
>  struct outer_cache_fns outer_cache __read_mostly;
>  EXPORT_SYMBOL(outer_cache);
>  #endif
> +int cpu_architecture __read_mostly;

I would have been tempted to initialise the variable to
CPU_ARCH_UNKNOWN, though as this is defined as zero it's a bit moot.

-- 
Tixy
