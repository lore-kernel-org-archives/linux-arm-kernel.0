From: alison.wang@freescale.com (Huan Wang)
Date: Wed, 2 Dec 2015 02:12:18 +0000
Subject: [PATCH v2] multi_v7_defconfig: Remove CONFIG_SOC_LS1021A
In-Reply-To: <2978679.eRosYNosdF@wuerfel>
References: <1448969745-19743-1-git-send-email-fabio.estevam@freescale.com>
 <2978679.eRosYNosdF@wuerfel>
Message-ID: <BN3PR0301MB0867E1E1BD7FAE068207AC02FE0E0@BN3PR0301MB0867.namprd03.prod.outlook.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


> On Tuesday 01 December 2015 09:35:45 Fabio Estevam wrote:
> > multi_v7_defconfig is not suitable for booting LS1021 as it needs
> > LPAE.
> >
> > Remove this option.
> >
> > Signed-off-by: Fabio Estevam <fabio.estevam@freescale.com>
> 
> This needs a better explanation. Why do we need LPAE for this platform?
> 
>
[Alison Wang] Because PCIE, IFC region 2, DRAM2 and other IPs on LS1021A
are in the 40-bit address space, so we need to enable LPAE to access those
memory beyond the 4GB limit.

Let me summarize the current status. I have made multi_v7_lpae_defconfig to
support LS1021A according to the suggestion from Russell King. Olof Johansson
said they have discussed it before and they have chosen to just have a
multi_v7_defconfig. Attached is the discussion. There is not further
solution about the discussion.

So now, I suggest to remain LS1021A in multi_v7_defconfig at least.

Best Regards,
Alison Wang
-------------- next part --------------
An embedded message was scrubbed...
From: Huan Wang <alison.wang@freescale.com>
Subject: RE: [RFC PATCH] ARM: add v7 LPAE multi-platform defconfig
Date: Tue, 10 Nov 2015 07:19:00 +0000
Size: 7804
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20151202/63f3598b/attachment.mht>
