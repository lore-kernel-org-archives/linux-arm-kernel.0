From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Fri, 5 Nov 2010 15:08:13 +0000
Subject: [PATCH] ARM: add clean and flush_dcache_all to ARM cache API
In-Reply-To: <1288969307-30948-1-git-send-email-linus.walleij@stericsson.com>
References: <1288969307-30948-1-git-send-email-linus.walleij@stericsson.com>
Message-ID: <20101105150813.GA25109@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Nov 05, 2010 at 04:01:47PM +0100, Linus Walleij wrote:
> This patch adds functions to flush and clean the entire data cache.
> Since the existing flush/clean range functions take more time to
> flush/clean the entire data cache, they cannot be used in
> performance-critical situations:

This is something that should be decided (as we already do for some
processors) inside those methods.  There's no need for new methods.
