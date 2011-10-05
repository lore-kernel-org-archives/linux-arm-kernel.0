From: paul@pwsan.com (Paul Walmsley)
Date: Wed, 5 Oct 2011 11:42:45 -0600 (MDT)
Subject: [RFC PATCH v2 2/6] TI816X: clock: Add clock data
In-Reply-To: <1314119609-22882-1-git-send-email-hemantp@ti.com>
References: <1314119609-22882-1-git-send-email-hemantp@ti.com>
Message-ID: <alpine.DEB.2.00.1110051139410.4611@utopia.booyaka.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi

On Tue, 23 Aug 2011, Hemant Pedanekar wrote:

> This patch adds data for various clocks present in TI816X.
> 
> Note that this data is not automatically generated and not all clocks are
> covered currently.

just a quick comment on this one, as I look it over.  This patch has some 
whitespace problems.  For example:

> +static struct clk tptc3_ick = {
> +	.name           = "tptc3_ick",
> +	.parent         = &sysclk4_ck,
> +	.ops            = &clkops_omap2_dflt,
> +	.enable_reg	= TI816X_CM_ALWON_TPTC3_CLKCTRL,
> +	.enable_bit	= TI816X_MODULEMODE_SWCTRL,
> +	.clkdm_name	= "alwon_l3_fast_clkdm",
> +	.recalc         = &followparent_recalc,
> +};

The whitespace between the field names and the equal signs should be tabs, 
not spaces.  I realize that this is difficult to see with some editors, 
and that checkpatch.pl does not catch this (maybe it's time to send a 
checkpatch patch).  What I use here is show-wspace.el with emacs.  
show-wspace.pl is available from:

    http://www.emacswiki.org/cgi-bin/wiki/show-wspace.el


- Paul
