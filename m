From: leo.yan@linaro.org (Leo Yan)
Date: Thu, 10 May 2018 11:56:18 +0800
Subject: [PATCH v2 1/2] perf cs-etm: Support unknown_thread in
 cs_etm_auxtrace
In-Reply-To: <20180509155150.GC25559@xps15>
References: <1525839312-20544-1-git-send-email-leo.yan@linaro.org>
 <20180509155150.GC25559@xps15>
Message-ID: <20180510035618.GD12205@leoy-ThinkPad-X240s>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, May 09, 2018 at 09:51:50AM -0600, Mathieu Poirier wrote:
> On Wed, May 09, 2018 at 12:15:11PM +0800, Leo Yan wrote:
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
> 
> Hi Leo,
> 
> Arnaldo maintains the perf tools and he receives dozens of patches every day.
> If his name is not the first one to appear on the "To:" list, it is unlikely
> that his email filters will catch your patches.

Thanks for reminding, Mathieu.  Will resend patches for this.

Thanks,
Leo Yan
