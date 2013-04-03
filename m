From: balbi@ti.com (Felipe Balbi)
Date: Wed, 3 Apr 2013 18:47:04 +0300
Subject: [PATCH v5 1/6] drivers: phy: add generic PHY framework
In-Reply-To: <515C3D94.1060000@ti.com>
References: <1364993634-6378-1-git-send-email-kishon@ti.com>
 <1364993634-6378-2-git-send-email-kishon@ti.com>
 <20130403134102.GC14680@arwen.pp.htv.fi> <515C3A42.4020404@ti.com>
 <20130403142747.GK14680@arwen.pp.htv.fi> <515C3D94.1060000@ti.com>
Message-ID: <20130403154704.GD19093@arwen.pp.htv.fi>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On Wed, Apr 03, 2013 at 08:02:52PM +0530, Kishon Vijay Abraham I wrote:
> >>>>+		ret = -EINVAL;
> >>>>+		goto err0;
> >>>>+	}
> >>>>+
> >>>>+	if (!phy_class)
> >>>>+		phy_core_init();
> >>>
> >>>why don't you setup the class on module_init ? Then this would be a
> >>>terrible error condition here :-)
> >>
> >>This is for the case where the PHY driver gets loaded before the PHY
> >>framework. I could have returned EPROBE_DEFER here instead I thought
> >>will have it this way.
> >
> >looks a bit weird IMO. Is it really possible for PHY to load before ?
> 
> yeah. it actually happened when I tried with beagle and had all the
> modules as built-in. Because twl4030 has subsys_initcall(), it loads
> before PHY framework.

that's a bug in twl4030.

-- 
balbi
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20130403/494c6f11/attachment.sig>
