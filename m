From: horms@verge.net.au (Simon Horman)
Date: Sun, 20 Dec 2009 12:27:28 +1100
Subject: [PATCH] PCI Domains Support
In-Reply-To: <4B2A2B92.6020809@ms1.techarea.org>
References: <4B28EB0F.3070409@ms1.techarea.org>
	<20091217000620.GC22449@verge.net.au>
	<4B2A2B92.6020809@ms1.techarea.org>
Message-ID: <20091220012728.GD12578@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Dec 17, 2009 at 09:01:06PM +0800, Richard Liu wrote:
> Dear Simon:
> 
> Simon Horman wrote:

[snip]

> >> diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
> >> index 79a3074..33a49ba 100644
> >> --- a/arch/arm/Kconfig
> >> +++ b/arch/arm/Kconfig
> >> @@ -865,6 +865,10 @@ config PCI
> >>        your box. Other bus systems are ISA, EISA, MicroChannel (MCA) or
> >>        VESA. If you have PCI, say Y, otherwise N.
> >>  
> >> +config PCI_DOMAINS
> >> +        def_bool y
> >> +        depends on PCI
> >> +
> >>     
> >
> > The PCI_DOMAINS config variable seems unnecessary to me.
> >   
> ARM is a highly custom platform, just reverse for other platform add
> their code,
> Some platforms might need PCI domains, but some platforms not.

Understood. Do you have any platforms in mind that wouldn't want
PCI domains? I was just thinking that perhaps PCI_DOMAINS could be added
later as needed, reducing noise in the code until the need arises.
But perhaps I'm reading the situation incorrectly.
