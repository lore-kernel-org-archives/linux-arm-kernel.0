From: alexandre.belloni@free-electrons.com (Alexandre Belloni)
Date: Fri, 26 Sep 2014 16:13:27 +0200
Subject: [PATCHv3 2/7] ARM: at91: introduce basic SAMA5D4 support
In-Reply-To: <1411732023.7866.15.camel@x220>
References: <1410797759-18675-1-git-send-email-alexandre.belloni@free-electrons.com>
 <1410797759-18675-3-git-send-email-alexandre.belloni@free-electrons.com>
 <1411732023.7866.15.camel@x220>
Message-ID: <20140926141326.GB4408@piout.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 26/09/2014 at 13:47:03 +0200, Paul Bolle wrote :
> On Mon, 2014-09-15 at 18:15 +0200, Alexandre Belloni wrote:
> > From: Nicolas Ferre <nicolas.ferre@atmel.com>
> > 
> > Signed-off-by: Nicolas Ferre <nicolas.ferre@atmel.com>
> 
> This landed in next-20140926, as commit 2dc850b62e5b ("ARM: at91:
> introduce basic SAMA5D4 support").
> 
> > diff --git a/arch/arm/Kconfig.debug b/arch/arm/Kconfig.debug
> > index b11ad54f8d17..7b44db208f10 100644
> > --- a/arch/arm/Kconfig.debug
> > +++ b/arch/arm/Kconfig.debug
> > @@ -101,6 +101,10 @@ choice
> >  		bool "Kernel low-level debugging on 9263 and 9g45"
> >  		depends on HAVE_AT91_DBGU1
> >  
> > +	config AT91_DEBUG_LL_DBGU2
> > +		bool "Kernel low-level debugging on sama5d4"
> > +		depends on HAVE_AT91_DBGU2
> > +
> 
> Why is this Kconfig symbol needed? Nothing in next-20140926 uses it. Are
> future users perhaps queued somewhere (say, in commits that didn't
> survive today's rather lively linux-next merges)?
> 

There is no user because it conflicts with the previous one that is
selected by default by the sama5_defconfig. This is for early print and
it means that you can get earlyprintk either for sama5d3 or sama5d4.

My guess is that it will never be included in any defconfig.

-- 
Alexandre Belloni, Free Electrons
Embedded Linux, Kernel and Android engineering
http://free-electrons.com
