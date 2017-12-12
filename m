From: will.deacon@arm.com (Will Deacon)
Date: Tue, 12 Dec 2017 18:11:56 +0000
Subject: [PATCH v2] arm64: cpu_errata: Add Kryo to Falkor 1003 errata
In-Reply-To: <20171129230353.11809-1-sboyd@codeaurora.org>
References: <20171129230353.11809-1-sboyd@codeaurora.org>
Message-ID: <20171212181156.GA25244@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Stephen,

On Wed, Nov 29, 2017 at 03:03:53PM -0800, Stephen Boyd wrote:
> The Kryo CPUs are also affected by the Falkor 1003 errata, so
> we need to do the same workaround on Kryo CPUs. The MIDR is
> slightly more complicated here, where the PART number is not
> always the same when looking at all the bits from 15 to 4. Drop
> the lower 8 bits and just look at the top 4 to see if it's '2'
> and then consider those as Kryo CPUs. This covers all the
> combinations without having to list them all out.
> 
> Introduce a new hardware cap bit for the combination of hardware
> PAN support and this errata so that we can disable support for
> software PAN at runtime if this errata is present and the CPU
> doesn't support HW PAN. This happens on some Kryo CPUs where the
> HW PAN feature isn't supported but we can't prevent software PAN
> from being selected in the configuration. Previously, Falkor CPUs
> were all known to have HW PAN support, so we didn't need to worry
> about this case.
> 
> Fixes: 38fd94b0275c ("arm64: Work around Falkor erratum 1003")
> Signed-off-by: Stephen Boyd <sboyd@codeaurora.org>
> ---

Can you respin this on top of for-next/core please? The PAN bits should
be much simpler with the KPTI code.

Will
