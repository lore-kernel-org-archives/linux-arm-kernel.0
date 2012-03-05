From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Mon, 5 Mar 2012 17:37:39 +0000
Subject: [PATCH] ARM: move mem_type's real definition to asm/mach/map.h
In-Reply-To: <1331010436-31576-1-git-send-email-shijie8@gmail.com>
References: <1331010436-31576-1-git-send-email-shijie8@gmail.com>
Message-ID: <20120305173739.GA17370@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Mar 06, 2012 at 12:07:16AM -0500, Huang Shijie wrote:
> If we use the mem_type in the driver. We will meet the compiler error:
> "error: dereferencing pointer to incomplete type"

That's a hint - you're not supposed to be using anything within this
type.  That's why it's *not* in map.h and its private to arch/arm/mm.
