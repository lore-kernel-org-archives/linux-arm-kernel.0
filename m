From: will.deacon@arm.com (Will Deacon)
Date: Mon, 1 Jun 2015 10:28:04 +0100
Subject: [PATCH 3/6] drivers: firmware: psci: move power_state handling
 to generic code
In-Reply-To: <1432901799-18359-4-git-send-email-lorenzo.pieralisi@arm.com>
References: <1432901799-18359-1-git-send-email-lorenzo.pieralisi@arm.com>
 <1432901799-18359-4-git-send-email-lorenzo.pieralisi@arm.com>
Message-ID: <20150601092804.GB1641@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, May 29, 2015 at 01:16:36PM +0100, Lorenzo Pieralisi wrote:
> Functions implemented on arm64 to check if a power_state parameter
> is valid and if the power_state implies context loss are not
> arm64 specific and should be moved to generic code so that they
> can be reused on arm systems too.
> 
> This patch moves the functions handling the power_state parameter
> to generic PSCI firmware layer code.
> 
> Signed-off-by: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
> Acked-by: Sudeep Holla <sudeep.holla@arm.com>
> Cc: Will Deacon <will.deacon@arm.com>
> Cc: Catalin Marinas <catalin.marinas@arm.com>
> Cc: Mark Rutland <mark.rutland@arm.com>
> ---
>  arch/arm64/kernel/psci.c | 14 --------------
>  drivers/firmware/psci.c  | 15 +++++++++++++++
>  include/linux/psci.h     |  2 ++
>  3 files changed, 17 insertions(+), 14 deletions(-)

Looks fine to me:

  Acked-by: Will Deacon <will.deacon@arm.com>

Will
