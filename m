From: shawnguo@kernel.org (Shawn Guo)
Date: Mon, 23 Nov 2015 13:13:18 +0800
Subject: [PATCH V2] ARM: imx: add platform irq type setting in gpc
In-Reply-To: <1445337859-19111-1-git-send-email-Anson.Huang@freescale.com>
References: <1445337859-19111-1-git-send-email-Anson.Huang@freescale.com>
Message-ID: <20151123051317.GF13744@tiger>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Oct 20, 2015 at 06:44:19PM +0800, Anson Huang wrote:
> From: Anson Huang <b20788@freescale.com>
> 
> GPC irq domain is a child domain of GIC, now all of platform irqs
> are inside GPC domain, during the module populate, all devices irq
> should have correct type setting in GIC, however, there is no
> .irq_set_type callback setting in GPC, so the irq_set_type will be
> skipped and cause all irqs' type in /proc/interrupt are "edge" which
> mismatch with irq type setting in dtb file. Since GPC has no irq
> type setting, so just tell kernel to use irq_chip_set_type_parent.
> 
> Signed-off-by: Anson Huang <Anson.Huang@freescale.com>

Applied, thanks.
