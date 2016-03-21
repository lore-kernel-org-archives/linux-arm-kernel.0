From: will.deacon@arm.com (Will Deacon)
Date: Mon, 21 Mar 2016 10:54:07 +0000
Subject: [PATCH V1] perf: qcom: Add L3 cache PMU driver
In-Reply-To: <20160321103507.GB17326@leverpostej>
References: <1458333422-8963-1-git-send-email-agustinv@codeaurora.org>
 <20160321103507.GB17326@leverpostej>
Message-ID: <20160321105407.GD23397@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Mar 21, 2016 at 10:35:08AM +0000, Mark Rutland wrote:
> On Fri, Mar 18, 2016 at 04:37:02PM -0400, Agustin Vega-Frias wrote:
> > This adds a new dynamic PMU to the Perf Events framework to program
> > and control the L3 cache PMUs in some Qualcomm Technologies SOCs.
> > 
> > The driver supports a distributed cache architecture where the overall
> > cache is comprised of multiple slices each with its own PMU. The driver
> > aggregates counts across the whole system to provide a global picture
> > of the metrics selected by the user.
> > 
> > The driver exports formatting and event information to sysfs so it can
> > be used by the perf user space tools with the syntaxes:
> >    perf stat -a -e l3cache/read-miss/
> >    perf stat -a -e l3cache/event=0x21/
> > 
> > Signed-off-by: Agustin Vega-Frias <agustinv@codeaurora.org>
> > ---
> >  arch/arm64/kernel/Makefile                   |   4 +
> >  arch/arm64/kernel/perf_event_qcom_l3_cache.c | 816 +++++++++++++++++++++++++++
> >  2 files changed, 820 insertions(+)
> >  create mode 100644 arch/arm64/kernel/perf_event_qcom_l3_cache.c
> 
> Move this to drivers/bus (where the CCI and CCN PMU drivers live), or
> drivers/perf (where some common infrastructure lives).

Please stick to drivers/perf, as I have a vague plan to move the CCI/CCN
PMU code out of drivers/bus and into drivers/perf (which didn't exist
when they were originally upstreamed).

Will
