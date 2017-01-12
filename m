From: mark.rutland@arm.com (Mark Rutland)
Date: Thu, 12 Jan 2017 16:12:14 +0000
Subject: [PATCH v3 2/5] arm64: Work around Falkor erratum 1003
In-Reply-To: <20170112154548.twj2ktbfzbsarzbc@localhost>
References: <20170111144118.17062-1-cov@codeaurora.org>
 <20170111144118.17062-2-cov@codeaurora.org>
 <20170111180627.GG20288@e104818-lin.cambridge.arm.com>
 <278a45c0-bd49-b8a2-63ae-80ad851bab9b@arm.com>
 <20170111184052.GE29247@leverpostej>
 <20170112154548.twj2ktbfzbsarzbc@localhost>
Message-ID: <20170112161214.GB12583@leverpostej>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Jan 12, 2017 at 03:45:48PM +0000, Catalin Marinas wrote:
> On Wed, Jan 11, 2017 at 06:40:52PM +0000, Mark Rutland wrote:

> > Likewise, I beleive we may need to modify cpu_set_reserved_ttbr0().
> 
> This may be fine if my assumptions about this erratum are correct. In
> the cpu_set_reserved_ttbr0() case we set TTBR0_EL1 to a table without
> any entries, so no new entries could be tagged with the old ASID.

For some reason, I was under the impression that the issue was old table
entries being allocated to the new ASID. Looking over the series again,
it's not clear to me precisely which cases can occur.

It would be good to see that clarified.

Thanks,
Mark.
