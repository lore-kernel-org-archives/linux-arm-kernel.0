From: davem@davemloft.net (David Miller)
Date: Wed, 17 Feb 2016 10:51:04 -0500 (EST)
Subject: [PATCH] drivers: net: cpsw-phy-sel: add dev_warn() for
 unsupported PHY mode
In-Reply-To: <1455324336-3884-1-git-send-email-drivshin.allworx@gmail.com>
References: <1455324336-3884-1-git-send-email-drivshin.allworx@gmail.com>
Message-ID: <20160217.105104.143723229571677119.davem@davemloft.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: "David Rivshin (Allworx)" <drivshin.allworx@gmail.com>
Date: Fri, 12 Feb 2016 19:45:36 -0500

> From: David Rivshin <drivshin@allworx.com>
> 
> The cpsw-phy-sel driver supports only MII, RMII, and RGMII PHY modes,
> and silently handled any other values as if MII was specified. In a
> case where the PHY mode was incorrectly specified, or a bug elsewhere,
> there would be no indication of a problem. If MII was the correct mode,
> then this will go unnoticed, otherwise the symptom will be a failure
> to transmit/receive data over the RMII/RGMII link.
> 
> Add a dev_warn() to make this condition obvious and provide a
> breadcrumb to follow.
> 
> Cc: Mugunthan V N <mugunthanvnm@ti.com>
> Signed-off-by: David Rivshin <drivshin@allworx.com>

Applied to 'net', thanks.  I don't think I'll queue this up for -stable.

Thanks.
