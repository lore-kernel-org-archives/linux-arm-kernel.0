From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Fri, 16 Jul 2010 19:30:28 +0100
Subject: [RFC PATCH] Kconfig: Enable Kconfig fragments to be used for
	defconfig
In-Reply-To: <alpine.LFD.2.00.1007161406120.10598@xanadu.home>
References: <20100713230352.6781.18644.stgit@angua>
	<1279296221.17878.66.camel@e102109-lin.cambridge.arm.com>
	<AANLkTinyFBTKYaryFANYheTuP-biJUws2x01NRNZPb4M@mail.gmail.com>
	<alpine.LFD.2.00.1007161406120.10598@xanadu.home>
Message-ID: <20100716183028.GB26854@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Jul 16, 2010 at 02:19:31PM -0400, Nicolas Pitre wrote:
> For example, if I want CONFIG_MTD_CMDLINE_PARTS=y, the system may be 
> smart enough to notice and automatically enable CONFIG_MTD and 
> CONFIG_MTD_PARTITIONS without having to carry those in the defconfig.

How do you sort out something like this:

config FOO
	bool "Foo"
	depends on (A && B) || C

Do you enable A and B, A, B and C or just C?

Bear in mind that A could be 'X86', 'M68K' or any other arch specific
symbol.

I prefer the warning method because it prompts you to investigate what's
changed and sort out the problem by ensuring that the appropriate symbols
are also selected.  The automatic selection of dependencies method carries
the risk that it'll do the wrong thing with the above scenario.
