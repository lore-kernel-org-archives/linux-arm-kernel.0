From: jason@lakedaemon.net (Jason Cooper)
Date: Fri, 21 Nov 2014 19:53:38 -0500
Subject: [PATCHv3 02/16] ARM: mvebu: enable strex backoff delay
In-Reply-To: <1416585613-2113-3-git-send-email-thomas.petazzoni@free-electrons.com>
References: <1416585613-2113-1-git-send-email-thomas.petazzoni@free-electrons.com>
 <1416585613-2113-3-git-send-email-thomas.petazzoni@free-electrons.com>
Message-ID: <20141122005337.GL22670@titan.lakedaemon.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Nov 21, 2014 at 04:59:59PM +0100, Thomas Petazzoni wrote:
> From: Nadav Haklai <nadavh@marvell.com>
> 
> Under extremely rare conditions, in an MPCore node consisting of at
> least 3 CPUs, two CPUs trying to perform a STREX to data on the same
> shared cache line can enter a livelock situation.
> 
> This patch enables the HW mechanism that overcomes the bug. This fixes
> the incorrect setup of the STREX backoff delay bit due to a wrong
> description in the specification.
> 
> Note that enabling the STREX backoff delay mechanism is done by
> leaving the bit *cleared*, while the bit was currently being set by
> the proc-v7.S code.
> 
> [Thomas: adapt to latest mainline, slightly reword the commit log, add
> stable markers.]
> 
> Cc: Russell King <linux@arm.linux.org.uk>
> Cc: <stable@vger.kernel.org> # v3.8+
> Fixes: de4901933f6d ("arm: mm: Add support for PJ4B cpu and init routines")
> Signed-off-by: Nadav Haklai <nadavh@marvell.com>
> Signed-off-by: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
> Acked-by: Gregory CLEMENT <gregory.clement@free-electrons.com>
> ---
> This patch is submitted as part of the suspend/resume work, because
> the suspend/resume path is triggering this rare bug in a very
> reproducible fashion.
> 
> Signed-off-by: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
> ---
>  arch/arm/mm/proc-v7.S | 2 --
>  1 file changed, 2 deletions(-)

Acked-by: Jason Cooper <jason@lakedaemon.net>

Please add to Russell's patch tracker.

thx,

Jason.
