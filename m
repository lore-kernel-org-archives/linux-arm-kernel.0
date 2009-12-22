From: horms@verge.net.au (Simon Horman)
Date: Tue, 22 Dec 2009 15:55:47 +1100
Subject: [PATCH] PCI Domains Support
In-Reply-To: <4B2F0EF9.101@ms1.techarea.org>
References: <4B28EB0F.3070409@ms1.techarea.org>
	<20091217000620.GC22449@verge.net.au>
	<4B2A2B92.6020809@ms1.techarea.org>
	<20091220012728.GD12578@verge.net.au>
	<4B2F0EF9.101@ms1.techarea.org>
Message-ID: <20091222045540.GB4411@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Dec 21, 2009 at 02:00:25PM +0800, Richard Liu wrote:
> Simon Horman wrote:
> > On Thu, Dec 17, 2009 at 09:01:06PM +0800, Richard Liu wrote:
> >   
> >> Dear Simon:
> >>
> >> Simon Horman wrote:  
> >>     
> >> ARM is a highly custom platform, just reverse for other platform add
> >> their code,
> >> Some platforms might need PCI domains, but some platforms not.
> >>     
> >
> > Understood. Do you have any platforms in mind that wouldn't want
> > PCI domains? I was just thinking that perhaps PCI_DOMAINS could be added
> > later as needed, reducing noise in the code until the need arises.
> > But perhaps I'm reading the situation incorrectly.
> >   
> Actually, most ARM platforms didn't need PCI domains.
> 
> So, original patch is
> 
> +config PCI_DOMAINS
> +        def_bool y
> +        depends on PCI && ARCH_CXXXXXX
> +
>
> But I removed the "&& ARCH_CXXXXXXX" before I provided the patch.
> Because ARCH_CXXXXXXX is not exist in ARM Linux kernel now (maybe it
> would be committed at someday)

Ok, now I am completely confused. Nothing currently in-tree should
use PCI_DOMAINS, but it defaults to y and nothing switches it to n?

Perhaps the following would be more appropriate:

config PCI_DOMAINS
        bool

And then platforms can "select PCI_DOMAINS" as needed.

> I traced other ARM platforms,
> some platforms like Marvell Orion5x seems has both PCI and PCIe host
> controller,
> Maybe they can use PCI domain to control their PCI/PCIe host controller.
> 
> 
