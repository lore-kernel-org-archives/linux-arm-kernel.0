From: arnd@arndb.de (Arnd Bergmann)
Date: Wed, 15 May 2013 16:15:39 +0200
Subject: [PATCHv2] arm: mm: Use phys_addr_t properly for ioremap functions
In-Reply-To: <1368560031-19367-1-git-send-email-lauraa@codeaurora.org>
References: <1368560031-19367-1-git-send-email-lauraa@codeaurora.org>
Message-ID: <201305151615.39752.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tuesday 14 May 2013, Laura Abbott wrote:
> Several of the ioremap functions use unsigned long in places
> resulting in truncation if physical addresses greater than
> 4G are passed in. Change the types of the functions and the
> callers accordingly.

Looks good to me. I wonder a bit whether resource_size_t or phys_addr_t
is the right type here, but they are always defined to the same type
these days.

FWIW, x86 and tile use resource_size_t, while a couple of other architectures
use phys_addr_t.

	Arnd
