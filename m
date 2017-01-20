From: afzal.mohd.ma@gmail.com (Afzal Mohammed)
Date: Fri, 20 Jan 2017 21:50:22 +0530
Subject: [PATCH 2/4] ARM: nommu: dynamic exception base address setting
In-Reply-To: <f47f7a48-12e9-7dd0-324d-b736eead3187@arm.com>
References: <20170118203525.6246-1-afzal.mohd.ma@gmail.com>
 <20170118203807.6467-1-afzal.mohd.ma@gmail.com>
 <f47f7a48-12e9-7dd0-324d-b736eead3187@arm.com>
Message-ID: <20170120162022.GB3865@afzalpc>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On Thu, Jan 19, 2017 at 01:59:09PM +0000, Vladimir Murzin wrote:
> On 18/01/17 20:38, afzal mohammed wrote:

> > +#define ID_PFR1_SE (0x3 << 4)	/* Security extension enable bits */
> 
> This bitfiled is 4 bits wide.

Since only 2 LSb's out of the 4 were enough to detect whether security
extensions were enabled, it was done so. i am going to use your below
suggestion & this would be taken care by that.

> > +	if (security_extensions_enabled()) {
> 
> You can use
> 
>     cpuid_feature_extract(CPUID_EXT_PFR1, 4)
>     
> and add a comment explaining what we are looking for and why.

Yes, that is better, was not aware of this, did saw CPUID_EXT_PFR1 as
an unused macro.

> > +#ifdef CONFIG_CPU_CP15
> > +	vectors_base = setup_vectors_base();
> > +#endif
> 
> alternatively it can be
> 
> 	unsigned long vector_base = IS_ENABLED(CONFIG_CPU_CP15) ? setup_vbar() : 0;

Yes that certainly is better.

Regards
afzal
