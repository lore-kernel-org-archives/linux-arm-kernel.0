From: alexandre.belloni@free-electrons.com (Alexandre Belloni)
Date: Wed, 4 Mar 2015 18:15:05 +0100
Subject: [PATCH 5/6] ARM: at91: remove SoC headers
In-Reply-To: <8819576.zV70Ce3SCo@wuerfel>
References: <1425480446-31711-1-git-send-email-alexandre.belloni@free-electrons.com>
 <1425480446-31711-6-git-send-email-alexandre.belloni@free-electrons.com>
 <8819576.zV70Ce3SCo@wuerfel>
Message-ID: <20150304171505.GH3989@piout.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 04/03/2015 at 18:03:45 +0100, Arnd Bergmann wrote :
> On Wednesday 04 March 2015 15:47:25 Alexandre Belloni wrote:
> > @@ -21,6 +21,14 @@
> >  #include "generic.h"
> >  #include "soc.h"
> >  
> > +#define SAMA5D4_BASE_USART3    0xfc00c000 /* (USART3 non-secure) Base Address */
> > +#define SAMA5D4_BASE_PMC       0xf0018000 /* (PMC) Base Address */
> > +#define SAMA5D4_BASE_MPDDRC    0xf0010000 /* (MPDDRC) Base Address */
> > +#define SAMA5D4_BASE_PIOD      0xfc068000 /* (PIOD) Base Address */
> > +
> > +/* Some other peripherals */
> > +#define SAMA5D4_BASE_SYS2      SAMA5D4_BASE_PIOD
> > 
> 
> Why are these still needed? I would expect that the code using them
> can be removed as well.
> 

Yeah, that is still something I need to investigate. Nicolas told me it
doesn't work without it. My guess is that it has something to do with
secure booting.

-- 
Alexandre Belloni, Free Electrons
Embedded Linux, Kernel and Android engineering
http://free-electrons.com
