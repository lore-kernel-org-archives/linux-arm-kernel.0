From: andrew@lunn.ch (Andrew Lunn)
Date: Sat, 15 Feb 2014 15:05:05 +0100
Subject: [PATCH v2 05/23] ARM: Kirkwood: Seperate board-dt from common
 and pcie code.
In-Reply-To: <3017687.o0PD1Sf7lM@wuerfel>
References: <1392459621-24003-1-git-send-email-andrew@lunn.ch>
 <1392459621-24003-6-git-send-email-andrew@lunn.ch>
 <3017687.o0PD1Sf7lM@wuerfel>
Message-ID: <20140215140505.GB26088@lunn.ch>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, Feb 15, 2014 at 02:18:08PM +0100, Arnd Bergmann wrote:
> On Saturday 15 February 2014 11:20:03 Andrew Lunn wrote:
> > +static void __init kirkwood_l2_init(void)
> > +{
> > +#ifdef CONFIG_CACHE_FEROCEON_L2
> > +#ifdef CONFIG_CACHE_FEROCEON_L2_WRITETHROUGH
> > +       writel(readl(L2_CONFIG_REG) | L2_WRITETHROUGH, L2_CONFIG_REG);
> > +       feroceon_l2_init(1);
> > +#else
> > +       writel(readl(L2_CONFIG_REG) & ~L2_WRITETHROUGH, L2_CONFIG_REG);
> > +       feroceon_l2_init(0);
> > +#endif
> > +#endif
> > +}
> 
> I assume this is correct, but I don't understand it. Why is there a
> configuration option for this? Do both write-through and write-back
> work on all machines, or could there be a case where some machine
> actually requires a particular mode? If not, isn't write-back
> normally "better", so you won't actually ever want to set write-through
> mode?

Hi Arnd

The honest answer is, i've no idea. I'm just shuffling code around in
this patch, and not applying my brain as to what this code does....

Maybe JasonG has a better idea of this history of this?

      Andrew
