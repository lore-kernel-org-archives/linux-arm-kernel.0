From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Tue, 23 Nov 2010 17:33:19 +0000
Subject: [PATCH v2 08/20] ARM: LPAE: MMU setup for the 3-level page
	table format
In-Reply-To: <AANLkTikGVZ5Na0GSG5ynO+YM2M6x65yb3dwJeBZjzFMN@mail.gmail.com>
References: <1289584840-18097-1-git-send-email-catalin.marinas@arm.com>
	<1289584840-18097-9-git-send-email-catalin.marinas@arm.com>
	<20101122131010.GD31227@n2100.arm.linux.org.uk>
	<AANLkTikGVZ5Na0GSG5ynO+YM2M6x65yb3dwJeBZjzFMN@mail.gmail.com>
Message-ID: <20101123173319.GA26510@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Nov 23, 2010 at 11:38:15AM +0000, Catalin Marinas wrote:
> On 22 November 2010 13:10, Russell King - ARM Linux
> <linux@arm.linux.org.uk> wrote:
> > Are you sure these shifts by 18 places are correct? ?They're actually
> > (val >> SECTION_SHIFT) << 2, so maybe they should be (SECTION_SHIFT -
> > PMD_WORDS) ?
> 
> SECTION_SHIFT - PMD_ORDER is (20 - 2) for classic page tables and (21
> - 3) for LPAE. But we could change the 18 to some macros for
> clarification (the line would be long though).

So yes, it's SECTION_SHIFT - PMD_ORDER, which is how they should be
used IMHO.  I don't see why another macro would be necessary.
