From: b.zolnierkie@samsung.com (Bartlomiej Zolnierkiewicz)
Date: Fri, 10 Mar 2017 18:11:50 +0100
Subject: [RESEND PATCH] arm: assabet_defconfig: disable IDE subsystem
In-Reply-To: <a8eab3b1-8867-00dd-08e4-bcece23010a6@cogentembedded.com>
References: <1467991490-24895-1-git-send-email-b.zolnierkie@samsung.com>
 <98031160-f7b4-3cff-043a-1f2ee62c8a01@ti.com>
 <a8eab3b1-8867-00dd-08e4-bcece23010a6@cogentembedded.com>
 <CGME20170310171153epcas5p259bf9353fd1194dd131350fc59c3423a@epcas5p2.samsung.com>
Message-ID: <1717246.ZXLvBCRMKf@amdc3058>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thursday, March 09, 2017 03:24:56 PM Sergei Shtylyov wrote:
> On 03/09/2017 03:20 PM, Sekhar Nori wrote:
> 
> > [...]
> 
> >>> diff --git a/arch/arm/mach-davinci/board-dm644x-evm.c
> >>> b/arch/arm/mach-davinci/board-dm644x-evm.c
> >>> index 023480b75244..60a1f23890cd 100644
> >>> --- a/arch/arm/mach-davinci/board-dm644x-evm.c
> >>> +++ b/arch/arm/mach-davinci/board-dm644x-evm.c
> >>> @@ -744,7 +744,7 @@ static int davinci_phy_fixup(struct phy_device
> >>> *phydev)
> >>>      return 0;
> >>>  }
> >>>
> >>> -#define HAS_ATA        IS_ENABLED(CONFIG_BLK_DEV_PALMCHIP_BK3710)
> >>> +#define HAS_ATA        IS_ENABLED(CONFIG_PATA_BK3710)
> >>
> >>    I think it would be more correct to check for both libata and IDE
> >> drivers here...
> >
> > As I understand, the plan is to remove the IDE driver soon.
> 
>     I'm not sure DaveM would support any removals in drivers/ide/. He has 
> explicitly expressed his will to maintain the IDE driuver forever.

Well, he can always change his opinion. :-)

Especially if the request for removal is for platform specific code only
and it is agreed with the maintainers of the given platform..

Best regards,
--
Bartlomiej Zolnierkiewicz
Samsung R&D Institute Poland
Samsung Electronics
