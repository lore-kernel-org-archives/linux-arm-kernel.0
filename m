From: peterz@infradead.org (Peter Zijlstra)
Date: Wed, 27 Mar 2013 15:13:54 +0100
Subject: [RFC PATCH v3 3/6] sched: pack small tasks
In-Reply-To: <20130327111855.GI801@MacBook-Pro.local>
References: <1363955155-18382-1-git-send-email-vincent.guittot@linaro.org>
 <1363955155-18382-4-git-send-email-vincent.guittot@linaro.org>
 <1364301998.5053.17.camel@laptop> <5151BEF2.9090100@linux.intel.com>
 <1364373980.5053.57.camel@laptop>
 <CAKfTPtAox+h0YmpP6W==hJ5FaNzDfF8bQmadmU86MrfnJt67QQ@mail.gmail.com>
 <1364374820.5053.63.camel@laptop> <20130327111855.GI801@MacBook-Pro.local>
Message-ID: <1364393634.5053.71.camel@laptop>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, 2013-03-27 at 11:18 +0000, Catalin Marinas wrote:
> On Wed, Mar 27, 2013 at 09:00:20AM +0000, Peter Zijlstra wrote:
> > On Wed, 2013-03-27 at 09:54 +0100, Vincent Guittot wrote:
> > > It's not mandatory to have little cores on low numbers even if it's
> > > advised
> > 
> > ARGH!
> 
> I haven't followed this thread closely, so just a random comment from
> me. An argument from some is that they want to boot Linux on the big CPU
> to be quicker. The most convenient is to have the big CPU at 0.

I suppose that's almost sensible ;-) I just despair at the amount of
variation that's allowed.

I'm guessing that swapping cpus in the bootloader or someplace really
early is equally hard in that we (Linux) assume we boot on cpu 0 or
something like that?
