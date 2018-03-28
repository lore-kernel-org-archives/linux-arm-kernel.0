From: festevam@gmail.com (Fabio Estevam)
Date: Wed, 28 Mar 2018 09:14:55 -0300
Subject: [PATCH] clk: imx7d: Move clks_init_on before any clock operations
In-Reply-To: <1522160607-7104-1-git-send-email-abel.vesa@nxp.com>
References: <1522160607-7104-1-git-send-email-abel.vesa@nxp.com>
Message-ID: <CAOMZO5A=Wg3KtESLchqQcjN6c-CBWF5Ca0nHpwSZfy4Fbd2f1w@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Abel,

On Tue, Mar 27, 2018 at 11:23 AM, Abel Vesa <abel.vesa@nxp.com> wrote:
> From: Dong Aisheng <b29396@freescale.com>
>
> For init on clocks we should move it at the first place in imx7d_clocks_init()
> before any clock operations, else the clock operation may fail in case the clock
> is still not on.

The patch and the commit log does not match.

You are not moving the code block to the "first place" inside
imx7d_clocks_init(), so this is confusing.

Also, why does this need to be done only in the imx7d clock driver?
