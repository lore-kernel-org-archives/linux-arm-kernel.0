From: peter.chen@freescale.com (Peter Chen)
Date: Fri, 8 Mar 2013 16:32:46 +0800
Subject: [PATCH v11 6/9] usb: chipidea: add vbus regulator control
In-Reply-To: <20130308072624.GF21589@arwen.pp.htv.fi>
References: <1362563800-16673-1-git-send-email-peter.chen@freescale.com>
 <1362563800-16673-7-git-send-email-peter.chen@freescale.com>
 <20130306112916.GT28587@arwen.pp.htv.fi>
 <20130307024102.GD20470@nchen-desktop>
 <20130307095248.GL9171@arwen.pp.htv.fi>
 <20130308062757.GB16076@nchen-desktop>
 <20130308072624.GF21589@arwen.pp.htv.fi>
Message-ID: <20130308083245.GB22550@nchen-desktop>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Mar 08, 2013 at 09:26:24AM +0200, Felipe Balbi wrote:
> 
> > Differ with dwc3, chipidea created its platform data at glue layer,
> > and chipidea core owing this data when platform device is created.
> 
> yeah yeah, but that's just because chipidea core doesn't understand DT.
> 
> It should take you no more than a day to teach it about DT, though. Not
> sure what you're complaining about.

I have not complained about it, it is out of scope of this patchset.
This patchset is just adds ID/vbus support for chipidea.
For other enhancements, it needs another patchset. 

> 
> > If we also want get things from DT node, we need to get node from
> > glue layer as this node is NOT belonged to chipidea core's pdev.
> 
> which DT node are you talking about ? you want chipidea core to have
> access to glue's DT node ? Are you insane ?

Please read chipidea code, the chipidea core (pdev & platform data)
is not created by DT, it is created by glue layer.
If we added dts entry like you showed me, we can't get node by
pdev->dev.of_node.

> 
> If you wanna add DT support for chipidea core, you need to come up with
> a compatible that makes sense. It won't be fsl,* because chipidea core
> doesn't belong to fsl.

I know it. 

> 
> > Convert platform data to DT for chipidea core is a big job,
> 
> no it's not.

I need to change all msm and pci board related files.

> 
> yeah, but this patch makes no sense. The right thing (TM) to do is, as I
> have said multiple times before, to teach chipidea core about DT. Please
> stop trying to find excuses for not doing the work you need to do; You
> would've already done it if you had spent so much of everybody's time
> trying to find excuses why not to do it and why Alex should accept your
> broken patches.

First let chipidea core know about DT is out of this patchset.

Second, why you think it is a broken patch, it just follows current
framework. Besides, if you have concerns about DT stuff for chipidea
core, why not mention it when sasche added dr_mode and phy_mode at that time?

> 
> Have you already forgotten how many issues were found in each and every
> version of your patchset ? There's a reason why we're revieweing v11,
> right ?

I just want to limit this patchset to id/vbus enable feature, 
I admit I am less upstream experience, but if new requirements
new features and new bugs always coming, things can't be ended up
easily.


-- 

Best Regards,
Peter Chen
