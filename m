From: catalin.marinas@arm.com (Catalin Marinas)
Date: Fri, 28 Feb 2014 15:46:12 +0000
Subject: [PATCH V2 2/3] arm64: mm: Add double logical invert to pte
 accessors
In-Reply-To: <1393328334-27285-3-git-send-email-steve.capper@linaro.org>
References: <1393328334-27285-1-git-send-email-steve.capper@linaro.org>
 <1393328334-27285-3-git-send-email-steve.capper@linaro.org>
Message-ID: <20140228154612.GG13970@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Feb 25, 2014 at 11:38:53AM +0000, Steve Capper wrote:
> Page table entries on ARM64 are 64 bits, and some pte functions such as
> pte_dirty return a bitwise-and of a flag with the pte value. If the
> flag to be tested resides in the upper 32 bits of the pte, then we run
> into the danger of the result being dropped if downcast.
> 
> For example:
> 	gather_stats(page, md, pte_dirty(*pte), 1);
> where pte_dirty(*pte) is downcast to an int.
> 
> This patch adds a double logical invert to all the pte_ accessors to
> ensure predictable downcasting.
> 
> Signed-off-by: Steve Capper <steve.capper@linaro.org>

Applied and added cc stable as well. Thanks.

-- 
Catalin
