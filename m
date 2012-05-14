From: shawn.guo@freescale.com (Shawn Guo)
Date: Mon, 14 May 2012 17:43:58 +0800
Subject: [PATCH 2/2] mfd: anatop: permit adata be NULL when access register
In-Reply-To: <4FB0C9D4.2060409@linaro.org>
References: <1336870794-6351-1-git-send-email-richard.zhao@freescale.com>
 <1336870794-6351-2-git-send-email-richard.zhao@freescale.com>
 <20120514035137.GB20367@S2100-06.ap.freescale.net>
 <20120514080835.GB31985@opensource.wolfsonmicro.com>
 <4FB0C9D4.2060409@linaro.org>
Message-ID: <20120514094357.GF20367@S2100-06.ap.freescale.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, May 14, 2012 at 05:01:08PM +0800, Ying-Chun Liu (PaulLiu) wrote:
> I think what the concern is we probably don't want several
> non-continuous memory blocks of misc hardwares.
> If we look into the current registers in anatop, it is really sparse.
> Several regulators are using non-continuous address and the thermals are
> also using different addresses. If the addresses are continuous then we
> don't need the mfd driver.
> 
I do not quite follow that.  The reason we need mfd driver isn't because
we do not want to both regulator and thermal drivers to map and access
the same address on their own which may have synchronization issue?

-- 
Regards,
Shawn
