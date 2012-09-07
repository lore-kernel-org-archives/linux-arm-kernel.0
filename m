From: tony@atomide.com (Tony Lindgren)
Date: Fri, 7 Sep 2012 11:03:36 -0700
Subject: [PATCH 5/5] omap-serial: Request pins using pinctrl framework
In-Reply-To: <20120907172809.GB1303@atomide.com>
References: <20120906185615.1172.23588.stgit@muffinssi.local>
 <20120906185832.1172.31013.stgit@muffinssi.local>
 <331ABD5ECB02734CA317220B2BBEABC13EA291F9@DBDE01.ent.ti.com>
 <20120907172809.GB1303@atomide.com>
Message-ID: <20120907180335.GF1303@atomide.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

* Tony Lindgren <tony@atomide.com> [120907 10:29]:
> * AnilKumar, Chimata <anilkumar@ti.com> [120906 20:27]:
> > > @@ -1570,6 +1578,8 @@ static int serial_omap_remove(struct platform_device *dev)
> > >  		pm_runtime_disable(&up->pdev->dev);
> > >  		uart_remove_one_port(&serial_omap_reg, &up->port);
> > >  		pm_qos_remove_request(&up->pm_qos_request);
> > > +		if (up->pins)
> > > +			pinctrl_put(up->pins);
> > 
> > I think this can be removed if we use devm_pinctrl_get_select_default()
> > above.
> 
> Yeah will do, I was initially thinking that would cause issues remuxing
> pins back to safe mode on unload, but we can still do that in
> serial_omap_remove().

Sent now as a separate patch with subject "[PATCH] serial: omap: Request
pins using pinctrl framework".

Regards,

Tony
