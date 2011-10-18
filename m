From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Tue, 18 Oct 2011 13:29:39 +0100
Subject: [PATCH] amba: be more careful in runtime_suspend/resume
In-Reply-To: <1318940690-30138-1-git-send-email-linus.walleij@stericsson.com>
References: <1318940690-30138-1-git-send-email-linus.walleij@stericsson.com>
Message-ID: <20111018122939.GO21648@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Oct 18, 2011 at 02:24:50PM +0200, Linus Walleij wrote:
> From: Linus Walleij <linus.walleij@linaro.org>
> 
> This checks that a valid pclk actually was retrieved before
> trying to disable/enable it in the runtime PM hooks on the
> PrimeCell bus.

This isn't necessary - we only enable runtime-pm after the pclk has been
obtained and enabled, and disable runtime-pm before we release the pclk.
So pclk should always be valid here.
