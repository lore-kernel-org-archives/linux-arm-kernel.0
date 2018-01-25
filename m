From: dongas86@gmail.com (Dong Aisheng)
Date: Thu, 25 Jan 2018 18:29:41 +0800
Subject: [PATCH 1/2] soc: imx: gpc: ARM power domain should be always-on
In-Reply-To: <1516725734-32745-1-git-send-email-Anson.Huang@nxp.com>
References: <1516725734-32745-1-git-send-email-Anson.Huang@nxp.com>
Message-ID: <20180125102941.GA24622@b29396-OptiPlex-7040>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jan 24, 2018 at 12:42:13AM +0800, Anson Huang wrote:
> ARM power domain does NOT support runtime off, always-on
> flag should be set to avoid incorrect power state in
> pm_genpd_summary:
> 
> Before:
> 
> root at imx6qpdlsolox:~# cat /sys/kernel/debug/pm_genpd/pm_genpd_summary
> domain                          status          slaves
>     /device                                             runtime status
> ----------------------------------------------------------------------
> ARM                             off-0
> 
> After:
> 
> root at imx6qpdlsolox:~# cat /sys/kernel/debug/pm_genpd/pm_genpd_summary
> domain                          status          slaves
>     /device                                             runtime status
> ----------------------------------------------------------------------
> ARM                             on
> 
> Signed-off-by: Anson Huang <Anson.Huang@nxp.com>

Acked-by: Dong Aisheng <aisheng.dong@nxp.com>

Regards
Dong Aisheng
