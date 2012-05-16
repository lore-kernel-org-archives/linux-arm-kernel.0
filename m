From: richard.zhao@freescale.com (Richard Zhao)
Date: Wed, 16 May 2012 15:18:28 +0800
Subject: [PATCH 5/8] MXS: Add USB PHY driver
In-Reply-To: <20120516050605.GB19137@b20223-02.ap.freescale.net>
References: <1337070219-3630-1-git-send-email-marex@denx.de>
 <1337070219-3630-6-git-send-email-marex@denx.de>
 <20120516033336.GA19137@b20223-02.ap.freescale.net>
 <201205160630.15212.marex@denx.de>
 <20120516050605.GB19137@b20223-02.ap.freescale.net>
Message-ID: <20120516071827.GD19137@b20223-02.ap.freescale.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

> > Thanks for the review, now how should we put these codes of ours together? Will 
> > you integrate my code into yours or shall I do it the other way around?
> either way works for me. but I hope it support imx6 and use DT bindings
> and other things maybe in next branch.
Since, anyway we have to use DT, do you mind if I pick your patch and
add mx28 DT too, and send you for further tuning?

Thanks
Richard
> > 
> > Alas, I'd prefer for the PHY to stay separate in drivers/usb/otg,
> I explained it above.
> > maybe we can 
> > also recycle some my mxs binding code for ci13xxx in some way or another, as it 
> > has MXS specific hacks in it.
> what hack do you mean?
> > I think the ci13xxx binding for the rest of i.MX 
> > (aka mxc) will looks different, won't it? But either way, my mxs/ci13xxx binding 
> > glue will have to wait until we finish negotiating the phy_notify stuff with 
> > Greg.
> Sure. At the same time, we may create new version patch and see response.
> 
> Thanks
> Richard
> > 
> > > Thanks
> > > Richard
> > > 
> > > > +module_exit(mxs_phy_exit);
> > > > +
> > > > +MODULE_ALIAS("platform:mxs-usb-phy");
> > > > +MODULE_AUTHOR("Marek Vasut <marex@denx.de>");
> > > > +MODULE_DESCRIPTION("Freescale i.MX28 USB PHY driver");
> > > > +MODULE_LICENSE("GPL");
> > 
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-usb" in
> the body of a message to majordomo at vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 
