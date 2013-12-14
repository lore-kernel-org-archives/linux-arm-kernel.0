From: geoff@infradead.org (Geoff Levand)
Date: Fri, 13 Dec 2013 16:20:02 -0800
Subject: [PATCH 1/5] arm64: Fix __data_loc value
In-Reply-To: <20131213181725.GR22933@arm.com>
References: <cover.1386879684.git.geoff@infradead.org>
 <35a937043d1b3eae1b1ea547efc25f75b5f43f67.1386879684.git.geoff@infradead.org>
 <20131213174647.GJ4360@n2100.arm.linux.org.uk>
 <20131213181725.GR22933@arm.com>
Message-ID: <1386980402.1002.93.camel@smoke>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


Hi Catalin,

On Fri, 2013-12-13 at 18:17 +0000, Catalin Marinas wrote:
> On Fri, Dec 13, 2013 at 05:46:47PM +0000, Russell King - ARM Linux wrote:
> > On Thu, Dec 12, 2013 at 08:39:45PM +0000, Geoff Levand wrote:
> > > The __data_loc variable should be set to the VMA of the data section, not
> > > the LMA.
> > > 
> > > At present LOAD_OFFSET is not set and defaults to zero, so this bug
> > > does not cause any problems.
> > 
> > Why does ARM64 have this in the first place?  __data_loc is used for
> > XIP support on ARM, does ARM64 have XIP support?
> 
> Not a good reason, copy-paste leftover.

I didn't check how __data_loc was used.  I assumed it was of some use
and just did what was needed to suppress a link error in my work.

I'll post a patch that removes it.

-Geoff
