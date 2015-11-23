From: mingo@kernel.org (Ingo Molnar)
Date: Mon, 23 Nov 2015 09:12:35 +0100
Subject: [PATCH 1/2] arch: consolidate CONFIG_STRICT_DEVM in
 lib/Kconfig.debug
In-Reply-To: <20151122035702.9313.52457.stgit@dwillia2-desk3.jf.intel.com>
References: <20151122035702.9313.52457.stgit@dwillia2-desk3.jf.intel.com>
Message-ID: <20151123081235.GA23661@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


* Dan Williams <dan.j.williams@intel.com> wrote:

> Let all the archs that implement CONFIG_STRICT_DEVM use a common
> definition in lib/Kconfig.debug.

For the x86 bit:

Acked-by: Ingo Molnar <mingo@kernel.org>

> Note, the 'depends on !SPARC' is due to sparc not implementing
> devmem_is_allowed().

Maybe that should be converted into a helper Kconfig switch for architectures to 
opt in to /dev/mem restrictions?

Thanks,

	Ingo
