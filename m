From: jbarnes@virtuousgeek.org (Jesse Barnes)
Date: Mon, 13 Jun 2011 11:54:37 -0700
Subject: [Linaro-mm-sig] [RFC 0/2] ARM: DMA-mapping & IOMMU integration
In-Reply-To: <BANLkTi=C6NKT94Fk6Rq6wmhndVixOqC6mg@mail.gmail.com>
References: <1306308920-8602-1-git-send-email-m.szyprowski@samsung.com>
	<BANLkTi=HtrFETnjk1Zu0v9wqa==r0OALvA@mail.gmail.com>
	<201106131707.49217.arnd@arndb.de>
	<BANLkTikR5AE=-wTWzrSJ0TUaks0_rA3mcg@mail.gmail.com>
	<20110613154033.GA29185@1n450.cable.virginmedia.net>
	<BANLkTikkCV=rWM_Pq6t6EyVRHcWeoMPUqw@mail.gmail.com>
	<BANLkTi=C6NKT94Fk6Rq6wmhndVixOqC6mg@mail.gmail.com>
Message-ID: <20110613115437.62824f2f@jbarnes-desktop>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, 13 Jun 2011 10:55:59 -0700
"Michael K. Edwards" <m.k.edwards@gmail.com> wrote:

> As far as I can tell, there is not yet any way to get real
> cache-bypassing write-combining from userland in a mainline kernel,
> for x86/x86_64 or ARM. 

Well only if things are really broken.  sysfs exposes _wc resource
files to allow userland drivers to map a given PCI BAR using write
combining, if the underlying platform supports it.

Similarly, userland mapping of GEM objects through the GTT are supposed
to be write combined, though I need to verify this (we've had trouble
with it in the past).

-- 
Jesse Barnes, Intel Open Source Technology Center
