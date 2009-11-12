From: pavel@ucw.cz (Pavel Machek)
Date: Thu, 12 Nov 2009 11:19:02 +0100
Subject: drivers/video/msm: update to new kernel
In-Reply-To: <20091103161733.970b885f.akpm@linux-foundation.org>
References: <20091022085639.GA30548@elf.ucw.cz>
	<20091103161733.970b885f.akpm@linux-foundation.org>
Message-ID: <20091112101902.GA11980@elf.ucw.cz>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue 2009-11-03 16:17:33, Andrew Morton wrote:
> On Thu, 22 Oct 2009 10:56:39 +0200
> Pavel Machek <pavel@ucw.cz> wrote:
> 
> > TASK_INTERRUPTIBLE and friends are now only available after including
> > <linux/sched.h>, so include it when needed.
> > 
> > bus_id is no longer available/neccessary, so remove that.
> > 
> > Android pmem driver is not available in mainline, so remove its hooks
> > from drivers/video.
> > 
> 
> What is the impact of these changes?
> 
> #2 looks like it's a build fix.  #3 looks like it isn't a build fix. 
> #1 is a mystery.

Well, it now compiles. #1... I guess something changed in arm headers
and explicit include of <linux/sched.h> became neccessary. #3 not all
usages of pmem were protected with #ifdef ...PMEM, breaking
compilation. And as PMEM is not in mainline, it seemed right to just
remove it.
									Pavel
-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
