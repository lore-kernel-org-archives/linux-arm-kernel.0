From: arnd@arndb.de (Arnd Bergmann)
Date: Fri, 26 Feb 2016 21:32:21 +0100
Subject: [PATCH] bsp: add SoC device to brcmstb
In-Reply-To: <56D09B2B.8090805@gmail.com>
References: <1456445947-9079-1-git-send-email-justinpopo6@gmail.com>
 <4679582.DyKPu0pJrQ@wuerfel> <56D09B2B.8090805@gmail.com>
Message-ID: <5174855.MZxnsKaRHh@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Friday 26 February 2016 10:36:27 Florian Fainelli wrote:
> On 26/02/16 05:58, Arnd Bergmann wrote:
> > On Thursday 25 February 2016 16:19:07 Justin Chen wrote:
> >>   */
> >>  void brcmstb_biuctrl_init(void);
> >>  
> >> +/*
> >> + * Helper functions for getting family or product id from the
> >> + * SoC driver.
> >> + */
> >> +u32 brcmstb_get_family_id(void);
> >> +u32 brcmstb_get_product_id(void);
> >> +
> >>  #endif /* __BRCMSTB_SOC_H */
> >> -- 
> > 
> > Please remove the declarations from the header file and make the
> > variable local to this file, to make sure no other driver accidentally
> > accesses them.
> 
> I would remove these two helper functions completely, we do not need
> them right now in an upstream kernel, if we ever need them, we could add
> them back, but we have no use for these two now.

Ok, that sounds even better.

	Arnd
