From: mika.westerberg@iki.fi (Mika Westerberg)
Date: Fri, 22 Oct 2010 10:08:47 +0300
Subject: [PATCH RESEND] ARM: fix spinlock recursion in adjust_pte()
In-Reply-To: <20101022064205.GI6225@tarshish>
References: <20101021164433.GH4772@gw.healthdatacare.com>
	<1287680982-22971-1-git-send-email-mika.westerberg@iki.fi>
	<20101022062825.GH6225@tarshish>
	<20101022063845.GI4772@gw.healthdatacare.com>
	<20101022064205.GI6225@tarshish>
Message-ID: <20101022070847.GJ4772@gw.healthdatacare.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Oct 22, 2010 at 08:42:05AM +0200, Baruch Siach wrote:
> Hi Mika,
> 
> On Fri, Oct 22, 2010 at 09:38:45AM +0300, Mika Westerberg wrote:
> > On Fri, Oct 22, 2010 at 08:28:26AM +0200, Baruch Siach wrote:
> > [...]
> > > 
> > > Do you have any idea when was this bug introduced? Does it affect already 
> > > release kernels other than .36?
> > 
> > I've seen it at least on .35. The locking code itself was introduced
> > in commit:
> > 
> > 56dd47098abe (ARM: make_coherent: fix problems with highpte, part 1)
> 
> Which is present on .34-rc1. In this case adding stable at kernel.org to Cc would 
> be nice.

Ok, thanks.

I'm not familiar with the stable rules and it wasn't immediately
clear from the Documentation/stable_kernel_rules.txt: should I resend
this patch with added 'Cc:' or is it enough just to add Cc into followup
mail?

Thanks,
MW
