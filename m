From: balbi@ti.com (Felipe Balbi)
Date: Thu, 4 Apr 2013 10:15:34 +0300
Subject: [PATCH v5 1/6] drivers: phy: add generic PHY framework
In-Reply-To: <515CC123.4060402@wwwdotorg.org>
References: <1364993634-6378-1-git-send-email-kishon@ti.com>
 <1364993634-6378-2-git-send-email-kishon@ti.com>
 <515CC123.4060402@wwwdotorg.org>
Message-ID: <20130404071534.GC30287@arwen.pp.htv.fi>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On Wed, Apr 03, 2013 at 05:54:11PM -0600, Stephen Warren wrote:
> struct phy {
> 	struct device *dev;
> 	struct module *owner;
> 	int	(*init)(struct phy *phy);
> 	int	(*exit)(struct phy *phy);
> 	int	(*suspend)(struct phy *phy);
> 	int	(*resume)(struct phy *phy);

I wonder whether it makes sense to provide ->suspend/->resume callbacks
here. We already have dev_pm_ops providing those methods and we can just
wrap pm_runtime_* calls to be called by consumers.

-- 
balbi
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20130404/c71b8872/attachment.sig>
