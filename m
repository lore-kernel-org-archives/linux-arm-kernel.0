From: geoff@infradead.org (Geoff Levand)
Date: Tue, 26 Aug 2014 12:33:13 -0700
Subject: [PATCH 8/9] arm64: Add missing AT() macros to vmlinux.lds.S
In-Reply-To: <20140826160854.GK16482@arm.com>
References: <cover.1408736066.git.geoff@infradead.org>
 <2f23e828983b41b1b3844da028f698272b04e83c.1408736066.git.geoff@infradead.org>
 <20140826160854.GK16482@arm.com>
Message-ID: <1409081593.11425.36.camel@smoke>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Catalin,

On Tue, 2014-08-26 at 17:08 +0100, Catalin Marinas wrote:
> On Fri, Aug 22, 2014 at 08:49:17PM +0100, Geoff Levand wrote:
> > The existing arm64 linker script uses some pre-defined section macros from
> > vmlinux.lds.h, all of which include a section load address attribute of
> > 'AT(ADDR(section) - LOAD_OFFSET)'.  LOAD_OFFSET is not defined for arm64, and
> > defaults to zero, so this mix of section attributions has no ill effect.
> > 
> > For consistency and to clear the way for a possible definition of LOAD_OFFSET
> > add any missing AT() macros to vmlinux.lds.S.
> 
> So, what's the possible definition for LOAD_OFFSET on arm64?

Well, this is just intended as a cleanup for vmlinux.lds.S, but I think
a LOAD_OFFSET definition may be needed for kdump.

Takahiro, could you comment?

-Geoff
