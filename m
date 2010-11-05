From: linus.walleij@stericsson.com (Linus Walleij)
Date: Fri, 5 Nov 2010 16:22:43 +0100
Subject: [PATCH] ARM: add clean and flush_dcache_all to ARM cache API
In-Reply-To: <20101105150813.GA25109@n2100.arm.linux.org.uk>
References: <1288969307-30948-1-git-send-email-linus.walleij@stericsson.com>
	<20101105150813.GA25109@n2100.arm.linux.org.uk>
Message-ID: <4CD42143.50405@stericsson.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Russell King - ARM Linux wrote:
> On Fri, Nov 05, 2010 at 04:01:47PM +0100, Linus Walleij wrote:
>> This patch adds functions to flush and clean the entire data cache.
>> Since the existing flush/clean range functions take more time to
>> flush/clean the entire data cache, they cannot be used in
>> performance-critical situations:
> 
> This is something that should be decided (as we already do for some
> processors) inside those methods.  There's no need for new methods.

Aha so we should check the size of the buffer in the normal
cache clean_range/flush_range operations and if it exceeds a
certain watermark that we know for this specific arch we
clean/flush all cache instead?

Sounds like it could be done if I get it right.

Yours,
Linus Walleij
