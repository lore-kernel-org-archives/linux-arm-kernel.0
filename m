From: arnd@arndb.de (Arnd Bergmann)
Date: Wed, 02 Dec 2015 16:58:14 +0100
Subject: [PATCH v2] multi_v7_defconfig: Remove CONFIG_SOC_LS1021A
In-Reply-To: <BN3PR0301MB0867E1E1BD7FAE068207AC02FE0E0@BN3PR0301MB0867.namprd03.prod.outlook.com>
References: <1448969745-19743-1-git-send-email-fabio.estevam@freescale.com>
 <2978679.eRosYNosdF@wuerfel>
 <BN3PR0301MB0867E1E1BD7FAE068207AC02FE0E0@BN3PR0301MB0867.namprd03.prod.outlook.com>
Message-ID: <3227508.0XRP5bODaT@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wednesday 02 December 2015 02:12:18 Huan Wang wrote:
> > On Tuesday 01 December 2015 09:35:45 Fabio Estevam wrote:
> > > multi_v7_defconfig is not suitable for booting LS1021 as it needs
> > > LPAE.
> > >
> > > Remove this option.
> > >
> > > Signed-off-by: Fabio Estevam <fabio.estevam@freescale.com>
> > 
> > This needs a better explanation. Why do we need LPAE for this platform?
> > 
> >
> [Alison Wang] Because PCIE, IFC region 2, DRAM2 and other IPs on LS1021A
> are in the 40-bit address space, so we need to enable LPAE to access those
> memory beyond the 4GB limit.
> 
> Let me summarize the current status. I have made multi_v7_lpae_defconfig to
> support LS1021A according to the suggestion from Russell King. Olof Johansson
> said they have discussed it before and they have chosen to just have a
> multi_v7_defconfig. Attached is the discussion. There is not further
> solution about the discussion.
> 
> So now, I suggest to remain LS1021A in multi_v7_defconfig at least.

I think that's fine for the time being. We are still looking for
a good way to deal with LPAE configurations in general.

	Arnd
