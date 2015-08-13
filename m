From: thierry.reding@gmail.com (Thierry Reding)
Date: Thu, 13 Aug 2015 11:07:32 +0200
Subject: [PATCH 2/2] clk: Convert __clk_get_name(hw->clk) to
 clk_hw_get_name(hw)
In-Reply-To: <1439421161-17868-2-git-send-email-sboyd@codeaurora.org>
References: <1439421161-17868-1-git-send-email-sboyd@codeaurora.org>
 <1439421161-17868-2-git-send-email-sboyd@codeaurora.org>
Message-ID: <20150813090731.GC21716@ulmo>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Aug 12, 2015 at 04:12:41PM -0700, Stephen Boyd wrote:
> Use the provider based method to get a clock's name so that we
> can get rid of the clk member in struct clk_hw one day. Mostly
> converted with the following coccinelle script.
> 
> @@
> struct clk_hw *E;
> @@
> 
> -__clk_get_name(E->clk)
> +clk_hw_get_name(E)
> 
[...]
>  drivers/clk/tegra/clk-pll.c          |  8 ++++----

Acked-by: Thierry Reding <treding@nvidia.com>
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 819 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20150813/acb6e08a/attachment.sig>
