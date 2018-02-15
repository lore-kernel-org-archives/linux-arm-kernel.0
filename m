From: acme@kernel.org (Arnaldo Carvalho de Melo)
Date: Thu, 15 Feb 2018 11:58:33 -0300
Subject: [PATCH 1/2] perf tools: inject capabilitity for CoreSight traces
In-Reply-To: <CANLsYkz7c7vTFn3M17-=57C__yxcXbTyRLjgjLVBDvoQm6RV7w@mail.gmail.com>
References: <1518011845-24063-1-git-send-email-robert.walker@arm.com>
 <1518011845-24063-2-git-send-email-robert.walker@arm.com>
 <CANLsYkz7c7vTFn3M17-=57C__yxcXbTyRLjgjLVBDvoQm6RV7w@mail.gmail.com>
Message-ID: <20180215145833.GF30974@kernel.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Em Tue, Feb 13, 2018 at 03:18:02PM -0700, Mathieu Poirier escreveu:
> On 7 February 2018 at 06:57, Robert Walker <robert.walker@arm.com> wrote:
> > Added user space perf functionality to translate CoreSight traces into
> > instruction events with branch stack.
> >
> > To invoke the new functionality, use the perf inject
> > tool with --itrace=il. For example, to translate the ETM trace from
> > perf.data into last branch records in a new inj.data file:
> >
> >     $ perf inject --itrace=i100000il128 -i perf.data -o perf.data.new
> >
> > The 'i' parameter to itrace generates periodic instruction events.  The
> > period between instruction events can be specified as a number of
> > instructions suffixed by i (default 100000).
> > The parameter to 'l' specifies the number of entries in the branch stack
> > attached to instruction events.
> > The 'b' parameter to itrace generates events on taken branches.
> >
> > This patch also fixes the contents of the branch events used in perf report
> > - previously branch events were generated for each contiguous range of
> > instructions executed.  These are fixed to generate branch events between
> > the last address of a range ending in an executed branch instruction and
> > the start address of the next range.
> >
> > Based on patches by Sebastian Pop <s.pop@samsung.com> with additional fixes
> > and support for specifying the instruction period.
> >
> > Originally-by: Sebastian Pop <s.pop@samsung.com>
> > Signed-off-by: Robert Walker <robert.walker@arm.com>
> 
> Acked-by: Mathieu Poirier <mathieu.poirier@linaro.org>
> 
> Arnaldo - this should probably go through your tree but let me know if
> you want to proceed otherwise.

I can pick it, but now I'm waiting for Robert to address your comments,
so haven't processed none of these two.

- Arnaldo
 
> Robert - the work in coresight.txt should likely be published on its
> own.  That way Arnaldo doesn't have to worry about it.
