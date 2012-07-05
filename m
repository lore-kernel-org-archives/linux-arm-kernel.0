From: pgaikwad@nvidia.com (Prashant Gaikwad)
Date: Thu, 5 Jul 2012 06:27:29 +0530
Subject: [PATCH] clk: fix parent validation in __clk_set_parent()
In-Reply-To: <1341313938-17861-1-git-send-email-rnayak@ti.com>
References: <1341313938-17861-1-git-send-email-rnayak@ti.com>
Message-ID: <4FF4E679.10909@nvidia.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tuesday 03 July 2012 04:42 PM, Rajendra Nayak wrote:
> The below commit introduced a bug in __clk_set_parent()
> which could cause it to *skip* the parent validation
> which makes sure the parent passed to the api is a valid
> one.

Need this fix for Tegra too.

>      commit 7975059db572eb47f0fb272a62afeae272a4b209
>      Author: Rajendra Nayak<rnayak@ti.com>
>      Date:   Wed Jun 6 14:41:31 2012 +0530
>
>          clk: Allow late cache allocation for clk->parents
>
> This was identified by the following compiler warning..
>
>      drivers/clk/clk.c: In function '__clk_set_parent':
>      drivers/clk/clk.c:1083:5: warning: 'i' may be used uninitialized in this function [-Wuninitialized]
>
> .. as reported by Marc Kleine-Budde.
>
> There were various options discussed on how to fix this, one
> being initing 'i' to clk->num_parents, but the below approach
> was found to be more appropriate as it also makes the 'parent
> validation' code simpler to read.
>
> Reported-by: Marc Kleine-Budde<mkl@pengutronix.de>
> Signed-off-by: Rajendra Nayak<rnayak@ti.com>
>
