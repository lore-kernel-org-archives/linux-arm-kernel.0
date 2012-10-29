From: swarren@wwwdotorg.org (Stephen Warren)
Date: Mon, 29 Oct 2012 11:04:10 -0600
Subject: [PATCH 1/2] ARM: tegra: move iomap.h to mach-tegra
In-Reply-To: <1350326249-18405-1-git-send-email-swarren@wwwdotorg.org>
References: <1350326249-18405-1-git-send-email-swarren@wwwdotorg.org>
Message-ID: <508EB70A.9050605@wwwdotorg.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 10/15/2012 12:37 PM, Stephen Warren wrote:
> Nothing outside mach-tegra uses this file, so there's no need for it to
> be in <mach/>.
> 
> Since uncompress.h and debug-macro.S remain in include/mach, they need
> to include "../../iomap.h" becaue of this change. uncompress.h will soon
> be deleted in later multi-platform/single-zImage patches. debug-macro.S
> will need to continue to include this header using an explicit relative
> path, to avoid duplicating the physical->virtual address mapping that
> iomap.h dictates.

I have applied this to Tegra's tree for 3.8.
