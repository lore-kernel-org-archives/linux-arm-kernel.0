From: will.deacon@arm.com (Will Deacon)
Date: Thu, 14 Dec 2017 15:18:58 +0000
Subject: [PATCH v3] arm64: cpu_errata: Add Kryo to Falkor 1003 errata
In-Reply-To: <20171213221937.28065-1-sboyd@codeaurora.org>
References: <20171213221937.28065-1-sboyd@codeaurora.org>
Message-ID: <20171214151858.GH4527@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Dec 13, 2017 at 02:19:37PM -0800, Stephen Boyd wrote:
> The Kryo CPUs are also affected by the Falkor 1003 errata, so
> we need to do the same workaround on Kryo CPUs. The MIDR is
> slightly more complicated here, where the PART number is not
> always the same when looking at all the bits from 15 to 4. Drop
> the lower 8 bits and just look at the top 4 to see if it's '2'
> and then consider those as Kryo CPUs. This covers all the
> combinations without having to list them all out.
> 
> Fixes: 38fd94b0275c ("arm64: Work around Falkor erratum 1003")
> Signed-off-by: Stephen Boyd <sboyd@codeaurora.org>
> ---

Acked-by: Will Deacon <will.deacon@arm.com>

Thanks for respinning this. Catalin -- can you take this for 4.16, please?

Will
