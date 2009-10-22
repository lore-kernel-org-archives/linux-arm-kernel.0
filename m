From: alex@digriz.org.uk (Alexander Clouter)
Date: Thu, 22 Oct 2009 12:04:36 +0100
Subject: [PATCHv3] [ARM] kirkwood: combine support for openrd
	base/client support
In-Reply-To: <20091022124756.56e89d7a@marrow.netinsight.se>
References: <pbh5r6-os7.ln1@chipmunk.wormnet.eu>
	<20091022124756.56e89d7a@marrow.netinsight.se>
Message-ID: <20091022110436.GF6085@chipmunk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

* Simon Kagstrom <simon.kagstrom@netinsight.net> [2009-10-22 12:47:56+0200]:
>
> On Thu, 22 Oct 2009 09:22:49 +0100 Alexander Clouter <alex@digriz.org.uk> wrote:
> 
> > +static int __init openrd_pci_init(void)
> > +{
> > +	kirkwood_pcie_init();
> 
> I think you should do
> 
> 	if (machine_is_openrd_base() || machine_is_openrd_client())
> 		kirkwood_pcie_init();
> 
> here instead since there might be other boards configured as well where
> this shouldn't be done (e.g., a build with both sheevaplug and the
> OpenRDs).
> 
It's called 'openrd-setup.c' not 'sheevaplug-setup.c' :) The 
SheevaPlug's do not use this at all ('MACHINE_START(SHEEVAPLUG, ...)' is 
not to be seen in there), they already have their own file.  If someone 
wants to merge the SheevaPlug's into here too they can cross that bridge 
themselves.

If people want *me* to flatten sheevaplug-setup.c and my openrd-setup.c 
into a single file I am happy to do so, but someone needs to give me a 
suitable combo name as sheeva/openrd would no longer be right I would 
guess :)

> > diff --git a/arch/arm/mach-kirkwood/openrd_base-setup.c b/arch/arm/mach-kirkwood/openrd_base-setup.c
> 
> Perhaps it's a good idea to rebase this one against Nicolas orion.git tree at
> 
>   http://git.marvell.com/?p=orion.git;a=summary
> 
...erm..I have not rebased but it should apply cleanly though as I just 
run from a clone'd vanilla 2.6 (Linus's tree) and pull in orion.git 
anyway.

I did not think the rebasing was really an issue unless you get hunk 
fails?

Cheers

-- 
Alexander Clouter
.sigmonster says: Phone call for chucky-pooh.
