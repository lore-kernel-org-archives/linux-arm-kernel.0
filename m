From: paul@pwsan.com (Paul Walmsley)
Date: Thu, 25 Oct 2012 20:16:11 +0000 (UTC)
Subject: [PATCH 6/7] watchdog: OMAP: use standard GETBOOTSTATUS interface;
 use platform_data fn ptr
In-Reply-To: <50899DB9.8050308@ti.com>
References: <20121016012448.21844.92339.stgit@dusk.lan>
 <20121016013233.21844.1279.stgit@dusk.lan> <50899DB9.8050308@ti.com>
Message-ID: <alpine.DEB.2.00.1210252015490.21193@utopia.booyaka.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, 25 Oct 2012, Jon Hunter wrote:

> > +		if (!pdata->read_reset_sources)
> > +			return put_user(0, (int __user *)arg);
> 
> In the case of booting with device-tree, pdata could be null and so
> should we check for this too? In other words ...
> 
> +		if (!pdata || !pdata->read_reset_sources)
> +			return put_user(0, (int __user *)arg);

Thanks, good catch, will integrate that fix.


- Paul
