From: mturquette@ti.com (Turquette, Mike)
Date: Mon, 2 Jul 2012 16:33:01 -0700
Subject: [PATCH v4] clk: Add support for rate table based dividers
In-Reply-To: <1340976992-9316-1-git-send-email-rnayak@ti.com>
References: <1340976992-9316-1-git-send-email-rnayak@ti.com>
Message-ID: <CAJOA=zO27M3YLSpEZRmumRhGHdQQ+Km7_CyP48UtQo6NseTG-w@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Jun 29, 2012 at 6:36 AM, Rajendra Nayak <rnayak@ti.com> wrote:
> Some divider clks do not have any obvious relationship
> between the divider and the value programmed in the
> register. For instance, say a value of 1 could signify divide
> by 6 and a value of 2 could signify divide by 4 etc.
> Also there are dividers where not all values possible
> based on the bitfield width are valid. For instance
> a 3 bit wide bitfield can be used to program a value
> from 0 to 7. However its possible that only 0 to 4
> are valid values.
>
> All these cases need the platform code to pass a simple
> table of divider/value tuple, so the framework knows
> the exact value to be written based on the divider
> calculation and can also do better error checking.
>
> This patch adds support for such rate table based
> dividers and as part of the support adds a new
> registration function 'clk_register_divider_table()'
> and a new macro for static definition
> 'DEFINE_CLK_DIVIDER_TABLE'.
>
> Signed-off-by: Rajendra Nayak <rnayak@ti.com>

Thanks for updating this one.  I've taken it into clk-next.

Regards,
Mike
