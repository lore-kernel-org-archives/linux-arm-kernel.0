From: will.deacon@arm.com (Will Deacon)
Date: Thu, 6 Jun 2013 13:45:02 +0100
Subject: [PATCH v2] arm: mvebu: don't hardcode a physical address in
 headsmp.S
In-Reply-To: <1370514268-9159-1-git-send-email-thomas.petazzoni@free-electrons.com>
References: <1370415901-4721-6-git-send-email-thomas.petazzoni@free-electrons.com>
 <1370514268-9159-1-git-send-email-thomas.petazzoni@free-electrons.com>
Message-ID: <20130606124502.GE16794@mudshark.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Jun 06, 2013 at 11:24:28AM +0100, Thomas Petazzoni wrote:
> Now that the coherency_init() function is called a bit earlier, we can
> actually read the physical address of the coherency unit registers
> from the Device Tree, and communicate that to the headsmp.S code,
> which avoids hardcoding a physical address.
> 
> Signed-off-by: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
> ---
> Changes from v1 to v2:
> 
>  * Simplified the code in headsmp.S to compute the physical address of
>    the coherency unit base address. Suggested by Nicolas Pitre.
> 
>  * Added a sync_cache_w() call to ensure the physical address of the
>    coherency unit stored in the coherency_phys_base is visible by the
>    other CPUs. The other CPUs are reading this before they join the
>    coherency fabric, so we need to make some manual cache coherency
>    here. Noticed by Will Deacon.
> 
>  arch/arm/mach-mvebu/coherency.c | 12 ++++++++++++
>  arch/arm/mach-mvebu/headsmp.S   | 16 ++++++++--------
>  2 files changed, 20 insertions(+), 8 deletions(-)

This looks better to me, cheers.

  Reviewed-by: Will Deacon <will.deacon@arm.com>

Will
