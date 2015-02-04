From: arnd@arndb.de (Arnd Bergmann)
Date: Wed, 04 Feb 2015 14:25:07 +0100
Subject: [PATCH 2/4] rtc: sa1100: convert to run-time register mapping
In-Reply-To: <1423005775-26457-3-git-send-email-robh@kernel.org>
References: <1423005775-26457-1-git-send-email-robh@kernel.org>
 <1423005775-26457-3-git-send-email-robh@kernel.org>
Message-ID: <39285522.vUKlahhjIR@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tuesday 03 February 2015 17:22:53 Rob Herring wrote:
> SA1100 and PXA differ only in register offsets which are currently
> hardcoded in a machine specific header. Some arm64 platforms (PXA1928)
> have this RTC block also.
> 
> Convert the driver to use ioremap and set the register offsets dynamically.
> Since we are touching all the register accesses, convert them all to
> readl/writel.
> 
> Signed-off-by: Rob Herring <robh@kernel.org>
> Cc: Alessandro Zummo <a.zummo@towertech.it>
> Cc: rtc-linux at googlegroups.com

Hmm, I really should have sent out my version of the patch ages ago. :(

Can you have a look at

http://git.kernel.org/cgit/linux/kernel/git/arnd/playground.git/commit/?h=multiplatform-3.19-next&id=4d9727883a363fb839e7d1633599166c0a08d644

to see compare the approaches and see if there is anything I did that you
missed?

	Arnd
