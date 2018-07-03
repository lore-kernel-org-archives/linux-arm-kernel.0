From: olof@lixom.net (Olof Johansson)
Date: Tue, 3 Jul 2018 10:51:36 -0700
Subject: [PATCH] ARM: disable KCOV for trusted foundations code
In-Reply-To: <20180529103636.1535457-1-arnd@arndb.de>
References: <20180529103636.1535457-1-arnd@arndb.de>
Message-ID: <20180703175136.vfx2nap7dsv5zen5@localhost>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, May 29, 2018 at 12:36:26PM +0200, Arnd Bergmann wrote:
> The ARM trusted foundations code is currently broken in linux-next
> when CONFIG_KCOV_INSTRUMENT_ALL is set:
> 
> /tmp/ccHdQsCI.s: Assembler messages:
> /tmp/ccHdQsCI.s:37: Error: .err encountered
> /tmp/ccHdQsCI.s:38: Error: .err encountered
> /tmp/ccHdQsCI.s:39: Error: .err encountered
> scripts/Makefile.build:311: recipe for target 'arch/arm/firmware/trusted_foundations.o' failed
> 
> I could not find a function attribute that lets me disable
> -fsanitize-coverage=trace-pc for just one function, so this
> turns it off for the entire file instead.
> 
> Fixes: mmotm ("arm: port KCOV to arm")
> Cc: Dmitry Vyukov <dvyukov@google.com>
> Cc: Mark Rutland <mark.rutland@arm.com>
> Cc: Andrew Morton <akpm@linux-foundation.org>
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>

Applied to arm-soc fixes branch for v4.18.


-Olof
