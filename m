From: manjunath.hadli@ti.com (Hadli, Manjunath)
Date: Thu, 15 Dec 2011 11:11:58 +0000
Subject: [PATCH v5 07/11] davinci: dm644x: Replace register base value
 with a defined macro
In-Reply-To: <4EE87C39.8010601@mvista.com>
References: <1323775415-24504-1-git-send-email-manjunath.hadli@ti.com>
 <1323775415-24504-8-git-send-email-manjunath.hadli@ti.com>
 <4EE87C39.8010601@mvista.com>
Message-ID: <E99FAA59F8D8D34D8A118DD37F7C8F750167AD@DBDE01.ent.ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Sergei,
On Wed, Dec 14, 2011 at 16:06:41, Sergei Shtylyov wrote:
> Hello.
> 
> On 13-12-2011 15:23, Manjunath Hadli wrote:
> 
> > Replace hard coded value of vpss register base to a define macro 
> > DM644X_VPSS_REG_BASE for proper readability
> 
> > Signed-off-by: Manjunath Hadli<manjunath.hadli@ti.com>
> > Acked-by: Sekhar Nori<nsekhar@ti.com>
> > ---
> >   arch/arm/mach-davinci/dm644x.c |    8 +++++---
> >   1 files changed, 5 insertions(+), 3 deletions(-)
> 
> > diff --git a/arch/arm/mach-davinci/dm644x.c 
> > b/arch/arm/mach-davinci/dm644x.c index 6b1d473..3802b59 100644
> > --- a/arch/arm/mach-davinci/dm644x.c
> > +++ b/arch/arm/mach-davinci/dm644x.c
> > @@ -594,13 +594,15 @@ static struct platform_device dm644x_asp_device = {
> >   	.resource	= dm644x_asp_resources,
> >   };
> >
> > +#define DM644X_VPSS_REG_BASE	0x01c73400
> > +
> 
>     Why not simply DM644X_VPSS_BASE, like all the other #define's?
There are #defines with _REG also like DAVINCI_DM646X_MCASP0_REG_BASE. But in the spirit of keeping it same for this file, I will change it.

> 
> WBR, Sergei
> 

Thx,
-Manju
