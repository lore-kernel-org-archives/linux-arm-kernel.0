From: festevam@gmail.com (Fabio Estevam)
Date: Sat, 10 Feb 2018 14:24:09 -0200
Subject: [PATCH] soc: imx: gpc: de-register power domains only if
 initialized
In-Reply-To: <20180107134905.15624-1-stefan@agner.ch>
References: <20180107134905.15624-1-stefan@agner.ch>
Message-ID: <CAOMZO5Bmokay7E6mf8j53HXppT74LOMu_nCd=TwBzha1XH0k-w@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, Jan 7, 2018 at 11:49 AM, Stefan Agner <stefan@agner.ch> wrote:
> If power domain information are missing in the device tree, no
> power domains get initialized. However, imx_gpc_remove tries to
> remove power domains always in the old DT binding case. Only
> remove power domains when imx_gpc_probe initialized them in
> first place.
>
> Fixes: 721cabf6c660 ("soc: imx: move PGC handling to a new GPC driver")
> Cc: Lucas Stach <l.stach@pengutronix.de>
> Signed-off-by: Stefan Agner <stefan@agner.ch>

Reviewed-by: Fabio Estevam <fabio.estevam@nxp.com>
