From: arnd@arndb.de (Arnd Bergmann)
Date: Wed, 09 Dec 2015 16:32:11 +0100
Subject: [PATCH v2 3/9] ARM: hisi: enable Hi3519 soc
In-Reply-To: <56664878.8040805@huawei.com>
References: <1449110565-23590-1-git-send-email-xuejiancheng@huawei.com>
 <56663897.7040901@huawei.com> <56664878.8040805@huawei.com>
Message-ID: <4297924.YW2IR8MmHA@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tuesday 08 December 2015 11:03:20 xuejiancheng wrote:
> >>
> >> I think we should come up with a way to handle this in general for
> >> ARCH_HISI. It's not problem to have a couple of sub-options, but I'd
> >> rather not have one for each SoC because I'm sure that hisilicon has
> >> made dozens or possibly hundreds of ARM based SoCs that belong into
> >> a couple of families.
> > 
> > Agree with you.
> > 
> >>
> >> The individual selection of IP blocks is not that important, because
> >> those tend to just be generic device drivers that we can enable on
> >> any platform using the defconfig files.
> >>
> >> You said that ARCH_HI3519 and HIP04 have an identical system controller,
> >> but it's different for Hi36xx, correct?
> > 
> > No. The system controller of HI3519 is also different from HIP04. Maybe I gave you
> > wrong descriptions. Sorry about that.
> > 
> >>
> >> So maybe we can generalize the HIP04 option to include all chips with
> >> that system controller as they appear to share a common ancestry regardless
> >> of the target market?
> >>
> > 
> > I agree that we generalize some options regardless of the product line and target market.
> > 
> >> The Hi35xx family includes some rather older chips as well based on ARM9
> >> etc, correct? Are they closely related to the new one as well, or do they
> >> just share the name?
> > 
> > Yes. It's correct. They may share some IP blocks. But they may be very different
> > from the new one for the arch code. I also don't think it's a good idea to make
> > them share the same name.
> 
> I will use ARCH_HISI instead of ARCH_HI3519.
> 
> 

Do you mean you want to remove the other options as well?

We should do this consistently at least within the Kconfig file.

	Arnd
