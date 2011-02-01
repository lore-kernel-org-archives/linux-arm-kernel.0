From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Tue, 1 Feb 2011 13:03:11 +0000
Subject: [PATCH v2 02/28] ARM: gic: Add functions to save and restore
	gic state
In-Reply-To: <1295834493-5019-3-git-send-email-ccross@android.com>
References: <1295834493-5019-1-git-send-email-ccross@android.com>
	<1295834493-5019-3-git-send-email-ccross@android.com>
Message-ID: <20110201130311.GG31216@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, Jan 23, 2011 at 06:01:07PM -0800, Colin Cross wrote:
> on systems with idle states which power-gate the logic including
> the gic, such as tegra, the gic distributor needs to be shut down
> and restored on entry and exit from the architecture idle code

I'd rather not add this and then have to weed it back out when we have a
proper interface for dealign with idle shutdown stuff.

Can some effort please be put into coming up with a proper interface
such as an idle notifier list rather than calling directly into random
parts of the kernel on idle.
