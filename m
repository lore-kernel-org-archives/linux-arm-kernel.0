From: arnd@arndb.de (Arnd Bergmann)
Date: Tue, 25 Jan 2011 11:00:10 +0100
Subject: [PATCH v4 01/19] ARM: Make the argument to virt_to_phys() "const
	volatile"
In-Reply-To: <4D3DD0D8.10905@codeaurora.org>
References: <1295891761-18366-1-git-send-email-catalin.marinas@arm.com>
	<1295891761-18366-2-git-send-email-catalin.marinas@arm.com>
	<4D3DD0D8.10905@codeaurora.org>
Message-ID: <201101251100.11052.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Monday 24 January 2011, Stephen Boyd wrote:
> On 01/24/2011 09:55 AM, Catalin Marinas wrote:
> > Changing the virt_to_phys() argument to "const volatile void *" avoids
> > compiler warnings in some situations where this function is used.
> >
> > Signed-off-by: Catalin Marinas <catalin.marinas@arm.com>
> > Cc: Stephen Boyd <sboyd@codeaurora.org>
> > Cc: Arnd Bergmann <arnd@arndb.de>

Acked-by: Arnd Bergmann <arnd@arndb.de>

> Acked-by: Stephen Boyd <sboyd@codeaurora.org>
> 
> Any chance we can get this one patch into 2.6.38? It fixes a warning for
> MSM.

Stephen, you might want to have a look at why the warning even appears
on MSM. Most uses of 'volatile' are misguided, and there could be an
actual bug in there.

	Arnd
