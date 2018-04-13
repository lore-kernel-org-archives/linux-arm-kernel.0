From: robh@kernel.org (Rob Herring)
Date: Fri, 13 Apr 2018 16:16:44 -0500
Subject: [PATCH v2 1/5] clk: Extract OF clock helpers in <linux/of_clk.h>
In-Reply-To: <1523364701-15383-2-git-send-email-geert+renesas@glider.be>
References: <1523364701-15383-1-git-send-email-geert+renesas@glider.be>
 <1523364701-15383-2-git-send-email-geert+renesas@glider.be>
Message-ID: <20180413211644.wd7lrl4phqtshpzp@rob-hp-laptop>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Apr 10, 2018 at 02:51:37PM +0200, Geert Uytterhoeven wrote:
> The use of of_clk_get_parent_{count,name}() and of_clk_init() is not
> limited to clock providers.
> 
> Hence move these helpers into their own header file, so callers that are
> not clock providers no longer have to include <linux/clk-provider.h>.
> 
> Suggested-by: Stephen Boyd <sboyd@kernel.org>
> Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
> ---
> v2:
>   - New.
> 
> I have't added an SPDX-License-Identifier line, as
> <linux/clk-provider.h> also doesn't have one yet.

Should that matter?

> 
> Other candidates to be moved here later?
>   - of_clk_get(),
>   - of_clk_get_by_name(),
>   - of_clk_get_from_provider().
> ---
>  include/linux/clk-provider.h | 14 +-------------
>  include/linux/of_clk.h       | 29 +++++++++++++++++++++++++++++

Please update MAINTAINERS so I am not the maintainer. :)

>  2 files changed, 30 insertions(+), 13 deletions(-)
>  create mode 100644 include/linux/of_clk.h
