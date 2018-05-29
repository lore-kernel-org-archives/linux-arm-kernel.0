From: acme@kernel.org (Arnaldo Carvalho de Melo)
Date: Tue, 29 May 2018 10:32:24 -0300
Subject: [RFT v3 0/4] Perf script: Add python script for CoreSight trace
 disassembler
In-Reply-To: <CANLsYkzn5qyzjxMiCPQ1GxyNjhHJp-2H6Lds11HP9rG5xug0FA@mail.gmail.com>
References: <1527497103-3593-1-git-send-email-leo.yan@linaro.org>
 <20180528200326.GJ25467@kernel.org>
 <CANLsYkzn5qyzjxMiCPQ1GxyNjhHJp-2H6Lds11HP9rG5xug0FA@mail.gmail.com>
Message-ID: <20180529133224.GA20886@kernel.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Em Mon, May 28, 2018 at 03:53:42PM -0600, Mathieu Poirier escreveu:
> On 28 May 2018 at 14:03, Arnaldo Carvalho de Melo <acme@kernel.org> wrote:
> > Em Mon, May 28, 2018 at 04:44:59PM +0800, Leo Yan escreveu:
> >> This patch series is to support for using 'perf script' for CoreSight
> >> trace disassembler, for this purpose this patch series adds a new
> >> python script to parse CoreSight tracing event and use command 'objdump'
> >> for disassembled lines, finally this can generate readable program
> >> execution flow for reviewing tracing data.
> >>
> >> Patch 0001 is one fixing patch to generate samples for the start packet
> >> and exception packets.
> >>
> >> Patch 0002 is the prerequisite to add addr into sample dict, so this
> >> value can be used by python script to analyze instruction range.
> >>
> >> Patch 0003 is to add python script for trace disassembler.
> >>
> >> Patch 0004 is to add doc to explain python script usage and give
> >> example for it.
> >>
> >> This patch series has been rebased on acme git tree [1] with the commit
> >> 19422a9f2a3b ("perf tools: Fix kernel_start for PTI on x86") and tested
> >> on Hikey (ARM64 octa CA53 cores).
> >
> > Thanks, applied to perf/core.
> 
> Please hold off on that Arnaldo - I'm currently reviewing the set and
> I think some things can be improved.

Ok, I dropped all but the one adding sample->addr to the python
dictionary, that is ok to cherry pick.

- Arnaldo
