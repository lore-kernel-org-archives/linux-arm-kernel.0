From: lorenzo.pieralisi@arm.com (Lorenzo Pieralisi)
Date: Mon, 13 Jan 2014 17:33:20 +0000
Subject: [PATCH 1/4] arm64: topology: Implement basic CPU topology support
In-Reply-To: <CAKfTPtBKXgX7P+pAYv0h=amScM2zQydVkYd7XDOwaQxEDT0Fdw@mail.gmail.com>
References: <1389554441-27335-1-git-send-email-broonie@kernel.org>
 <1389554441-27335-2-git-send-email-broonie@kernel.org>
 <20140113161059.GA32720@e102568-lin.cambridge.arm.com>
 <CAKfTPtBKXgX7P+pAYv0h=amScM2zQydVkYd7XDOwaQxEDT0Fdw@mail.gmail.com>
Message-ID: <20140113173320.GB6934@e102568-lin.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Jan 13, 2014 at 04:44:06PM +0000, Vincent Guittot wrote:

[...]

> >> +extern struct cpu_topology cpu_topology[NR_CPUS];
> >> +
> >> +#define topology_physical_package_id(cpu)    (cpu_topology[cpu].socket_id)
> >> +#define topology_core_id(cpu)                (cpu_topology[cpu].core_id)
> >> +#define topology_core_cpumask(cpu)   (&cpu_topology[cpu].core_sibling)
> >> +#define topology_thread_cpumask(cpu) (&cpu_topology[cpu].thread_sibling)
> >> +
> >> +#define mc_capable() (cpu_topology[0].socket_id != -1)
> >> +#define smt_capable()        (cpu_topology[0].thread_id != -1)
> >
> > Are the two macros above still required in the kernel ? I can't see any
> > usage at present.
> >
> > Vincent, do you know why they were not removed in commit:
> >
> > 8e7fbcbc22c12414bcc9dfdd683637f58fb32759
> >
> > I am certainly missing something.
> 
> I think it was not planned to be used only by the scheduler but since
> 8e7fbcbc22c12414bcc9dfdd683637f58fb32759, we have reach a situation
> where nobody use them for the moment.

Ok, we can add the macros and eventually remove all of them in a later
patch if we think they must go then.

Lorenzo
