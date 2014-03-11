From: peterz@infradead.org (Peter Zijlstra)
Date: Tue, 11 Mar 2014 14:17:19 +0100
Subject: [RFC 0/6] rework sched_domain topology description
In-Reply-To: <531B0FDA.2040302@arm.com>
References: <1394003906-11630-1-git-send-email-vincent.guittot@linaro.org>
 <5317B092.7070805@arm.com>
 <CAKfTPtDGbT717Y5F1GoBgr4pnvApG5Gphu2Me_bAFrM0+qsfAg@mail.gmail.com>
 <53186A8A.9060406@arm.com>
 <CAKfTPtCspVk+X3O23ikTt3MZUHVrrp21PyhmrcLF-GwW3OjOqA@mail.gmail.com>
 <531B0FDA.2040302@arm.com>
Message-ID: <20140311131719.GY9987@twins.programming.kicks-ass.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, Mar 08, 2014 at 12:40:58PM +0000, Dietmar Eggemann wrote:
> >
> >I don't have a strong opinion about using or not a cpu argument for
> >setting the flags of a level (it was part of the initial proposal
> >before we start to completely rework the build of sched_domain)
> >Nevertheless, I see one potential concern that you can have completely
> >different flags configuration of the same sd level of 2 cpus.
> 
> Could you elaborate a little bit further regarding the last sentence? Do you
> think that those completely different flags configuration would make it
> impossible, that the load-balance code could work at all at this sd?

So a problem with such an interfaces is that is makes it far too easy to
generate completely broken domains.

You can, for two cpus in the same domain provide, different flags; such
a configuration doesn't make any sense at all.

Now I see why people would like to have this; but unless we can make it
robust I'd be very hesitant to go this route.
