From: will.deacon@arm.com (Will Deacon)
Date: Tue, 26 Aug 2014 14:04:27 +0100
Subject: [PATCH 1/6] arm: Fix in-correct barrier usage in SWP{B} emulation
In-Reply-To: <1409048930-21598-2-git-send-email-punit.agrawal@arm.com>
References: <1409048930-21598-1-git-send-email-punit.agrawal@arm.com>
 <1409048930-21598-2-git-send-email-punit.agrawal@arm.com>
Message-ID: <20140826130427.GN23445@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Aug 26, 2014 at 11:28:45AM +0100, Punit Agrawal wrote:
> According to the ARM ARMv7, explicit barriers are necessary when using
> synchronisation primitives such as SWP{B}. The use of these
> instructions does not automatically imply a barrier and any ordering
> requirements by the software must be explicitly expressed with the use
> of suitable barriers.
> 
> Based on this, remove the barriers from SWP{B} emulation.
> 
> Cc: Russell King <linux@arm.linux.org.uk>
> Signed-off-by: Punit Agrawal <punit.agrawal@arm.com>
> ---
>  arch/arm/kernel/swp_emulate.c |   15 ---------------
>  1 file changed, 15 deletions(-)

Acked-by: Will Deacon <will.deacon@arm.com>

Will
