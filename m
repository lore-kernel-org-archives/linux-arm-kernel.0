From: arnd@arndb.de (Arnd Bergmann)
Date: Sun, 26 Aug 2012 04:49:32 +0000
Subject: [PATCH v2 21/31] arm64: 32-bit (compat) applications support
In-Reply-To: <20120824104338.GI7585@arm.com>
References: <1344966752-16102-1-git-send-email-catalin.marinas@arm.com>
 <201208151434.05145.arnd@arndb.de> <20120824104338.GI7585@arm.com>
Message-ID: <201208260449.32807.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Friday 24 August 2012, Catalin Marinas wrote:
> > What good is the run-time BUG() here? Nothing should be calling these
> > when CONFIG_COMPAT is disabled, so I think you should just remove
> > the #ifdef around the declarations, and the entire #else case.
> 
> They are called from handle_signal(), so that's to avoid #ifdef inside
> functions. I can drop the BUG() (but keep the empty function) and
> change the checks to is_compat_task() so that the compiler optimises the
> condition out when !COMPAT.
> 

Sounds good. Note that you can turn a lot of #ifdef into
if(IS_ENABLED(CONFIG_FOO)) as well, even if there is no other runtime
check for them.

	Arnd
