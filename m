From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Mon, 10 Jun 2013 09:59:48 +0100
Subject: ARM cacheflush syscall with range that spans multiple vma
In-Reply-To: <51B51844.9050108@bitwagon.com>
References: <51B51844.9050108@bitwagon.com>
Message-ID: <20130610085948.GP18614@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, Jun 09, 2013 at 05:05:24PM -0700, John Reiser wrote:
> Why does the ARM cacheflush syscall stop after the lowest vma
> which intersects the user-requested range?  The range could
> span more than one vma having contiguous addresses, such as
> two files MAP_SHARED into adjacent pages; or even a region
> that contains holes (pages not present.)

Because you're not supposed to use it on large ranges because it's
an expensive operation.
