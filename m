From: festevam@gmail.com (Fabio Estevam)
Date: Wed, 19 Aug 2015 17:36:12 -0300
Subject: [GIT PULL 1/3] ARM: imx: soc updates for 4.3
In-Reply-To: <CAOMZO5AL2iFJSpSukcV44Y=JZecRrm0sCRZQgyTM6w8_R6OHqw@mail.gmail.com>
References: <1439311351-5268-1-git-send-email-shawnguo@kernel.org>
 <20150818201416.GA4732@localhost>
 <CAOesGMg_TocMprCDQK69CTLtnyiyf4hn_hEzWoEhdKsXH3OuBw@mail.gmail.com>
 <CAOMZO5AL2iFJSpSukcV44Y=JZecRrm0sCRZQgyTM6w8_R6OHqw@mail.gmail.com>
Message-ID: <CAOMZO5AtmWPLeGDQP+VRLDuxMq6AXXHXjOQxHje1W5sz2bMvYQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Aug 19, 2015 at 3:17 PM, Fabio Estevam <festevam@gmail.com> wrote:

>> Please send an incremental fix (or I can drop this branch if you need
>> more time).
>
> Does this fix it?
>
> --- a/arch/arm/mach-imx/mach-imx6ul.c
> +++ b/arch/arm/mach-imx/mach-imx6ul.c
> @@ -45,7 +45,9 @@ static int ksz8081_phy_fixup(struct phy_device *dev)
>
>  static void __init imx6ul_enet_phy_init(void)
>  {
> -       phy_register_fixup_for_uid(PHY_ID_KSZ8081, 0xffffffff,
> ksz8081_phy_fixup);
> +       if (IS_BUILTIN(CONFIG_PHYLIB))
> +               phy_register_fixup_for_uid(PHY_ID_KSZ8081, 0xffffffff,
> +                                          ksz8081_phy_fixup);
>  }

Yes, just confirmed that this fixes the issue and sent a formal patch.
