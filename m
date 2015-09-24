From: arnd@arndb.de (Arnd Bergmann)
Date: Thu, 24 Sep 2015 09:34:22 +0200
Subject: [PATCH v4] ARM: configs: Add Freescale LS1021A defconfig
In-Reply-To: <BN3PR0301MB0867F84A6740335770B16977FE430@BN3PR0301MB0867.namprd03.prod.outlook.com>
References: <1442480614-32345-1-git-send-email-b18965@freescale.com>
 <CAOMZO5BUvq3LydjL7cR2hAWFFUB+Cvwi+yEN5A9uG=uWEDepiA@mail.gmail.com>
 <BN3PR0301MB0867F84A6740335770B16977FE430@BN3PR0301MB0867.namprd03.prod.outlook.com>
Message-ID: <16038044.0DCMVgq8H3@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thursday 24 September 2015 07:27:10 Huan Wang wrote:
> > On Fri, Sep 18, 2015 at 4:38 AM, Huan Wang <alison.wang@freescale.com>
> > wrote:
> > 
> > > [Alison Wang] Thanks for your reply. I agreed with you about creating
> > > a new multi_v7_lpae_defconfig. In multi_v7_lpae_defconfig, I need to
> > > add the following CONFIG_XX to support LS1021A based on
> > multi_v7_defconfig.
> > >
> > > CONFIG_ARM_LPAE=y
> > > CONFIG_VMSPLIT_2G=y
> > 
> > Is CONFIG_VMSPLIT_2G=y really needed?
> [Alison Wang] I tried to remove CONFIG_VMSPLIT_2G and used the default CONFIG_VMSPLIT_3G,
> but kernel could not boot up. It hangs at " Starting kernel ... ".
> 
> Any suggestion? Thanks.

Try enabling DEBUG_LL for your platform to get some debug output, if  you
still don't get any helpful messages, try also inserting 

	printascii(__func__);

statements in the early boot process to see how far you get before the hang.

	Arnd
