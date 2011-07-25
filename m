From: linuxram@us.ibm.com (Ram Pai)
Date: Mon, 25 Jul 2011 12:17:47 -0700
Subject: [PATCH 1/6] microblaze: move pci flag functions into asm-generic
In-Reply-To: <20110629095436.154cff94@jbarnes-desktop>
References: <1309366019-24379-1-git-send-email-robherring2@gmail.com>
	<1309366019-24379-2-git-send-email-robherring2@gmail.com>
	<20110629095436.154cff94@jbarnes-desktop>
Message-ID: <20110725191747.GA14274@ram-ThinkPad-T61>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jun 29, 2011 at 09:54:36AM -0700, Jesse Barnes wrote:
> On Wed, 29 Jun 2011 11:46:54 -0500
> Rob Herring <robherring2@gmail.com> wrote:
> 
> > From: Rob Herring <rob.herring@calxeda.com>
> > 
> > Move pci_set_flags, pci_add_flags, and pci_has_flag into
> > asm-generic/pci-bridge.h so other archs can use them.
> 
> Looks like something Ram may be able to re-use when adding resource
> alloc behavior flags for the new bridge realloc code.
> 
Hmm..these functions modify the global pci_flags variable.  If there
were macros that helped check/set/reset for flags in a given variable,
I could use them.

RP
