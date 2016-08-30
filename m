From: shawnguo@kernel.org (Shawn Guo)
Date: Tue, 30 Aug 2016 19:43:29 +0800
Subject: [PATCH v3] Added perf functionality to mmdc driver
In-Reply-To: <CAHrpEqTtCnEU1v1sEuN8yJGPudDRZ5A79=Wn5Bp4SgTxDiNTQQ@mail.gmail.com>
References: <20160817194253.16300-1-zhengyu.shen@nxp.com>
 <CAHrpEqTtCnEU1v1sEuN8yJGPudDRZ5A79=Wn5Bp4SgTxDiNTQQ@mail.gmail.com>
Message-ID: <20160830114329.GB8366@tiger>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Aug 29, 2016 at 11:06:44AM -0500, Zhi Li wrote:
> On Wed, Aug 17, 2016 at 2:42 PM, Zhengyu Shen <zhengyu.shen@nxp.com> wrote:
> > MMDC is a multi-mode DDR controller that supports DDR3/DDR3L x16/x32/x64
> > and LPDDR2 two channel x16/x32 memory types. MMDC is configurable, high
> > performance, and optimized. MMDC is present on i.MX6 Quad and i.MX6
> > QuadPlus devices, but this driver only supports i.MX6 Quad at the moment.
> > MMDC provides registers for performance counters which read via this
> > driver to help debug memory throughput and similar issues.
> >
> > $ perf stat -a -e mmdc/busy-cycles/,mmdc/read-accesses/,mmdc/read-bytes/,mmdc/total-cycles/,mmdc/write-accesses/,mmdc/write-bytes/ dd if=/dev/zero of=/dev/null bs=1M count=5000
> > Performance counter stats for 'dd if=/dev/zero of=/dev/null bs=1M count=5000':
> >
> >          898021787      mmdc/busy-cycles/
> >           14819600      mmdc/read-accesses/
> >             471.30 MB   mmdc/read-bytes/
> >         2815419216      mmdc/total-cycles/
> >           13367354      mmdc/write-accesses/
> >             427.76 MB   mmdc/write-bytes/
> >
> >        5.334757334 seconds time elapsed
> >
> > Signed-off-by: Zhengyu Shen <zhengyu.shen@nxp.com>
> > Signed-off-by: Frank Li <frank.li@nxp.com>
> 
> Shawn Guo:
> 
>          No new comments got more than 1 weeks.
>          Did you plan accept it?

@Mark, how do you think of this version?

Shawn
