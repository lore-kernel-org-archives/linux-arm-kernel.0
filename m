From: arnd@arndb.de (Arnd Bergmann)
Date: Wed, 18 Aug 2010 14:28:44 +0200
Subject: [PATCH v2] ARM: uaccess: Implement strict user copy checks
In-Reply-To: <1282094950-6184-1-git-send-email-sboyd@codeaurora.org>
References: <4C61EE55.5030506@codeaurora.org>
	<1282094950-6184-1-git-send-email-sboyd@codeaurora.org>
Message-ID: <201008181428.45029.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wednesday 18 August 2010, Stephen Boyd wrote:
> 
> I'm unsure what needs to be done for the follow up patch. Shouldn't
> it be multiple patches sent to each arch maintainer to fix the
> wording?

No, that will just result in half of them applying it, best make 
a single patch and send it to linux-arch at vger.kernel.org for review.

It's probably best to move the config option to lib/Kconfig.debug
so it only appears once, and make it depend on DEBUG_USER_COPY_CHECKS,
which is then unconditionally defined by the architectures that want it.

	Arnd
