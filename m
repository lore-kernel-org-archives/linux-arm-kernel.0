From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Sun, 20 Mar 2011 09:26:29 +0000
Subject: [PATCH] ARM: Merge v6 and v7 DEBUG_LL DCC support
In-Reply-To: <1300416720-16305-1-git-send-email-sboyd@codeaurora.org>
References: <1300416720-16305-1-git-send-email-sboyd@codeaurora.org>
Message-ID: <20110320092629.GB16646@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Mar 17, 2011 at 07:52:00PM -0700, Stephen Boyd wrote:
> The inline assembly differences for v6 vs. v7 are purely
> optimizations. On a v7 processor, an mrc with the pc sets the
> condition codes to the 28-31 bits of the register being read. It
> just so happens that the TX/RX full bits the DCC support code is
> testing for are high enough in the register to be put into the
> condition codes. On a v6 processor, this "feature" isn't
> implemented and thus we have to do the usual read, mask, test
> operations to check for TX/RX full. Thus, we can drop the v7
> implementation and just use the v6 implementation for both.

This patch needs updating for the changes that were in my tree for many
months, and are now in mainline.
