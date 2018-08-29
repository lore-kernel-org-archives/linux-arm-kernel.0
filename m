From: will.deacon@arm.com (Will Deacon)
Date: Wed, 29 Aug 2018 11:41:15 +0100
Subject: [PATCH 1/2] arm/arm64: smccc-1.1: Make return values unsigned long
In-Reply-To: <20180824140830.12747-2-marc.zyngier@arm.com>
References: <20180824140830.12747-1-marc.zyngier@arm.com>
 <20180824140830.12747-2-marc.zyngier@arm.com>
Message-ID: <20180829104114.GB23979@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Aug 24, 2018 at 03:08:29PM +0100, Marc Zyngier wrote:
> An unfortunate consequence of having a strong typing for the input
> values to the SMC call is that it also affects the type of the
> return values, limiting r0 to 32 bits and r{1,2,3} to whatever
> was passed as an input.
> 
> Let's turn everything into "unsigned long", which satisfies the
> requirements of both architectures, and allows for the full
> range of return values.
> 
> Reported-by: Julien Grall <julien.grall@arm.com>
> Signed-off-by: Marc Zyngier <marc.zyngier@arm.com>
> ---
>  include/linux/arm-smccc.h | 20 ++++++++++----------
>  1 file changed, 10 insertions(+), 10 deletions(-)

Does this need a Cc stable, or do no current callers need the upper bits of
the return values on arm64?

Will
