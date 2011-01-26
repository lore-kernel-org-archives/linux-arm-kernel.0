From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Wed, 26 Jan 2011 20:45:21 +0000
Subject: kfree in clkdev_drop()
In-Reply-To: <1B26E9BD9AEAAE46A7BDAD7754D0432CDE18D6CB6A@SJEXCHCCR02.corp.ad.broadcom.com>
References: <1B26E9BD9AEAAE46A7BDAD7754D0432CDE18D6CB6A@SJEXCHCCR02.corp.ad.broadcom.com>
Message-ID: <20110126204521.GA15670@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Dec 01, 2010 at 10:50:17AM -0800, Wei Zhong wrote:
> Hi,
> 
> For kernel 2.6.36, clkdev_drop() in arch/arm/common/clkdev.c,
> shouldn't it be
> 
> kfree(container_of(cl, struct clk_lookup_alloc, cl));

It ought to be if the code was to be changed.
