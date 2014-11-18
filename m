From: catalin.marinas@arm.com (Catalin Marinas)
Date: Tue, 18 Nov 2014 16:43:13 +0000
Subject: [PATCH v5 01/18] ARM64: Move the init of cpu_logical_map(0)
 before unflatten_device_tree()
In-Reply-To: <546B4D8D.2020605@linaro.org>
References: <1413553034-20956-1-git-send-email-hanjun.guo@linaro.org>
 <1413553034-20956-2-git-send-email-hanjun.guo@linaro.org>
 <546B4D8D.2020605@linaro.org>
Message-ID: <20141118164312.GL28279@e104818-lin.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Nov 18, 2014 at 01:45:49PM +0000, Hanjun Guo wrote:
> On 2014?10?17? 21:36, Hanjun Guo wrote:
> > It always make sense to initialize CPU0's logical map entry from the
> > hardware values, so move the initialization of cpu_logical_map(0)
> > before unflatten_device_tree() which is needed by ACPI code later.
> >
> > Acked-by: Olof Johansson <olof@lixom.net>
> > Acked-by: Mark Rutland <mark.rutland@arm.com>
> > Signed-off-by: Hanjun Guo <hanjun.guo@linaro.org>
> 
> Could you merge this patch first in 3.19? It was acked by Olof and
> Mark, and it will make sense without ACPI too.

I think it can go in for 3.19 (it's Will's turn this time ;)).

FWIW:

Acked-by: Catalin Marinas <catalin.marinas@arm.com>
