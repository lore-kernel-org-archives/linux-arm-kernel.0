From: leo.yan@linaro.org (leo.yan at linaro.org)
Date: Mon, 2 Jul 2018 10:35:45 +0800
Subject: [PATCH v1 0/6] perf cs-etm: Fix tracing packet handling and
 minor refactoring
In-Reply-To: <20180619181943.GL20477@kernel.org>
References: <1529298599-3876-1-git-send-email-leo.yan@linaro.org>
 <CANLsYkyxuz+tPrC7wb1omsw+qj=7ZB5t6FRbqZz54994g62q6g@mail.gmail.com>
 <20180619181943.GL20477@kernel.org>
Message-ID: <20180702023545.GA13629@leoy-ThinkPad-X240s>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Arnaldo,

On Tue, Jun 19, 2018 at 03:19:43PM -0300, Arnaldo Carvalho de Melo wrote:
> Em Tue, Jun 19, 2018 at 11:46:02AM -0600, Mathieu Poirier escreveu:
> > On Sun, 17 Jun 2018 at 23:10, Leo Yan <leo.yan@linaro.org> wrote:
> > >
> > > Due the current code is missing to handle cs-etm start tracing packet
> > > and CS_ETM_TRACE_ON packet, we fail to generate branch sample for them.
> > >
> > > This patch series is to fix cs-etm tracing packet handling:
> > >
> > > Patch 0001 is to add invalid address macro for readable coding;
> > >
> > > Patch 0002 is one minor fixing to return error code for instruction
> > > sample failure;
> > >
> > > Patches 0003~0006 are fixing patches for start tracing packet
> > > and CS_ETM_TRACE_ON packet.
> > >
> > > This patch series is applied on acme tree [1] on branch perf/core with
> > > latest commit: e238cf2e3d2e ("perf intel-pt: Fix packet decoding of CYC
> > > packets").  Also applied successfully this patch series on Linus tree
> > > on 4.18-rc1.
> > >
> > > This patch series has been verified on Hikey620 platform with below two
> > > commands:
> > > perf script --itrace=i10000il128 -F cpu,event,ip,addr,sym -k ./vmlinux
> > > perf script -F cpu,event,ip,addr,sym -k ./vmlinux
> > >
> > > [1] https://git.kernel.org/pub/scm/linux/kernel/git/acme/linux.git
> > >
> > >
> > > Leo Yan (6):
> > >   perf cs-etm: Introduce invalid address macro
> > >   perf cs-etm: Bail out immediately for instruction sample failure
> > >   perf cs-etm: Fix start tracing packet handling
> > >   perf cs-etm: Support dummy address value for CS_ETM_TRACE_ON packet
> > >   perf cs-etm: Generate branch sample when receiving a CS_ETM_TRACE_ON
> > >     packet
> > >   perf cs-etm: Generate branch sample for CS_ETM_TRACE_ON packet
> > >
> > >  tools/perf/util/cs-etm-decoder/cs-etm-decoder.c | 10 ++--
> > >  tools/perf/util/cs-etm-decoder/cs-etm-decoder.h |  1 +
> > >  tools/perf/util/cs-etm.c                        | 71 +++++++++++++++++++++----
> > >  3 files changed, 68 insertions(+), 14 deletions(-)
> > 
> > Good day Arnaldo,
> > 
> > I am good with this set:
> > 
> > Reviewed-by: Mathieu Poirier <mathieu.poirier@linaro.org>
> > 
> > Please consider for inclusion in your tree if you are satisfied with the work.
> 
> I'll take a look and get it into perf/core, now I'm concentrating on
> perf/urgent work.

Gentle ping for this patch series.

I tested this patch series on perf/core branch with latest commit
87b40003b17a ("perf tests: Check that complex event name is parsed
correctly"), this patch series is still valid and can pass testing.

Could you pick up them?  If you want me to resend this patch series,
please let me know.

Thanks,
Leo Yan
