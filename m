From: nsekhar@ti.com (Sekhar Nori)
Date: Mon, 21 Aug 2017 15:10:13 +0530
Subject: [PATCH v2 1/3] i2c: davinci: Preserve return value of devm_clk_get
In-Reply-To: <20170816221715.15027-2-fcooper@ti.com>
References: <20170816221715.15027-1-fcooper@ti.com>
 <20170816221715.15027-2-fcooper@ti.com>
Message-ID: <b822d556-40e1-f9c9-b135-ae9115ce52a5@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thursday 17 August 2017 03:47 AM, Franklin S Cooper Jr wrote:
> The i2c driver can run into driver dependency issues if its loaded
> before a clock driver it depends on. Therefore, EPROBE_DEFER may be
> returned by devm_clk_get and should be returned in probe to allow the
> kernel to reprobe the driver at a later time. This patch allows the error
> value returned by devm_clk_get to be passed through and not overwritten.
> 
> Signed-off-by: Franklin S Cooper Jr <fcooper@ti.com>
> Reviewed-by: Grygorii Strashko <grygorii.strashko@ti.com>

Acked-by: Sekhar Nori <nsekhar@ti.com>

Thanks,
Sekhar
