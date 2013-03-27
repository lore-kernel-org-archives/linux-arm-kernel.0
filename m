From: alex.shi@intel.com (Alex Shi)
Date: Wed, 27 Mar 2013 21:32:30 +0800
Subject: [RFC PATCH v3 5/6] sched: pack the idle load balance
In-Reply-To: <CAKfTPtD0zYuskipbvukVWRh5rzqTaBiHsuMR8cBwmYieP=v=mQ@mail.gmail.com>
References: <1363955155-18382-1-git-send-email-vincent.guittot@linaro.org>
 <1363955155-18382-6-git-send-email-vincent.guittot@linaro.org>
 <1364302359.5053.21.camel@laptop>
 <CAKfTPtD=_oS5gJeynUG=ft-Y1zEdxZEMhUPH9hSXx+H2pi4xgA@mail.gmail.com>
 <1364308932.5053.46.camel@laptop>
 <CAKfTPtDo3dmEZU-R62unQH9j5CxZWJj+Ws5CTBptOzTohkNJMA@mail.gmail.com>
 <51527C17.3070901@intel.com>
 <CAKfTPtDK6vSDhGa9=ReaHt_oO8Xz2agZZ4x3q5Wvv6gXjhFevg@mail.gmail.com>
 <5152B215.2040808@intel.com>
 <CAKfTPtD0zYuskipbvukVWRh5rzqTaBiHsuMR8cBwmYieP=v=mQ@mail.gmail.com>
Message-ID: <5152F4EE.5000104@intel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 03/27/2013 06:30 PM, Vincent Guittot wrote:
>> Arguing the performance/power balance does no much sense without
>> > detailed scenario. We just want to seek a flexible compromise way.
>> > But fixed buddy cpu is not flexible. and it may lose many possible
>> > powersaving fit scenarios on x86 system. Like if 2 SMT cpu can handle
>> > all tasks, we don't need to wake another core. or if 2 cores in one
>> > socket can handle tasks, we also don't need to wakeup another socket.
> Using 2 SMT for all tasks implies to accept latency and to share
> resources like cache and memory bandwidth so it means that you also
> accept some potential performance decrease which implies that someone
> must select this mode with a knob.
> The primary goal of the patchset is not to select between powersaving
> and performance but to stay in performance mode. We pack the small
> tasks in one CPU so the performance will not decrease but the low load
> scenario will consume less power. Then, I can add another step which
> will be more power saving aggressive with a potential cost of
> performance and i this case the buddy CPU will be updated dynamically
> according to the system load
> 

Predication of small task behavior is often wrong. so for performance
purpose, packing task is a bad idea.

-- 
Thanks
    Alex
