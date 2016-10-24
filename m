From: shawnguo@kernel.org (Shawn Guo)
Date: Mon, 24 Oct 2016 15:14:39 +0800
Subject: [PATCH v3 1/2] ARM: imx: gpc: Initialize all power domains
In-Reply-To: <1477138856-31696-1-git-send-email-festevam@gmail.com>
References: <1477138856-31696-1-git-send-email-festevam@gmail.com>
Message-ID: <20161024071436.GY30578@tiger>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, Oct 22, 2016 at 10:20:55AM -0200, Fabio Estevam wrote:
> From: Fabio Estevam <fabio.estevam@nxp.com>
> 
> Since commit 0159ec670763dd ("PM / Domains: Verify the PM domain is present
> when adding a provider") the following regression is observed on imx6:
> 
> imx-gpc: probe of 20dc000.gpc failed with error -22
> 
> The gpc probe fails because of_genpd_add_provider_onecell() now checks
> if all the domains are initialized via pm_genpd_present() function
> and it fails because not all the power domains are initialized.
> 
> In order to fix this error, initialize all the power domains from
> imx_gpc_domains[], not only the imx6q_pu_domain.base one.
> 
> Reported-by: Olof's autobooter <build@lixom.net>
> Signed-off-by: Fabio Estevam <fabio.estevam@nxp.com>

Applied both, thanks.
