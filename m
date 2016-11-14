From: vinod.koul@intel.com (Vinod Koul)
Date: Mon, 14 Nov 2016 10:42:16 +0530
Subject: [PATCH v10 03/11] remoteproc: Update Kconfig setup to 'depends
 on REMOTEPROC'
In-Reply-To: <20161103212439.GS25787@tuxbot>
References: <1475931154-1021-1-git-send-email-peter.griffin@linaro.org>
 <1475931154-1021-4-git-send-email-peter.griffin@linaro.org>
 <20161103212439.GS25787@tuxbot>
Message-ID: <20161114051215.GV3000@localhost>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Nov 03, 2016 at 02:24:39PM -0700, Bjorn Andersson wrote:
> On Sat 08 Oct 05:52 PDT 2016, Peter Griffin wrote:
> 
> > Make REMOTEPROC core a selectable kconfig option, and update
> > remoteproc client drivers to 'depends on' the core. This avoids
> > some nasty Kconfig recursive dependency issues. Also when using
> > menuconfig client drivers will be hidden until the core has been
> > enabled.
> > 
> > Documentation/kbuild/kconfig-language.txt:
> > 
> >   Note:
> >         select should be used with care. select will force
> >         a symbol to a value without visiting the dependencies.
> >         By abusing select you are able to select a symbol FOO even
> >         if FOO depends on BAR that is not set.
> >         In general use select only for non-visible symbols
> >         (no prompts anywhere) and for symbols with no dependencies.
> >         That will limit the usefulness but on the other hand avoid
> >         the illegal configurations all over.
> > 
> > Signed-off-by: Peter Griffin <peter.griffin@linaro.org>
> 
> Sorry, I missed this patch in the set - but spotted it in linux-next.
> 
> I still don't like the change, but remoteproc has dependencies so I
> guess I have to pick it until we fix that.
> 
> It's however not okay to take this patch through the DMA tree, as it
> effectively stops me from introducing any changes in the rproc tree.
> Further more, it's not based on v4.9, so it currently introduces another
> Kconfig dependency problem - that I can't fix in my tree without
> conflicting with Vinod's.
> 
> 
> So, Vinod, can you please drop this patch from your tree? I'll pick it
> up for now.

Sorry for the delay, b/w KS/LPC and travel, was slow on email.

I have dropped this one now..

-- 
~Vinod
