From: balbi@ti.com (Felipe Balbi)
Date: Fri, 8 Mar 2013 10:42:35 +0200
Subject: [PATCH v11 6/9] usb: chipidea: add vbus regulator control
In-Reply-To: <20130308083245.GB22550@nchen-desktop>
References: <1362563800-16673-1-git-send-email-peter.chen@freescale.com>
 <1362563800-16673-7-git-send-email-peter.chen@freescale.com>
 <20130306112916.GT28587@arwen.pp.htv.fi>
 <20130307024102.GD20470@nchen-desktop>
 <20130307095248.GL9171@arwen.pp.htv.fi>
 <20130308062757.GB16076@nchen-desktop>
 <20130308072624.GF21589@arwen.pp.htv.fi>
 <20130308083245.GB22550@nchen-desktop>
Message-ID: <20130308084235.GM21589@arwen.pp.htv.fi>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On Fri, Mar 08, 2013 at 04:32:46PM +0800, Peter Chen wrote:
> > > If we also want get things from DT node, we need to get node from
> > > glue layer as this node is NOT belonged to chipidea core's pdev.
> > 
> > which DT node are you talking about ? you want chipidea core to have
> > access to glue's DT node ? Are you insane ?
> 
> Please read chipidea code, the chipidea core (pdev & platform data)
> is not created by DT, it is created by glue layer.

I know that, what I'm arguing is that instead of going through all loops
and hoops as you're doing, make DTS create the pdev.

> > > Convert platform data to DT for chipidea core is a big job,
> > 
> > no it's not.
> 
> I need to change all msm and pci board related files.

that's just life. Or, you could meanwhile use OF_DEV_AUX_DATA()

> > yeah, but this patch makes no sense. The right thing (TM) to do is, as I
> > have said multiple times before, to teach chipidea core about DT. Please
> > stop trying to find excuses for not doing the work you need to do; You
> > would've already done it if you had spent so much of everybody's time
> > trying to find excuses why not to do it and why Alex should accept your
> > broken patches.
> 
> First let chipidea core know about DT is out of this patchset.

not entirely, since you need access to the regulator from chipidea core
and your regulator bindings are all passed via DT.

There's a clear dependency there.

> Second, why you think it is a broken patch, it just follows current
> framework. Besides, if you have concerns about DT stuff for chipidea
> core, why not mention it when sasche added dr_mode and phy_mode at
> that time?

Well, people make mistakes, right ? That was my mistake, but it doesn't
we have to let the mistake proliferate.

-- 
balbi
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20130308/f4ce513d/attachment.sig>
