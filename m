From: will.deacon@arm.com (Will Deacon)
Date: Mon, 16 Dec 2013 16:56:48 +0000
Subject: [PATCH 4/6] arm64: lib: Implement optimized memcmp routine
In-Reply-To: <1386743082-5231-5-git-send-email-zhichang.yuan@linaro.org>
References: <1386743082-5231-1-git-send-email-zhichang.yuan@linaro.org>
 <1386743082-5231-5-git-send-email-zhichang.yuan@linaro.org>
Message-ID: <20131216165647.GH20193@mudshark.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Dec 11, 2013 at 06:24:40AM +0000, zhichang.yuan at linaro.org wrote:
> From: "zhichang.yuan" <zhichang.yuan@linaro.org>
> 
> This patch, based on Linaro's Cortex Strings library, adds
> an assembly optimized memcmp() function.

[...]

> +#ifndef	__ARM64EB__
> +	rev	diff, diff
> +	rev	data1, data1
> +	rev	data2, data2
> +#endif

Given that I can't see you defining __ARM64EB__, I'd take a guess at you
never having tested this code on a big-endian machine.

Please can you fix that?

Will
