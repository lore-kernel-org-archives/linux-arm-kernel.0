From: morten.rasmussen@arm.com (Morten Rasmussen)
Date: Tue, 15 Jul 2014 10:32:34 +0100
Subject: [PATCH v3 09/12] Revert "sched: Put rq's sched_avg under
 CONFIG_FAIR_GROUP_SCHED"
In-Reply-To: <CAKfTPtDeTnPVM5nFR19eWRQZMtAZ3B2dB36q4qGNH=URgfLfHw@mail.gmail.com>
References: <1404144343-18720-1-git-send-email-vincent.guittot@linaro.org>
 <1404144343-18720-10-git-send-email-vincent.guittot@linaro.org>
 <20140710131646.GB3935@laptop>
 <CAKfTPtDzxyrzVmX016VB8j_y19wcCBVB1Rj46FYngMA+Ajft6g@mail.gmail.com>
 <20140711161344.GD26542@e103034-lin>
 <CAKfTPtDeTnPVM5nFR19eWRQZMtAZ3B2dB36q4qGNH=URgfLfHw@mail.gmail.com>
Message-ID: <20140715093234.GA8700@e103034-lin>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jul 15, 2014 at 10:27:19AM +0100, Vincent Guittot wrote:
> On 11 July 2014 18:13, Morten Rasmussen <morten.rasmussen@arm.com> wrote:
> 
> [snip]
> 
> >
> > In this example using rq->avg leads to imbalance whereas unweighted load
> > would not. Correct me if I missed anything.
> 
> You just miss to take into account how the imbalance is computed

I don't think so. I'm aware that the imbalance is calculated based on
the runnable_load_avg of the cpus. But if you pick the wrong cpus to
compare to begin with, it doesn't matter.

Morten
