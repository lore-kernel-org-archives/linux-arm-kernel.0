From: simon.kagstrom@netinsight.net (Simon Kagstrom)
Date: Fri, 23 Oct 2009 09:31:53 +0200
Subject: [PATCHv3] [ARM] kirkwood: combine support for openrd
	base/client support
In-Reply-To: <20091022110436.GF6085@chipmunk>
References: <pbh5r6-os7.ln1@chipmunk.wormnet.eu>
	<20091022124756.56e89d7a@marrow.netinsight.se>
	<20091022110436.GF6085@chipmunk>
Message-ID: <20091023093153.363e2984@marrow.netinsight.se>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Sorry for being unclear in my comments! (And thanks to Nicolas for
explaining the PCI init issue I raised).

On Thu, 22 Oct 2009 12:04:36 +0100
Alexander Clouter <alex@digriz.org.uk> wrote:

> > > diff --git a/arch/arm/mach-kirkwood/openrd_base-setup.c b/arch/arm/mach-kirkwood/openrd_base-setup.c
> > 
> > Perhaps it's a good idea to rebase this one against Nicolas orion.git tree at
> > 
> >   http://git.marvell.com/?p=orion.git;a=summary
> > 
> ...erm..I have not rebased but it should apply cleanly though as I just 
> run from a clone'd vanilla 2.6 (Linus's tree) and pull in orion.git 
> anyway.

Well, your patch will/should go through Nicolas tree, and I just
noticed that it didn't contain the last patches on orion.git (namely
the PCI init you also added to the combined file).

I haven't tested, but would guess that git won't accept removing a file
which has changes in it - the openrd-base.c you _remove_ don't have the
PCI init.


Anyway, I believe it makes very much sense to merge the two OpenRDs, so
other than these things I'm happy with the patch.

// Simon
