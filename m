From: davidb@codeaurora.org (David Brown)
Date: Thu, 11 Aug 2011 13:34:16 -0700
Subject: [PATCH] mmc: Use pr_<level>, add and use mmc_<level>
In-Reply-To: <1441985db03ab10b067332f7d4b75b607921441b.1313094012.git.joe@perches.com>
References: <1441985db03ab10b067332f7d4b75b607921441b.1313094012.git.joe@perches.com>
Message-ID: <20110811203416.GA12740@huya.qualcomm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Aug 11, 2011 at 01:21:24PM -0700, Joe Perches wrote:
> Use current logging styles.
> 
> Add an mmc_printk function to reduce overall size
> by centralizing the mmc_hostname use.
> 
> Because pr_fmt(fmt) KBUILD_MODNAME is used,
> some logging prefixes are changed.
> For instance from "SDIO:" to "mmc_core:"
> 
> Add macros for mmc_err, mmc_warn, and mmc_info.
> Convert printks with mmc_hostname to mmc_<level>.
> 
> Whitespace neatening around pr_<level>.
> Convert printk(KERN_DEBUG to pr_debug(
> Convert direct uses of DBG macros to pr_debug.
> Convert direct uses of DBGF to DBG.
> Coalesce long format strings.
> Add a few missing newlines to logging messages.
> 
> $ size drivers/mmc/built-in.o*
>    text	   data	    bss	    dec	    hex	filename
>   92530	   1608	    204	  94342	  17086	drivers/mmc/built-in.o.minimal.new
>   94229	   1608	    204	  96041	  17729	drivers/mmc/built-in.o.minimal.old
>  291831	   5152	  77344	 374327	  5b637	drivers/mmc/built-in.o.allyesconfig.new
>  293616	   5152	  78128	 376896	  5c040	drivers/mmc/built-in.o.allyesconfig.old
> 
> Signed-off-by: Joe Perches <joe@perches.com>
> ---
>  drivers/mmc/host/msm_sdcc.c     |  103 +++++++++----------

Acked-by: David Brown <davidb@codeaurora.org>

-- 
Sent by an employee of the Qualcomm Innovation Center, Inc.
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum.
