From: jamie@jamieiles.com (Jamie Iles)
Date: Thu, 9 Jun 2011 10:56:15 +0100
Subject: [PATCH 2/2] ARM: pmu: reject duplicate PMU registrations
In-Reply-To: <1307546911-2714-3-git-send-email-mark.rutland@arm.com>
References: <1307546911-2714-1-git-send-email-mark.rutland@arm.com>
	<1307546911-2714-3-git-send-email-mark.rutland@arm.com>
Message-ID: <20110609095615.GB3711@pulham.picochip.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jun 08, 2011 at 04:28:31PM +0100, Mark Rutland wrote:
> Currently, the PMU reservation framework allows for multiple PMUs of
> the same type to register themselves. This can lead to a bug with the
> sequence:
> 
> register_pmu(pmu1);
> reserve_pmu(pmu_type);
> register_pmu(pmu2);
> release_pmu(pmu1);
> 
> Here, pmu1 cannot be released, and pmu2 cannot be reserved.
> 
> This patch modifies register_pmu to reject registrations where a PMU is
> already present, preventing this problem. PMUs which can have multiple
> instances should not use the PMU reservation framework.
> 
> Signed-off-by: Mark Rutland <mark.rutland@arm.com>
> Acked-By Will Deacon <will.deacon@arm.com>
> Cc: Jamie Iles <jamie@jamieiles.com>

Acked-by: Jamie Iles <jamie@jamieiles.com>

Jamie
