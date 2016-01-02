From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Sat, 2 Jan 2016 11:20:12 +0000
Subject: [PATCH v2 08/32] arm: reuse asm-generic/barrier.h
In-Reply-To: <1451572003-2440-9-git-send-email-mst@redhat.com>
References: <1451572003-2440-1-git-send-email-mst@redhat.com>
 <1451572003-2440-9-git-send-email-mst@redhat.com>
Message-ID: <20160102112011.GT8644@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Dec 31, 2015 at 09:06:46PM +0200, Michael S. Tsirkin wrote:
> On arm smp_store_mb, read_barrier_depends, smp_read_barrier_depends,
> smp_store_release, smp_load_acquire, smp_mb__before_atomic and
> smp_mb__after_atomic match the asm-generic variants exactly. Drop the
> local definitions and pull in asm-generic/barrier.h instead.
> 
> This is in preparation to refactoring this code area.
> 
> Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
> Acked-by: Arnd Bergmann <arnd@arndb.de>

Thanks, the asm-generic versions looks identical to me, so this should
result in no code generation difference.

Acked-by: Russell King <rmk+kernel@arm.linux.org.uk>

-- 
RMK's Patch system: http://www.arm.linux.org.uk/developer/patches/
FTTC broadband for 0.8mile line: currently at 9.6Mbps down 400kbps up
according to speedtest.net.
