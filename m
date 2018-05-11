From: leo.yan@linaro.org (Leo Yan)
Date: Sat, 12 May 2018 07:29:53 +0800
Subject: [PATCH RESEND v2 1/2] perf cs-etm: Support unknown_thread in
 cs_etm_auxtrace
In-Reply-To: <20180511134800.GO13491@kernel.org>
References: <1525924920-4381-1-git-send-email-leo.yan@linaro.org>
 <20180511134800.GO13491@kernel.org>
Message-ID: <20180511232953.GA28378@leoy-ThinkPad-X240s>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, May 11, 2018 at 10:48:00AM -0300, Arnaldo Carvalho de Melo wrote:
> Em Thu, May 10, 2018 at 12:01:59PM +0800, Leo Yan escreveu:
> > CoreSight doesn't allocate thread structure for unknown_thread in etm
> > auxtrace, so unknown_thread is NULL pointer.  If the perf data doesn't
> > contain valid tid and then cs_etm__mem_access() uses unknown_thread
> > instead as thread handler, this results in segmentation fault when
> > thread__find_addr_map() accesses thread handler.
> > 
> > This commit creates new thread data which is used by unknown_thread, so
> > CoreSight tracing can roll back to use unknown_thread if perf data
> > doesn't include valid thread info.  This commit also releases thread
> > data for initialization failure case and for normal auxtrace free flow.
> > 
> > Signed-off-by: Leo Yan <leo.yan@linaro.org>
> > Acked-by: Mathieu Poirier <mathieu.poirier@linaro.org>
> 
> Thanks, applied to perf/urgent.
> 
> And please use a more descriptive, eye catching summary, something like:
> 
>   perf cs-etm: Fix segfault when accessing NULL unknown_thread variable
> 
> :-)

Thanks for suggestion.  Indeed, this patch is a fix rather than
a new feature, subject should reflect it.

Thanks,
Leo Yan
