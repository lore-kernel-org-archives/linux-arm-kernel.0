From: will.deacon@arm.com (Will Deacon)
Date: Thu, 3 Jul 2014 17:01:11 +0100
Subject: [PATCH V6 1/2] arm: mm: Introduce {pte,pmd}_isset and
 {pte,pmd}_isclear
In-Reply-To: <1404389173-4246-2-git-send-email-steve.capper@linaro.org>
References: <1404389173-4246-1-git-send-email-steve.capper@linaro.org>
 <1404389173-4246-2-git-send-email-steve.capper@linaro.org>
Message-ID: <20140703160111.GD14305@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Jul 03, 2014 at 01:06:12PM +0100, Steve Capper wrote:
> Long descriptors on ARM are 64 bits, and some pte functions such as
> pte_dirty return a bitwise-and of a flag with the pte value. If the
> flag to be tested resides in the upper 32 bits of the pte, then we run
> into the danger of the result being dropped if downcast.
> 
> For example:
> 	gather_stats(page, md, pte_dirty(*pte), 1);
> where pte_dirty(*pte) is downcast to an int.
> 
> This patch introduces a new macro pte_isset which performs the bitwise
> and, then performs a double logical invert (where needed) to ensure
> predictable downcasting. The logical inverse pte_isclear is also
> introduced.
> 
> Equivalent pmd functions for Transparent HugePages have also been
> added.
> 
> Signed-off-by: Steve Capper <steve.capper@linaro.org>

  Reviewed-by: Will Deacon <will.deacon@arm.com>

Will
