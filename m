From: hvaibhav@ti.com (Hiremath, Vaibhav)
Date: Tue, 9 Apr 2013 18:03:51 +0000
Subject: [GIT PULL] ARM: OMAP5: hwmod, prm/cm data files and updates for
 3.10
In-Reply-To: <20130405171052.GD10155@atomide.com>
References: <1363768852-18125-1-git-send-email-santosh.shilimkar@ti.com>
 <20130401170539.GK10155@atomide.com> <515BA76D.3000302@ti.com>
 <alpine.DEB.2.00.1304031146230.2616@utopia.booyaka.com>
 <515D6020.2030103@ti.com> <20130404165208.GI10155@atomide.com>
 <515DB110.9000503@ti.com> <515F00B8.3000501@ti.com>
 <20130405171052.GD10155@atomide.com>
Message-ID: <79CD15C6BA57404B839C016229A409A83EC49D42@DBDE01.ent.ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


> -----Original Message-----
> From: linux-omap-owner at vger.kernel.org [mailto:linux-omap-
> owner at vger.kernel.org] On Behalf Of Tony Lindgren
> Sent: Friday, April 05, 2013 10:41 PM
> To: Shilimkar, Santosh
> Cc: Paul Walmsley; linux-omap at vger.kernel.org; linux-arm-
> kernel at lists.infradead.org; Kristo, Tero; Menon, Nishanth; Nayak,
> Rajendra; Valentin, Eduardo; Anna, Suman; Bedia, Vaibhav; Hiremath,
> Vaibhav
> Subject: Re: [GIT PULL] ARM: OMAP5: hwmod, prm/cm data files and
> updates for 3.10
> 
> * Santosh Shilimkar <santosh.shilimkar@ti.com> [130405 09:52]:
> > On Thursday 04 April 2013 10:27 PM, Santosh Shilimkar wrote:
> > > On Thursday 04 April 2013 10:22 PM, Tony Lindgren wrote:
> > >> * Santosh Shilimkar <santosh.shilimkar@ti.com> [130404 04:15]:
> > [..]
> >
> > >> Can't we already trim the am33xx hwmod data after your patches for
> > >> v3.10 as am33xx is already DT only? Unfortunately we cannot create
> > >> negative diffstat in other ways for v3.10 merge window as we
> cannot
> > >> make omap4 DT only just quite yet.
> > >>
> > > Yes we can and I can take a stab it tomorrow. The only thing is I
> > > might need some support for testing but thats manageable. Will
> > > take a stab at it tomorrow and if everything goes well, post a
> > > patch for smae.
> > >
> > Patch for the AM33XX to trim is end of the email. Thanks to
> > Sricharan and Pekon for patch and testing. Looping both
> > Vaibhav's if they have any objection on the patch.
> >
> > Regards,
> > Santosh
> >
> > From b95dd33fe59b8e77727eb3b1717d763bbf9a2893 Mon Sep 17 00:00:00
> 2001
> > From: Sricharan R <r.sricharan@ti.com>
> > Date: Fri, 5 Apr 2013 20:39:12 +0530
> > Subject: [PATCH] ARM: AM33XX: hwmod data: Clean up the data file
> >
> > - The IO resource information like dma request lines, irq number and
> > ocp address space can be populated via dt blob. So such data can be
> stripped
> > from SOC hwmod data file.
> >
> > - The devices like adc, mailbox, gpmc which are missing the device
> > tree bindings, hwmod data is not added since AM33XX is DT only build.
> > When such devices add the dt bindings, respective hwmod data can be
> > added along with it.
> >
> > - The hwmod like firewall etc which are not useful are also dropped.
> >
> > This gets us around ~2000 loc of negative diff. Patch is boot tested
> on
> > AM335X EVM.
> 
> Great, that's a nice reduction :) Considering am33xx is DT only, it
> should be safe.. But can the am33xx guys please test and ack it?
> 
I am reviewing the patch-diff and will give my comment as soon as possible.

Thanks,
Vaibhav
