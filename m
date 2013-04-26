From: peterz@infradead.org (Peter Zijlstra)
Date: Fri, 26 Apr 2013 12:54:31 +0200
Subject: [RFC PATCH v3 5/6] sched: pack the idle load balance
In-Reply-To: <5176A932.5050506@linux.intel.com>
References: <1363955155-18382-1-git-send-email-vincent.guittot@linaro.org>
 <1363955155-18382-6-git-send-email-vincent.guittot@linaro.org>
 <1364302359.5053.21.camel@laptop>
 <CAKfTPtD=_oS5gJeynUG=ft-Y1zEdxZEMhUPH9hSXx+H2pi4xgA@mail.gmail.com>
 <1364308932.5053.46.camel@laptop>
 <CAKfTPtArtgkH5MU_xFAKjLDS-i32g2qQMdvyW=LLkG84tH8Hhg@mail.gmail.com>
 <5174CE96.3060805@linux.vnet.ibm.com>
 <CAKfTPtCCCifC=c+xjjnAH_HSqkR80PiQoddQKXPHuZwZawbvcA@mail.gmail.com>
 <5175F09E.1000304@intel.com> <5176A932.5050506@linux.intel.com>
Message-ID: <20130426105431.GF8669@dyad.programming.kicks-ass.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Apr 23, 2013 at 08:30:58AM -0700, Arjan van de Ven wrote:
> For x86 we should not be setting such flag then; we don't have a way for some cpu packages to
> go to an extra deep power state if they're completely idle.
> (this afaik is true for both Intel and AMD)

You say 'some'; this implies we do for others, right?

We can dynamically set the required flags in the arch setup when it makes sense.
