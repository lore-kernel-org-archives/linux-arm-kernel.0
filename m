From: shawnguo@kernel.org (Shawn Guo)
Date: Thu, 13 Oct 2016 20:49:04 +0800
Subject: [PATCH 1/1 v8] ARM: imx: Added perf functionality to mmdc driver
In-Reply-To: <CAHrpEqQ2H7FZVbn_A3VPCs3aA7AekT7k+Z++js_iCTw346z9Sw@mail.gmail.com>
References: <1474307849-7341-1-git-send-email-Frank.Li@nxp.com>
 <CAHrpEqQE5w_+4tn1SnFs8rQnWXRb86LDMSGxE7xCUDE=8WnbyQ@mail.gmail.com>
 <CAHrpEqQ2H7FZVbn_A3VPCs3aA7AekT7k+Z++js_iCTw346z9Sw@mail.gmail.com>
Message-ID: <20161013124904.GA25183@tiger>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Oct 10, 2016 at 03:17:36PM -0500, Zhi Li wrote:
> On Mon, Sep 26, 2016 at 11:40 AM, Zhi Li <lznuaa@gmail.com> wrote:
> > On Mon, Sep 19, 2016 at 12:57 PM, Frank Li <Frank.Li@nxp.com> wrote:
> >> From: Zhengyu Shen <zhengyu.shen@nxp.com>
> >>
> >> MMDC is a multi-mode DDR controller that supports DDR3/DDR3L x16/x32/x64
> >> and LPDDR2 two channel x16/x32 memory types. MMDC is configurable, high
> >> performance, and optimized. MMDC is present on i.MX6 Quad and i.MX6
> >> QuadPlus devices, but this driver only supports i.MX6 Quad at the moment.
> >> MMDC provides registers for performance counters which read via this
> >> driver to help debug memory throughput and similar issues.
> >>
> >> $ perf stat -a -e mmdc/busy-cycles/,mmdc/read-accesses/,mmdc/read-bytes/,mmdc/total-cycles/,mmdc/write-accesses/,mmdc/write-bytes/ dd if=/dev/zero of=/dev/null bs=1M count=5000
> >> Performance counter stats for 'dd if=/dev/zero of=/dev/null bs=1M count=5000':
> >>
> >>          898021787      mmdc/busy-cycles/
> >>           14819600      mmdc/read-accesses/
> >>             471.30 MB   mmdc/read-bytes/
> >>         2815419216      mmdc/total-cycles/
> >>           13367354      mmdc/write-accesses/
> >>             427.76 MB   mmdc/write-bytes/
> >>
> >>        5.334757334 seconds time elapsed
> >>
> >> Signed-off-by: Zhengyu Shen <zhengyu.shen@nxp.com>
> >> Signed-off-by: Frank Li <frank.li@nxp.com>
> >> ---
> >
> > Mark:
> >         Any additional comments for this version?
> >
> 
> Shawn:
>            No any new comment for more than 2 weeks.
>            Did you plan accept this patch?

We normally do not apply patches in the middle of a merge window.  I
plan to apply it when 4.9-rc1 comes out.  But I still would like to get
a Reviewed-by tag from Mark before doing that.

@Mark,

Are you happy with this version?

Shawn
