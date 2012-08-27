From: 21cnbao@gmail.com (Barry Song)
Date: Mon, 27 Aug 2012 09:44:54 +0800
Subject: [PATCH 4/13] i2c: sirf: use clk_prepare_enable and
 clk_disable_unprepare
In-Reply-To: <1345996865-32082-5-git-send-email-Julia.Lawall@lip6.fr>
References: <1345996865-32082-1-git-send-email-Julia.Lawall@lip6.fr>
 <1345996865-32082-5-git-send-email-Julia.Lawall@lip6.fr>
Message-ID: <CAGsJ_4zSsnyJ0sn385g_1OvGXTwXbW-E1P_o7EWtM75+CSxDww@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

2012/8/27 Julia Lawall <Julia.Lawall@lip6.fr>:
> From: Julia Lawall <Julia.Lawall@lip6.fr>
>
> Clk_prepare_enable and clk_disable_unprepare combine clk_prepare and
> clk_enable, and clk_disable and clk_unprepare.  They make the code more
> concise, and ensure that clk_unprepare is called when clk_enable fails.
>
> A simplified version of the semantic patch that introduces calls to these
> functions is as follows: (http://coccinelle.lip6.fr/)
>
> // <smpl>
> @@
> expression e;
> @@
>
> - clk_prepare(e);
> - clk_enable(e);
> + clk_prepare_enable(e);
>
> @@
> expression e;
> @@
>
> - clk_disable(e);
> - clk_unprepare(e);
> + clk_disable_unprepare(e);
> // </smpl>
>
> Signed-off-by: Julia Lawall <Julia.Lawall@lip6.fr>

Acked-by: Barry Song <21cnbao@gmail.com>
