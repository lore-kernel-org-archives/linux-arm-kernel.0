From: will.deacon@arm.com (Will Deacon)
Date: Tue, 18 Nov 2014 16:57:13 +0000
Subject: [PATCH v5 01/18] ARM64: Move the init of cpu_logical_map(0)
 before unflatten_device_tree()
In-Reply-To: <20141118164312.GL28279@e104818-lin.cambridge.arm.com>
References: <1413553034-20956-1-git-send-email-hanjun.guo@linaro.org>
 <1413553034-20956-2-git-send-email-hanjun.guo@linaro.org>
 <546B4D8D.2020605@linaro.org>
 <20141118164312.GL28279@e104818-lin.cambridge.arm.com>
Message-ID: <20141118165713.GT18842@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Nov 18, 2014 at 04:43:13PM +0000, Catalin Marinas wrote:
> On Tue, Nov 18, 2014 at 01:45:49PM +0000, Hanjun Guo wrote:
> > On 2014?10?17? 21:36, Hanjun Guo wrote:
> > > It always make sense to initialize CPU0's logical map entry from the
> > > hardware values, so move the initialization of cpu_logical_map(0)
> > > before unflatten_device_tree() which is needed by ACPI code later.
> > >
> > > Acked-by: Olof Johansson <olof@lixom.net>
> > > Acked-by: Mark Rutland <mark.rutland@arm.com>
> > > Signed-off-by: Hanjun Guo <hanjun.guo@linaro.org>
> > 
> > Could you merge this patch first in 3.19? It was acked by Olof and
> > Mark, and it will make sense without ACPI too.
> 
> I think it can go in for 3.19 (it's Will's turn this time ;)).

This patch doesn't apply on for-next/core, as it conflicts with some of
Rutland's rework ("arm64: log physical ID of boot CPU").

Will
