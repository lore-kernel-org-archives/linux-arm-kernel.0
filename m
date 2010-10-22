From: baruch@tkos.co.il (Baruch Siach)
Date: Fri, 22 Oct 2010 10:01:52 +0200
Subject: [PATCH RESEND] ARM: fix spinlock recursion in adjust_pte()
In-Reply-To: <20101022070847.GJ4772@gw.healthdatacare.com>
References: <20101021164433.GH4772@gw.healthdatacare.com>
	<1287680982-22971-1-git-send-email-mika.westerberg@iki.fi>
	<20101022062825.GH6225@tarshish>
	<20101022063845.GI4772@gw.healthdatacare.com>
	<20101022064205.GI6225@tarshish>
	<20101022070847.GJ4772@gw.healthdatacare.com>
Message-ID: <20101022080152.GJ6225@tarshish>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Mika,

On Fri, Oct 22, 2010 at 10:08:47AM +0300, Mika Westerberg wrote:
> On Fri, Oct 22, 2010 at 08:42:05AM +0200, Baruch Siach wrote:
> > Hi Mika,
> > 
> > On Fri, Oct 22, 2010 at 09:38:45AM +0300, Mika Westerberg wrote:
> > > On Fri, Oct 22, 2010 at 08:28:26AM +0200, Baruch Siach wrote:
> > > [...]
> > > > 
> > > > Do you have any idea when was this bug introduced? Does it affect already 
> > > > release kernels other than .36?
> > > 
> > > I've seen it at least on .35. The locking code itself was introduced
> > > in commit:
> > > 
> > > 56dd47098abe (ARM: make_coherent: fix problems with highpte, part 1)
> > 
> > Which is present on .34-rc1. In this case adding stable at kernel.org to Cc would 
> > be nice.
> 
> Ok, thanks.
> 
> I'm not familiar with the stable rules and it wasn't immediately
> clear from the Documentation/stable_kernel_rules.txt: should I resend
> this patch with added 'Cc:' or is it enough just to add Cc into followup
> mail?

Patch with 'Cc: stable at kernel.org' line in its commit log is automatically 
forwarded to the stable team once this patch hits Linus' tree. Since this 
patch should go through Russell's tree, you can add this line when posting to 
his patch tracker. I guess that adding some info in the commit log on the 
history of this bug should help the stable team in the process.

baruch

-- 
                                                     ~. .~   Tk Open Systems
=}------------------------------------------------ooO--U--Ooo------------{=
   - baruch at tkos.co.il - tel: +972.2.679.5364, http://www.tkos.co.il -
