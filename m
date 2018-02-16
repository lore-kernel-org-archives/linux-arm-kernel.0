From: catalin.marinas@arm.com (Catalin Marinas)
Date: Fri, 16 Feb 2018 18:28:14 +0000
Subject: [PATCH 1/2] arm64: uaccess: Clean up types for access_ok()
In-Reply-To: <6efdc36edd90ab33506c03fb58946fab1bbddf26.1518800663.git.robin.murphy@arm.com>
References: <6efdc36edd90ab33506c03fb58946fab1bbddf26.1518800663.git.robin.murphy@arm.com>
Message-ID: <20180216182813.dlwfuqkzcotctd6a@armageddon.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Feb 16, 2018 at 05:04:22PM +0000, Robin Murphy wrote:
> In converting __range_ok() into a static inline, I inadvertently made
> it more type-safe, but without considering the ordering of the relevant
> conversions. This leads to quite a lot of Sparse noise about the fact
> that we use __chk_user_ptr() after addr has already been converted from
> a user pointer to an unsigned long.
> 
> Tweak the prototype and locals so the types all make logical sense and
> Sparse is happy (although the resulting codegen remains identical). The
> only external site this affects is in compat syscalls where the inferred
> "user-pointer-ness" of a register value now warrants an explicit cast.
> 
> Signed-off-by: Robin Murphy <robin.murphy@arm.com>

Both applied. Thanks.

-- 
Catalin
