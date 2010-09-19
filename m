From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Sun, 19 Sep 2010 13:29:20 +0100
Subject: [PATCH] ARM: make app read out process num even not use SMP
In-Reply-To: <1284866536-21431-1-git-send-email-leiwen@marvell.com>
References: <1284866536-21431-1-git-send-email-leiwen@marvell.com>
Message-ID: <20100919122920.GB9098@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, Sep 19, 2010 at 11:22:16AM +0800, Lei Wen wrote:
> Some app like trace-cmd need to know the process number, but not

That'll be "processor number".

> all arm board is enabled with the SMP. Add this fix up to let those
> app works happy.

We have historically never given the "processor: 0" line on uniprocessor
systems - and many other architectures do not provide this line either.

I'd suggest trace-cmd is fixed so that it doesn't assume presence of this
line.
