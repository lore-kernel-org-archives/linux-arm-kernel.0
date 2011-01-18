From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Tue, 18 Jan 2011 19:35:28 +0000
Subject: [RFC 1/2] AT91: Support SAM9260 and SAM9G20-based boards in
	the same kernel image
In-Reply-To: <20110118185232.GU14798@game.jcrosoft.org>
References: <1295113835-6776-1-git-send-email-albin.tonnerre@free-electrons.com>
	<20110117075738.GI14798@game.jcrosoft.org>
	<20110118070016.GA9605@pc-ran3241>
	<20110118150030.GO14798@game.jcrosoft.org>
	<20110118153241.GE9719@n2100.arm.linux.org.uk>
	<4D35CB56.8070603@xenomai.org>
	<20110118185232.GU14798@game.jcrosoft.org>
Message-ID: <20110118193528.GK16980@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jan 18, 2011 at 07:52:32PM +0100, Jean-Christophe PLAGNIOL-VILLARD wrote:
> we can fix it but the main idea is to allow the sam9/11 to be compiled
> together in the same kernel
> and the rm9200 is not a arm926ejs but a arm920t.

The CPU type really doesn't matter.  We already have had fully working
core support for dynamic CPU selection since well before AT91 ever
appeared, covering ARMv3 to ARMv5, and separately ARMv6 to ARMv7 UP
(*not* SMP - until a set of fixes for that area merged).

The question is whether the code for the SoC bits around the CPU can
be structured to allow it.
