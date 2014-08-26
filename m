From: catalin.marinas@arm.com (Catalin Marinas)
Date: Tue, 26 Aug 2014 17:08:54 +0100
Subject: [PATCH 8/9] arm64: Add missing AT() macros to vmlinux.lds.S
In-Reply-To: <2f23e828983b41b1b3844da028f698272b04e83c.1408736066.git.geoff@infradead.org>
References: <cover.1408736066.git.geoff@infradead.org>
 <2f23e828983b41b1b3844da028f698272b04e83c.1408736066.git.geoff@infradead.org>
Message-ID: <20140826160854.GK16482@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Aug 22, 2014 at 08:49:17PM +0100, Geoff Levand wrote:
> The existing arm64 linker script uses some pre-defined section macros from
> vmlinux.lds.h, all of which include a section load address attribute of
> 'AT(ADDR(section) - LOAD_OFFSET)'.  LOAD_OFFSET is not defined for arm64, and
> defaults to zero, so this mix of section attributions has no ill effect.
> 
> For consistency and to clear the way for a possible definition of LOAD_OFFSET
> add any missing AT() macros to vmlinux.lds.S.

So, what's the possible definition for LOAD_OFFSET on arm64?

-- 
Catalin
