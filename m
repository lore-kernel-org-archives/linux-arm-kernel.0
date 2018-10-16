From: jolsa@redhat.com (Jiri Olsa)
Date: Tue, 16 Oct 2018 12:47:22 +0200
Subject: [PATCH] perf tools: Store ids for events with their own cpus
 perf_event__synthesize_event_update_cpus
In-Reply-To: <d1cc40ee-4b09-35a8-86d2-bfc0eb78b9d5@huawei.com>
References: <20181002111621.GA6357@krava> <20181003113643.GA31725@krava>
 <594506a2-8cb3-3d09-82ab-5cb6d8c31ed0@huawei.com>
 <20181003141627.GA6341@krava> <20181003212052.GA32371@krava>
 <d071bb27-5533-da2f-9f8f-808183e04794@huawei.com>
 <20181009100049.GF6499@krava>
 <31101407-0bcd-2fbf-361e-43cbcb81cd19@huawei.com>
 <20181015191502.GA2398@kernel.org>
 <d1cc40ee-4b09-35a8-86d2-bfc0eb78b9d5@huawei.com>
Message-ID: <20181016104722.GA18450@krava>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Oct 16, 2018 at 10:10:20AM +0100, John Garry wrote:
> On 15/10/2018 20:15, Arnaldo Carvalho de Melo wrote:
> > Em Fri, Oct 12, 2018 at 02:25:49PM +0100, John Garry escreveu:
> > > On 09/10/2018 11:00, Jiri Olsa wrote:
> > > > On Thu, Oct 04, 2018 at 10:20:39AM +0100, John Garry wrote:
> > > > 
> > > > SNIP
> > > > 
> > > > > > We synthesize an update event that needs to touch the evsel
> > > > > > id array, which is not defined at that time. Fixing this by
> > > > > > forcing the id allocation for events with theeir own cpus.
> > > 
> > > /s/theeir/their/
> > > 
> > > > > > 
> > > > > > Reported-by: John Garry <john.garry@huawei.com>
> > > > > > Link: http://lkml.kernel.org/n/tip-8x4n7o34yheigoxm1jibflm6 at git.kernel.org
> > > > > 
> > > > > Tested-by: John Garry <john.garry@huawei.com>
> > > > > 
> > > > > In terms of adding to stable, LT v4.14 is not affected, but 4.18.x is.
> > > > > 
> > > > > Thanks,
> > > > > John
> > > > 
> > > > Arnaldo, could you please pick up this one
> > > > 
> > > 
> > > Just a friendly reminder on this patch.
> > > 
> > > How about re-send with an updated commit message also?
> > 
> > I'll fix up the commit message and apply, thanks.
> > 
> 
> Much appreciated.
> 
> BTW, I think that we should add a fixes tag. But I'm not sure if this patch
> fixes the commit I bisected to earlier (bfd8f72c2778f5bd63d), or that same
> commit just exposed some latent bug.
> 
> Jirka, Andi, Do you know?

yes, that commit moved it to record, which resulted in this fault

Arnaldo, could you please add:
Fixes: bfd8f72c2778 ("perf record: Synthesize unit/scale/... in event update")

thanks,
jirka
