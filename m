From: nico@fluxnic.net (Nicolas Pitre)
Date: Mon, 10 Jan 2011 22:19:02 -0500 (EST)
Subject: [RFC] arm: Defer lookup of machine_type and vet of atags to
	setup.c
In-Reply-To: <20110111015409.18291.87166.stgit@localhost6.localdomain6>
References: <20110111015409.18291.87166.stgit@localhost6.localdomain6>
Message-ID: <alpine.LFD.2.00.1101102211370.12076@xanadu.home>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, 10 Jan 2011, Grant Likely wrote:

> Since the debug macros no longer depend on the machine type
> information, both the machine type lookup and the atags vetting can be
> deferred to setup_arch() in setup.c which simplifies the code
> somewhat.
> 
> This patch removes both __machine_type_lookup and __vet_atags() from
> head.S.  The atags vetting is moved to setup_arch().  machine_type
> lookup is already called from setup_machine() in addition to where it
> was called from head.S.

While at it, you could also remove the code for __lookup_machine_type, 
lookup_machine_type and __error_a, replacing that with a C 
implementation living in setup.c instead.  If this code is not called 
from head.S anymore, there is no reason to keep it there any longer.


Nicolas
