From: gregory.clement@free-electrons.com (Gregory CLEMENT)
Date: Mon, 03 Nov 2014 18:08:46 +0100
Subject: [PATCH 02/17] ARM: mvebu: enable strex backoff delay
In-Reply-To: <1414151970-6626-3-git-send-email-thomas.petazzoni@free-electrons.com>
References: <1414151970-6626-1-git-send-email-thomas.petazzoni@free-electrons.com>
 <1414151970-6626-3-git-send-email-thomas.petazzoni@free-electrons.com>
Message-ID: <5457B69E.7020508@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Thomas,
On 24/10/2014 13:59, Thomas Petazzoni wrote:
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
> ---
> This patch is submitted as part of the suspend/resume work, because
> the suspend/resume path is triggering this rare bug in a very
> reproducible fashion.
> 
> Signed-off-by: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
> ---
>  arch/arm/mm/proc-v7.S | 2 --
>  1 file changed, 2 deletions(-)
> 

Acked-by: Gregory CLEMENT <gregory.clement@free-electrons.com>


Thanks,

Gregory

-- 
Gregory Clement, Free Electrons
Kernel, drivers, real-time and embedded Linux
development, consulting, training and support.
http://free-electrons.com
