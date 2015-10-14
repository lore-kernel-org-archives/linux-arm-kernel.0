From: alison.wang@freescale.com (Huan Wang)
Date: Wed, 14 Oct 2015 10:18:47 +0000
Subject: [PATCH v4] ARM: configs: Add Freescale LS1021A defconfig
In-Reply-To: <16038044.0DCMVgq8H3@wuerfel>
References: <1442480614-32345-1-git-send-email-b18965@freescale.com>
 <CAOMZO5BUvq3LydjL7cR2hAWFFUB+Cvwi+yEN5A9uG=uWEDepiA@mail.gmail.com>
 <BN3PR0301MB0867F84A6740335770B16977FE430@BN3PR0301MB0867.namprd03.prod.outlook.com>
 <16038044.0DCMVgq8H3@wuerfel>
Message-ID: <BN3PR0301MB086733D602580A5A9EBF150EFE3F0@BN3PR0301MB0867.namprd03.prod.outlook.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

> On Thursday 24 September 2015 07:27:10 Huan Wang wrote:
> > > On Fri, Sep 18, 2015 at 4:38 AM, Huan Wang
> > > <alison.wang@freescale.com>
> > > wrote:
> > >
> > > > [Alison Wang] Thanks for your reply. I agreed with you about
> > > > creating a new multi_v7_lpae_defconfig. In
> > > > multi_v7_lpae_defconfig, I need to add the following CONFIG_XX to
> > > > support LS1021A based on
> > > multi_v7_defconfig.
> > > >
> > > > CONFIG_ARM_LPAE=y
> > > > CONFIG_VMSPLIT_2G=y
> > >
> > > Is CONFIG_VMSPLIT_2G=y really needed?
> > [Alison Wang] I tried to remove CONFIG_VMSPLIT_2G and used the default
> > CONFIG_VMSPLIT_3G, but kernel could not boot up. It hangs at " Starting
> kernel ... ".
> >
> > Any suggestion? Thanks.
> 
> Try enabling DEBUG_LL for your platform to get some debug output, if  you
> still don't get any helpful messages, try also inserting
> 
> 	printascii(__func__);
> 
> statements in the early boot process to see how far you get before the hang.
> 
[Alison Wang] I can get to __turn_mmu_on or later, but I could not get the print
message "Booting Linux on physical CPU 0xf00" in smp_setup_processor_id().

I guess something wrong with the initial page tables in __create_page_tables,
as for CONFIG_VMSPLIT_3G, only PAGE_OFFSET is changed from 0x80000000 to 0xC0000000.
BTW, on our platform, TEXT_OFFSET is 0x00008000, PHYS_OFFSET is 0x80000000.

Any suggestion? Thanks.

Best Regards,
Alison Wang
