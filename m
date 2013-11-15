From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Fri, 15 Nov 2013 12:45:22 +0000
Subject: [PATCH 2/2] ARM: pxa: delete the custom GPIO header
In-Reply-To: <1380183077-27407-1-git-send-email-linus.walleij@linaro.org>
References: <1380183077-27407-1-git-send-email-linus.walleij@linaro.org>
Message-ID: <20131115124522.GA1913@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Sep 26, 2013 at 10:11:17AM +0200, Linus Walleij wrote:
> The PXA sub-architecture appears to have a custom <mach/gpio.h>
> for no reason whatsoever. The file became completely empty
> after Haojian removed the remaining content in
> commit 157d2644cb0c1e71a18baaffca56d2b1d0ebf10f
> "ARM: pxa: change gpio to platform device".
> 
> That commit added these two lines:
> 
> However it seems like deleting the file has no effect
> whatsoever on the kernel compilation.

This has broken pxa25x_udc - it seems that it was using this path to get
hold of mach/hardware.h, and now that it doesn't have that, it gets lots
of build errors.
