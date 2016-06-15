From: juri.lelli@arm.com (Juri Lelli)
Date: Wed, 15 Jun 2016 15:24:32 +0100
Subject: [PATCH v5 1/8] Documentation: arm: define DT cpu
 capacity-dmips-mhz bindings
In-Reply-To: <CAKfTPtBnwepf3gpR2zFXHvkaxB_mSiVM1Wv3RD+iuX72HN8bcg@mail.gmail.com>
References: <1465985877-18271-1-git-send-email-juri.lelli@arm.com>
 <1465985877-18271-2-git-send-email-juri.lelli@arm.com>
 <CAKfTPtBnwepf3gpR2zFXHvkaxB_mSiVM1Wv3RD+iuX72HN8bcg@mail.gmail.com>
Message-ID: <20160615142432.GE5981@e106622-lin>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 15/06/16 14:51, Vincent Guittot wrote:
> On 15 June 2016 at 12:17, Juri Lelli <juri.lelli@arm.com> wrote:

[...]

> > +==========================================
> > +ARM CPUs capacity bindings
> > +==========================================
> > +
> > +==========================================
> > +1 - Introduction
> > +==========================================
> > +
> > +ARM systems may be configured to have cpus with different power/performance
> > +characteristics within the same chip. In this case, additional information
> > +has to be made available to the kernel (the scheduler in particular) for
> 
> not sure that it's worth mentioning the scheduler in particular here
> 

OK. I can remove that bit.

> > +it to be aware of such differences and take decisions accordingly.
> > +

[...]

> > +==========================================
> > +3 - capacity-dmips-mhz
> > +==========================================
> > +
> > +capacity-dmips-mhz is an optional cpu node [1] property: u32 value
> > +representing CPU capacity expressed in normalized DMIPS/MHz. At boot time, the
> > +maximum frequency available to the cpu is then used to calculate the capacity
> > +value internally used by the kernel.
> > +
> > +capacity-dmips-mhz property is all-or-nothing: if it is specified for a cpu
> > +node, it has to be specified for every other cpu nodes, or the system will
> > +fall back to the default capacity value for every CPU. If cpufreq is not
> > +available, final capacities are calculated by directly using capacity-dmips-
> > +mhz values (normalized w.r.t. the highest value found while parsing the DT).
> 
> looks good to me
> 

Great! Thanks for reviewing this.

Best,

- Juri
