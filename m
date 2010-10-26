From: fernando.lugo@ti.com (Guzman Lugo, Fernando)
Date: Tue, 26 Oct 2010 10:46:52 -0500
Subject: [PATCH 0/8] staging: tidspbridge - misc fixes
In-Reply-To: <1288103059-notmuch-felipe.contreras@nokia.com>
References: <1288054306-4361-1-git-send-email-x0095840@ti.com>
	<20101026040619.GA8549@suse.de>
	<1288103059-notmuch-felipe.contreras@nokia.com>
Message-ID: <496565EC904933469F292DDA3F1663E602F49E27FD@dlee06.ent.ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

 

> -----Original Message-----
> From: Felipe Contreras [mailto:felipe.contreras at nokia.com] 
> Sent: Tuesday, October 26, 2010 9:44 AM
> To: gregkh at suse.de; Guzman Lugo, Fernando
> Cc: hiroshi.doyu at nokia.com; linux-kernel at vger.kernel.org; 
> andy.shevchenko at gmail.com; linux-omap at vger.kernel.org; 
> linux-arm-kernel at lists.infradead.org
> Subject: Re: [PATCH 0/8] staging: tidspbridge - misc fixes
> 
> gregkh at suse.de wrote:
> > On Mon, Oct 25, 2010 at 07:51:38PM -0500, Fernando Guzman 
> Lugo wrote:
> > > This set of patches fix some issues found in lastest tree.
> > > 
> > > Fernando Guzman Lugo (8):
> > >   staging: tidspbridge - remove req_addr from proc_map
> > >   staging: tidspbridge - add kconfig parameter for DMM size
> > >   staging: tidspbridge - change mmufault tasklet to a workqueue
> > >   staging: tidspbridge - fix timeout in dsp_gpt_wait_overflow
> > >   staging: tidspbridge - use GTP7 for DSP stack dump
> > >   staging: tidspbridge - remove disabling twl when 
> printing DSP stack
> > >   staging: tidspbridge - fix some issues after iommu patches
> > >   staging: tidspbridge - make sync_wait_on_event interruptible
> > 
> > Are any of these really applicable for .37 after .37-rc1?  
> Or can they 
> > wait for .38?

I would like to merge as soon as they can becase most of them
Some fixes, However the patch 2/7 has a dependency on an iommu
Patch and if it is no merged first the compilation will be broken.
So maybe they can be marged as soon as iommu patches are merged.

> 
> As of right now the dspbridge doesn't work, and there's a 
> mess of dependencies to get it working.
> 
>  - omap iommu: linux-omap pull request has already been sent, and
>    there's no target when the omap iommu pull request will be sent...
>    right Hiroshi?
>  - linux-arm: some patches are needed, and it's not clear if they'll
>    make it to .37-rc1, or .37 at all.
> 
> So, no, I don't think these patches should considered as of right now.
> 
> In fact, these affect mostly iommu, and I think until those 
> other dependencies are resolved, we should revert back to a 
> previous point where the driver was actually working.

That looks like double work, having the revert now to merge after. If
Someone needs tidspbridge withouts those patche, they can go back to
A previous commit. The issues will be fixed as soon as the dependencies
Are merged.

Regards,
Fernando.

> 
> What is guideline in staging when a driver is broken like this?
> 
> Cheers.
> 
> --
> Felipe Contreras
> 
