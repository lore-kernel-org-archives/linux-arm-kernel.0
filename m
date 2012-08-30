From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Thu, 30 Aug 2012 01:08:49 +0100
Subject: [PATCH v4 2/3] ARM: omap: hwmod: get rid of all
 omap_clk_get_by_name usage
In-Reply-To: <1346230576-20004-3-git-send-email-rnayak@ti.com>
References: <1346230576-20004-1-git-send-email-rnayak@ti.com>
 <1346230576-20004-3-git-send-email-rnayak@ti.com>
Message-ID: <20120830000849.GD25765@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Aug 29, 2012 at 02:26:15PM +0530, Rajendra Nayak wrote:
> Moving to Common clk framework for OMAP would mean we no longer use
> internal lookup mechanism like omap_clk_get_by_name().
> get rid of all its usage mostly from hwmod and omap_device
> code.
> 
> Also use IS_ERR_OR_NULL() for error checking.

This is wrong.  IS_ERR() is the only check you should ever use with clk_get().
