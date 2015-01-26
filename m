From: tomi.valkeinen@ti.com (Tomi Valkeinen)
Date: Mon, 26 Jan 2015 14:50:16 +0200
Subject: [PATCH] video: treat signal like timeout as failure
In-Reply-To: <1421731430-13207-1-git-send-email-der.herr@hofr.at>
References: <1421731430-13207-1-git-send-email-der.herr@hofr.at>
Message-ID: <54C63808.5070505@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On 20/01/15 07:23, Nicholas Mc Guire wrote:
> if(!wait_for_completion_interruptible_timeout(...))
> only handles the timeout case - this patch adds handling the
> signal case the same as timeout and cleans up.
> 
> Signed-off-by: Nicholas Mc Guire <der.herr@hofr.at>
> ---
> 
> Only the timeout case was being handled, return of 0 in 
> wait_for_completion_interruptible_timeout, the signal case (-ERESTARTSYS)
> was treated just like the case of successful completion, which is most 
> likely not reasonable.
> 
> Note that exynos_mipi_dsi_wr_data/exynos_mipi_dsi_rd_data return values
> are not checked at the call sites in s6e8ax0.c (cmd_read/cmd_write)!
> 
> This patch simply treats the signal case the same way as the timeout case,
> by releasing locks and returning 0 - which might not be the right thing to
> do - this needs a review by someone knowing the details of this driver.

The code changes look ok to me, but again you have detailed descriptions
above which are not in the patch description. All the above looks like
something that should be in the patch description.

 Tomi


-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 819 bytes
Desc: OpenPGP digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20150126/f242a1a6/attachment.sig>
