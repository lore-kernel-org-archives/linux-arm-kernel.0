From: afzal@ti.com (Mohammed, Afzal)
Date: Wed, 13 Jun 2012 06:29:17 +0000
Subject: [PATCH v5 04/14] ARM: OMAP2+: gpmc: minimal driver support
In-Reply-To: <4FD7963A.9000003@ti.com>
References: <cover.1339419492.git.afzal@ti.com>
 <54e643eb1b4dbefcbb52580fa582043bf4f0da3d.1339419492.git.afzal@ti.com>
 <4FD7963A.9000003@ti.com>
Message-ID: <C8443D0743D26F4388EA172BF4E2A7A93E9988BA@DBDE01.ent.ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Jon,

On Wed, Jun 13, 2012 at 00:49:22, Hunter, Jon wrote:
> On 06/11/2012 09:26 AM, Afzal Mohammed wrote:

> >  	clk_enable(gpmc_l3_clk);
> 
> We should be able to get rid of the clk_enable() here and use ...
> 
> 	pm_runtime_enable(&pdev->dev);
> 	pm_runtime_get(&pdev->dev);
> 
> The clk_disable should also be replaced with a pm_runtime_put(). You
> will also need to include pm_runtime.h.

Once driver conversion is in, it would be made rpm capable.

Regards
Afzal
