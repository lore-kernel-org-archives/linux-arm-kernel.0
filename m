From: afzal.mohd.ma@gmail.com (Afzal Mohammed)
Date: Sun, 22 Jan 2017 09:07:45 +0530
Subject: [PATCH 2/4] ARM: nommu: dynamic exception base address setting
In-Reply-To: <20170120162022.GB3865@afzalpc>
References: <20170118203525.6246-1-afzal.mohd.ma@gmail.com>
 <20170118203807.6467-1-afzal.mohd.ma@gmail.com>
 <f47f7a48-12e9-7dd0-324d-b736eead3187@arm.com>
 <20170120162022.GB3865@afzalpc>
Message-ID: <20170122033745.GB13580@afzalpc>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On Fri, Jan 20, 2017 at 09:50:22PM +0530, Afzal Mohammed wrote:
> On Thu, Jan 19, 2017 at 01:59:09PM +0000, Vladimir Murzin wrote:

> > You can use
> > 
> >     cpuid_feature_extract(CPUID_EXT_PFR1, 4)
> >     
> > and add a comment explaining what we are looking for and why.

W.r.t comments, tried to keep it concise, C tokens doing a part of it.

> Yes, that is better, was not aware of this, did saw CPUID_EXT_PFR1 as
> an unused macro.

> > > +#ifdef CONFIG_CPU_CP15
> > > +	vectors_base = setup_vectors_base();
> > > +#endif
> > 
> > alternatively it can be
> > 
> > 	unsigned long vector_base = IS_ENABLED(CONFIG_CPU_CP15) ? setup_vbar() : 0;
> 
> Yes that certainly is better.

Have kept the function name as setup_vector_base() as in addition to
setting up VBAR, V bit also has to be configured by it - so that
function name remains true to it's name.

v2 with changes has been posted.

Regards
afzal
