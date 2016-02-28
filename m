From: shawnguo@kernel.org (Shawn Guo)
Date: Sun, 28 Feb 2016 15:53:33 +0800
Subject: [PATCH v2] ARM: imx: Do L2 errata only if the L2 cache isn't
 enabled
In-Reply-To: <1455864612-12089-1-git-send-email-dirk.behme@de.bosch.com>
References: <1455864612-12089-1-git-send-email-dirk.behme@de.bosch.com>
Message-ID: <20160228075333.GI22051@tiger>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Feb 19, 2016 at 07:50:12AM +0100, Dirk Behme wrote:
> All the generic L2 cache handling code is encapsulated by a
> check if the L2 cache is enabled. If it's enabled already, the code
> is skipped. The write to the L2-Cache controller from non-secure
> world causes an imprecise external abort. This is needed in
> scenarios where one of the cores runs an other OS, e.g. an RTOS.
> 
> For the i.MX6 specific L2 cache handling we missed this check.
> Add it.
> 
> Signed-off-by: Marcel Grosshans <MarcelViktor.Grosshans@de.bosch.com>
> Signed-off-by: Dirk Behme <dirk.behme@de.bosch.com>

Applied, thanks.
