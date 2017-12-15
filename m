From: acme@kernel.org (Arnaldo Carvalho de Melo)
Date: Fri, 15 Dec 2017 10:57:49 -0300
Subject: [PATCH] perf probe arm64: Fix symbol fixup issues due to ELF type
In-Reply-To: <20171214175242.e30450f17f93ad675d968fa3@arm.com>
References: <20171214175242.e30450f17f93ad675d968fa3@arm.com>
Message-ID: <20171215135749.GH10463@kernel.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Em Thu, Dec 14, 2017 at 05:52:42PM -0600, Kim Phillips escreveu:
> On an arm64 machine running a CONFIG_RANDOMIZE_BASE=y kernel, perf
> kernel symbol resolution fails.  Debugging saw symsrc_init calling the
> default elf__needs_adjust_symbols() where checks for an ET_DYN (3)
> ehdr.e_type failed when they should have succeeded.
> 
> Fix by adopting powerpc version of the weak elf__needs_adjust_symbols()
> function, as done in commit d2332098331f ("perf probe ppc: Fix symbol
> fixup issues due to ELF type").
> 
> Prior to this patch, perf test 1 would fail:

Thanks, applied.

- Arnaldo
