From: robert.richter@cavium.com (Robert Richter)
Date: Mon, 6 Feb 2017 14:36:11 +0100
Subject: [PATCH 2/2] arm64: mm: enable CONFIG_HOLES_IN_ZONE for NUMA
In-Reply-To: <1481706707-6211-3-git-send-email-ard.biesheuvel@linaro.org>
References: <1481706707-6211-1-git-send-email-ard.biesheuvel@linaro.org>
 <1481706707-6211-3-git-send-email-ard.biesheuvel@linaro.org>
Message-ID: <20170206133611.GL16822@rric.localdomain>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 14.12.16 09:11:47, Ard Biesheuvel wrote:
> The NUMA code may get confused by the presence of NOMAP regions within
> zones, resulting in spurious BUG() checks where the node id deviates
> from the containing zone's node id.
> 
> Since the kernel has no business reasoning about node ids of pages it
> does not own in the first place, enable CONFIG_HOLES_IN_ZONE to ensure
> that such pages are disregarded.
> 
> Signed-off-by: Ard Biesheuvel <ard.biesheuvel@linaro.org>

I would rather see a solution other than making pfn_valid checks more
fine grained, but this patch also fixes the issue. So:

Acked-by: Robert Richter <rrichter@cavium.com>
