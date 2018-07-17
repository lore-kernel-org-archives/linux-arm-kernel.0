From: shawnguo@kernel.org (Shawn Guo)
Date: Tue, 17 Jul 2018 14:14:40 +0800
Subject: [PATCH] soc: imx6qp: Use GENPD_FLAG_ALWAYS_ON for PU errata
In-Reply-To: <c00ad2ebf94d105544b328c77fa1edbfe6bbc193.1531475786.git.leonard.crestez@nxp.com>
References: <c00ad2ebf94d105544b328c77fa1edbfe6bbc193.1531475786.git.leonard.crestez@nxp.com>
Message-ID: <20180717061439.GH4576@dragon>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Jul 13, 2018 at 01:01:15PM +0300, Leonard Crestez wrote:
> This is functionally identical but simpler and slightly faster.
> 
> The PU domain is turned on at boot time and never turned off. In the
> current implementation the pm core will repeatedly call power_off when
> the domain is unused and get -EBUSY back. If the domain is marked as
> "always on" instead the pm core won't even attempt to turn it off.
> 
> In theory on 6qp it is safe to turn PU off in suspend, however that is
> best accomplished with a new core flag.
> 
> Signed-off-by: Leonard Crestez <leonard.crestez@nxp.com>

Applied all, thanks.
