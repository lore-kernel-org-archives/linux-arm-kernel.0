From: ezequiel.garcia@free-electrons.com (Ezequiel Garcia)
Date: Sun, 26 Jan 2014 10:18:56 -0300
Subject: [PATCH v4 08/18] watchdog: orion: Make RSTOUT register a
 separate resource
In-Reply-To: <20140126091753.2910a39f@skate>
References: <1390431915-5115-1-git-send-email-ezequiel.garcia@free-electrons.com>
 <1390431915-5115-9-git-send-email-ezequiel.garcia@free-electrons.com>
 <20140126091753.2910a39f@skate>
Message-ID: <20140126131855.GB14713@localhost>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, Jan 26, 2014 at 09:17:53AM +0100, Thomas Petazzoni wrote:
[..]
> > +/*
> > + * The original devicetree binding for this driver specified only
> > + * one memory resource, so in order to keep DT backwards compatibility
> > + * we try to fallback to a hardcoded register address, if the resource
> > + * is missing from the devicetree.
> > + */
> > +static void __iomem *try_rstout_ioremap(struct platform_device *pdev,
> > +					phys_addr_t internal_regs)
> 
> Why is it called "try" ? It actually does the mapping. So I would
> prefer the function to be named:
> 
> 	orion_wdt_ioremap_rstout()
> 

Ah, yes. This is a left over from the previous attempt.
-- 
Ezequiel Garc?a, Free Electrons
Embedded Linux, Kernel and Android Engineering
http://free-electrons.com
