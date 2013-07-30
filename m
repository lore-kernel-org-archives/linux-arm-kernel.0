From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Tue, 30 Jul 2013 23:52:33 +0100
Subject: [PATCH] ARM: allow DEBUG_UNCOMPRESS for omap2plus
In-Reply-To: <1375224558-8170-1-git-send-email-swarren@wwwdotorg.org>
References: <1375224558-8170-1-git-send-email-swarren@wwwdotorg.org>
Message-ID: <20130730225233.GF21614@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jul 30, 2013 at 04:49:18PM -0600, Stephen Warren wrote:
> From: Stephen Warren <swarren@nvidia.com>
> 
> DEBUG_UNCOMPRESS was previously disallowed for omap2plus due to
> omap2plus.S's use of .data, which is not allowed in the decompressor.
> Solve this by placing that data into .text when building the file into
> the decompressor. This relies on .text actually being writable in the
> decompressor, which it is in practice.

Unless you decide to use ZBOOT and flash the zImage.
