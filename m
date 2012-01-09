From: shawn.guo@linaro.org (Shawn Guo)
Date: Mon, 9 Jan 2012 14:47:31 +0800
Subject: [PATCH 4/6] arm/dts: imx6q-sabrelite: add sgtl5000 audio codec
In-Reply-To: <4F0A613F.80509@gmail.com>
References: <1325820343-11875-1-git-send-email-richard.zhao@linaro.org>
 <1325820343-11875-5-git-send-email-richard.zhao@linaro.org>
 <20120108145254.GE20216@S2101-09.ap.freescale.net>
 <20120108205504.GF29065@opensource.wolfsonmicro.com>
 <20120109005603.GA1835@S2101-09.ap.freescale.net>
 <4F0A613F.80509@gmail.com>
Message-ID: <20120109064729.GJ1835@S2101-09.ap.freescale.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, Jan 08, 2012 at 09:38:39PM -0600, Rob Herring wrote:
> On 01/08/2012 06:56 PM, Shawn Guo wrote:
> > diff --git a/include/linux/of.h b/include/linux/of.h
> > index a75a831..c26c20f 100644
> > --- a/include/linux/of.h
> > +++ b/include/linux/of.h
> > @@ -147,7 +147,7 @@ static inline unsigned long of_read_ulong(const __be32 *cell, int size)
> >  /* Default string compare functions, Allow arch asm/prom.h to override */
> >  #if !defined(of_compat_cmp)
> >  #define of_compat_cmp(s1, s2, l)       strcasecmp((s1), (s2))
> > -#define of_prop_cmp(s1, s2)            strcmp((s1), (s2))
> > +#define of_prop_cmp(s1, s2)            strcasecmp((s1), (s2))
> >  #define of_node_cmp(s1, s2)            strcasecmp((s1), (s2))
> >  #endif
> 
> Device-trees are case sensitive,

I do not believe this is true, as of_compat_cmp() and of_node_cmp()
are clearly defined as strcasecmp() above.

> so I don't think we want to go globally
> changing that behavior.
> 
> If you want lower case names, then change the sgtl5000 code to lower
> case names.
> 
I do not have a strong opinion about which is the one we should change
among OF, regulator and sgtl5000.  But I think it's the convention
that we should keep property name in dts all lower case.  I'm actually
even fine with this odd mixing case name, if you tell that it's okay
to override the convention for some cases.

-- 
Regards,
Shawn
