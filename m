From: festevam@gmail.com (Fabio Estevam)
Date: Mon, 15 Oct 2018 11:02:39 -0300
Subject: [PATCH v2 2/4] crypto: mxs-dcp - Add support for dcp clk
In-Reply-To: <fda62f939da082d640a27e506e7a3defac4f123f.1539609921.git.leonard.crestez@nxp.com>
References: <cover.1539609921.git.leonard.crestez@nxp.com>
 <fda62f939da082d640a27e506e7a3defac4f123f.1539609921.git.leonard.crestez@nxp.com>
Message-ID: <CAOMZO5DcBbr7THgCCGtsymYVj_fPFQ9WH7XO5bbQHZLtjOL3Ag@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Oct 15, 2018 at 10:28 AM Leonard Crestez
<leonard.crestez@nxp.com> wrote:

> +       /* DCP clock is optional, only used on some SOCs */
> +       sdcp->dcp_clk = devm_clk_get(dev, "dcp");
> +       if (IS_ERR(sdcp->dcp_clk)) {
> +               if (sdcp->dcp_clk != ERR_PTR(-ENOENT))
> +                       return PTR_ERR(sdcp->dcp_clk);
> +               sdcp->dcp_clk = NULL;
> +       }
> +
> +       ret = clk_prepare(sdcp->dcp_clk);
> +       if (ret)
> +               return ret;
> +       ret = clk_enable(sdcp->dcp_clk);
> +       if (ret)
> +               return ret;

Couldn't you use clk_prepare_enable() instead?
