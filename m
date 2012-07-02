From: rnayak@ti.com (Rajendra Nayak)
Date: Mon, 02 Jul 2012 14:15:31 +0530
Subject: [PATCH v2] clk: __clk_set_parent: set uninitialized variable
In-Reply-To: <4FF15EDF.7030806@ti.com>
References: <1341214902-15667-1-git-send-email-mkl@pengutronix.de>
 <4FF15EDF.7030806@ti.com>
Message-ID: <4FF15FAB.9050306@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Monday 02 July 2012 02:12 PM, Rajendra Nayak wrote:
> I started looking at how to avoid this initing
> of i to clk->parents (which is correct for the logic
> used below, but somehow seems error prone if someone
> happens to change the logic without noticing the init
> part)
> This is what I came up with, not tested at all, but
> worth considering if Mike dislikes the idea of initing
> i to clk->parents.

s/clk->parents/clk->num_parents
