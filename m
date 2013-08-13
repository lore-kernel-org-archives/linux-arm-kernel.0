From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Tue, 13 Aug 2013 13:12:45 +0100
Subject: [PATCH] ARM: signal: sigreturn_codes should be endian neutral
 to work in BE8
In-Reply-To: <1376377931-2262-1-git-send-email-victor.kamensky@linaro.org>
References: <1376377931-2262-1-git-send-email-victor.kamensky@linaro.org>
Message-ID: <20130813121245.GK23006@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Aug 13, 2013 at 12:12:11AM -0700, Victor Kamensky wrote:
> In case of BE8 kernel data is in BE order whereas code stays in LE
> order. sigreturn_codes array initializer need to use macros from
> <asm/opcodes.h> to setup instructions code in endian neutral way.
> 
> Problem was discovered during ltp testing of BE system: all rt_sig*
> tests failed. Tested against the same tests in both BE and LE modes.

It might make more sense to move these into a .S file actually.
