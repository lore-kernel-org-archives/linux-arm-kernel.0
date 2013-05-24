From: catalin.marinas@arm.com (Catalin Marinas)
Date: Fri, 24 May 2013 12:21:49 +0100
Subject: [PATCH 07/11] ARM64: mm: Make PAGE_NONE pages read only and
 no-execute.
In-Reply-To: <1369328878-11706-8-git-send-email-steve.capper@linaro.org>
References: <1369328878-11706-1-git-send-email-steve.capper@linaro.org>
 <1369328878-11706-8-git-send-email-steve.capper@linaro.org>
Message-ID: <20130524112149.GJ18272@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, May 23, 2013 at 06:07:54PM +0100, Steve Capper wrote:
> If we consider the following code sequence:
> 
> 	my_pte = pte_modify(entry, myprot);
> 	x = pte_write(my_pte);
> 	y = pte_exec(my_pte);
> 
> If myprot comes from a PROT_NONE page, then x and y will both be
> true which is undesireable behaviour.
> 
> This patch sets the no-execute and read-only bits for PAGE_NONE
> such that the code above will return false for both x and y.
> 
> Signed-off-by: Steve Capper <steve.capper@linaro.org>

Acked-by: Catalin Marinas <catalin.marinas@arm.com>
