From: alison.wang@freescale.com (Huan Wang)
Date: Tue, 10 Nov 2015 07:19:07 +0000
Subject: [RFC PATCH] ARM: add v7 LPAE multi-platform defconfig
In-Reply-To: <CAOesGMgvfdMj_GB3w_dvxxPkgBZUpo=kQ+60a89yY__-QT2eBA@mail.gmail.com>
References: <1447124035-18585-1-git-send-email-b18965@freescale.com>
 <CAOesGMgvfdMj_GB3w_dvxxPkgBZUpo=kQ+60a89yY__-QT2eBA@mail.gmail.com>
Message-ID: <BN3PR0301MB08672E0D8AE0DC458290DFF3FE140@BN3PR0301MB0867.namprd03.prod.outlook.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi, Olof,
 
> On Mon, Nov 9, 2015 at 6:53 PM, Alison Wang <b18965@freescale.com> wrote:
> > v7 LPAE multi-platform defconfig is based on v7 multi-platform
> > defconfig and adds LPAE support.
> >
> > The platforms based on Cortex-A7/A12/A15/A17, PJ4B, Krait are also
> > enabled in this defconfig. But Cortex-A5/A8/A9, Scorpion and PJ4 are
> > removed.
> >
> > This defconfig is verified on LS1021A which enables GIANFAR, I2C,
> > WATCHDOG, AUDIO, EDMA and DSPI drivers, etc.
> >
> > The other platforms need to be verified by the platform maintainers
> > too.
> >
> > Signed-off-by: Alison Wang <alison.wang@freescale.com>
> 
> This has been discussed before, and what we have chosen to do is to just
> have a multi_v7_defconfig that all these platforms are enabled on but
> with LPAE off.
> 
> Instead, what we do when building (and on our build/boot builders) is to
> take multi_v7 and provide the snippet that turns on ARM_LPAE at that
> time.
> 
> 
[Alison Wang] Thanks for your reply. I tried to make this multi_v7_lpae_defconfig
according to the discussion with Russell King. He suggested to make a multi_v7_lpae_defconfig
rather than creating a new load of platform specific defconfigs. Attached is his original email.

King, do you have any comment about Olof's reply?


Best Regards,
Alison Wang
-------------- next part --------------
An embedded message was scrubbed...
From: Russell King - ARM Linux <linux@arm.linux.org.uk>
Subject: Re: [PATCH v4] ARM: configs: Add Freescale LS1021A defconfig
Date: Thu, 17 Sep 2015 10:34:14 +0000
Size: 3564
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20151110/3f4d0355/attachment.mht>
