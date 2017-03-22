From: mark.rutland@arm.com (Mark Rutland)
Date: Wed, 22 Mar 2017 14:24:39 +0000
Subject: [PATCH 6/7] arm64: hugetlb: Spring clean huge pte accessors
In-Reply-To: <20170321180421.18332-7-punit.agrawal@arm.com>
References: <20170321180421.18332-1-punit.agrawal@arm.com>
 <20170321180421.18332-7-punit.agrawal@arm.com>
Message-ID: <20170322142439.GG2977@leverpostej>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Mar 21, 2017 at 06:04:20PM +0000, Punit Agrawal wrote:
> +		/*
> +		 * If HW_AFDBM is enabled, then the HW could
> +		 * turn on the dirty bit for any of the page
> +		 * in the set, so check them all.
> +		 */

Nit: we've carried over a grammar bug from the existing comment, which
would be nive to fix up. Can we either s/page/pages/ or s/of the // ?

Either way, the logic looks good.

Reviewed-by: Mark Rutland <mark.rutland@arm.com>

Mark.
