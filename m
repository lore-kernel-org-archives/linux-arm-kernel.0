From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Sun, 25 Jan 2015 15:56:52 +0000
Subject: perf not capturing stack traces
In-Reply-To: <20150124222342.GA26941@saruman.tx.rr.com>
References: <20150123195128.GE26557@saruman.tx.rr.com>
 <20150123205959.GD3073@kernel.org>
 <20150123223745.GJ26557@saruman.tx.rr.com>
 <20150124151204.GF3073@kernel.org>
 <20150124222342.GA26941@saruman.tx.rr.com>
Message-ID: <20150125155651.GB11502@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, Jan 24, 2015 at 04:23:42PM -0600, Felipe Balbi wrote:
> yeah, I'll try a few older kernels, also see if I can reproduce on other
> boards.

Perf works for me with CONFIG_FRAME_POINTER=y, but that's only for kernel
space, and for userspace where the programs have been built for ARM mode
with frame pointers.

The kernel may work without CONFIG_FRAME_POINTER set, but I've never
tested that, and I'd suggest that (given my experience looking at oops
dumps) it's not all that reliable.

Lastly, userspace without frame pointers is pretty much hopeless.

-- 
FTTC broadband for 0.8mile line: currently at 10.5Mbps down 400kbps up
according to speedtest.net.
