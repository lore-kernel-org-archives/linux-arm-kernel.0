From: catalin.marinas@arm.com (Catalin Marinas)
Date: Wed, 18 Jan 2017 11:24:30 +0000
Subject: [PATCH v1] arm64: mm: avoid name clash in __page_to_voff()
In-Reply-To: <1484723365-24147-1-git-send-email-andr2000@gmail.com>
References: <1484723365-24147-1-git-send-email-andr2000@gmail.com>
Message-ID: <20170118112429.GB7566@e104818-lin.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jan 18, 2017 at 09:09:25AM +0200, Oleksandr Andrushchenko wrote:
> From: Oleksandr Andrushchenko <Oleksandr_Andrushchenko@epam.com>
> 
> The arm64 __page_to_voff() macro takes a parameter called 'page', and
> also refers to 'struct page'. Thus, if the value passed in is not
> called 'page', we'll refer to the wrong struct name (which might not
> exist).
> 
> Fixes: 3fa72fe9c614 ("arm64: mm: fix __page_to_voff definition")
> Acked-by: Mark Rutland <mark.rutland@arm.com>
> Suggested-by: Volodymyr Babchuk <Volodymyr_Babchuk@epam.com>
> Signed-off-by: Oleksandr Andrushchenko <Oleksandr_Andrushchenko@epam.com>

Queued for 4.10. Thanks.

-- 
Catalin
