From: magnus.damm@gmail.com (Magnus Damm)
Date: Mon, 6 Dec 2010 09:57:17 +0900
Subject: [patch 1/3] mmc, sh: Move MMCIF_PROGRESS_* into sh_mmcif.h
In-Reply-To: <20101206001310.658304531@vergenet.net>
References: <20101206001243.949375995@vergenet.net>
	<20101206001310.658304531@vergenet.net>
Message-ID: <AANLkTikdKiNg3Mvz3ycqyqh=thNSWijPURK6HG+fbY-o@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Dec 6, 2010 at 9:12 AM, Simon Horman <horms@verge.net.au> wrote:
> Allow MMCIF_PROGRESS_* to be shared.
>
> Cc: Magnus Damm <magnus.damm@gmail.com>
> Signed-off-by: Simon Horman <horms@verge.net.au>

I'm a bit hesitant to this change. This because the progress really
hasn't anything to do with the MMCIF hardware block. The enum does use
the MMCIF prefix though, so I guess i should be silent. =)

In the future I can imagine that there will be more boards making use
of this feature, and other MMC/SD-capable hardware blocks that want to
support early loading. Perhaps moving the enum into the header like
you suggest is the easiest way forward. Unless there is any easy way
to share the same progress code between MMCIF and say SDHI.

Thanks,

/ magnus
