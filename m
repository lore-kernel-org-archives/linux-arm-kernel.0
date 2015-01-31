From: tsahee@annapurnalabs.com (Tsahee Zidenberg)
Date: Sat, 31 Jan 2015 22:11:13 +0200
Subject: [PATCH v2 3/5] ARM: Alpine: smp support
In-Reply-To: <20150131104222.GS26493@n2100.arm.linux.org.uk>
References: <54cc931d.9PqMlkwMeqHvUr4h%tsahee@annapurnalabs.com>
 <20150131104222.GS26493@n2100.arm.linux.org.uk>
Message-ID: <CABM=7kke=N64fhUobFEiwjOMV0p1fbShkKS-jaQTW_jzw-rOGQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 31 January 2015 at 12:42, Russell King - ARM Linux
<linux@arm.linux.org.uk> wrote:
>
> On Sat, Jan 31, 2015 at 10:32:29AM +0200, Tsahee Zidenberg wrote:
> > +
> > +     al_sysfabric = syscon_regmap_lookup_by_compatible("al,alpine-sysfabric-service");
> > +
> > +     np = of_find_compatible_node(NULL, NULL, "al,alpine-cpu-resume");
>
> What if "np" is NULL?

Then of_iomap will return NULL, and wakeup_supported will be false.

(Thanks for your review! all other comments will be fixed)
>
> > +     al_cpu_resume_regs = of_iomap(np, 0);
> > +
> > +     wakeup_supported = (!IS_ERR(al_sysfabric)) && al_cpu_resume_regs;
