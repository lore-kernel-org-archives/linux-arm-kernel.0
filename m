From: peterz@infradead.org (Peter Zijlstra)
Date: Wed, 27 Mar 2013 09:49:34 +0100
Subject: [RFC PATCH v3 5/6] sched: pack the idle load balance
In-Reply-To: <51527C17.3070901@intel.com>
References: <1363955155-18382-1-git-send-email-vincent.guittot@linaro.org>
 <1363955155-18382-6-git-send-email-vincent.guittot@linaro.org>
 <1364302359.5053.21.camel@laptop>
 <CAKfTPtD=_oS5gJeynUG=ft-Y1zEdxZEMhUPH9hSXx+H2pi4xgA@mail.gmail.com>
 <1364308932.5053.46.camel@laptop>
 <CAKfTPtDo3dmEZU-R62unQH9j5CxZWJj+Ws5CTBptOzTohkNJMA@mail.gmail.com>
 <51527C17.3070901@intel.com>
Message-ID: <1364374174.5053.59.camel@laptop>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, 2013-03-27 at 12:56 +0800, Alex Shi wrote:

> Just one buddy to pack tasks for whole level cpus definitely has
> scalability problem.

Right, but note we already have this scalability problem in the form of
the ILB. Some people were working on sorting that but then someone
changed jobs and I think it fell in some deep and dark crack.

Venki, Suresh?
