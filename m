From: simon.kagstrom@netinsight.net (Simon Kagstrom)
Date: Thu, 22 Oct 2009 12:47:56 +0200
Subject: [PATCHv3] [ARM] kirkwood: combine support for openrd
	base/client support
In-Reply-To: <pbh5r6-os7.ln1@chipmunk.wormnet.eu>
References: <pbh5r6-os7.ln1@chipmunk.wormnet.eu>
Message-ID: <20091022124756.56e89d7a@marrow.netinsight.se>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, 22 Oct 2009 09:22:49 +0100
Alexander Clouter <alex@digriz.org.uk> wrote:

> +static int __init openrd_pci_init(void)
> +{
> +	kirkwood_pcie_init();

I think you should do

	if (machine_is_openrd_base() || machine_is_openrd_client())
		kirkwood_pcie_init();

here instead since there might be other boards configured as well where
this shouldn't be done (e.g., a build with both sheevaplug and the
OpenRDs).

> diff --git a/arch/arm/mach-kirkwood/openrd_base-setup.c b/arch/arm/mach-kirkwood/openrd_base-setup.c

Perhaps it's a good idea to rebase this one against Nicolas orion.git tree at

  http://git.marvell.com/?p=orion.git;a=summary

?

// Simon
