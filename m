From: oleg@redhat.com (Oleg Nesterov)
Date: Mon, 26 Mar 2012 19:04:43 +0200
Subject: [PATCH v2.1 01/10] cpu: Introduce clear_tasks_mm_cpumask() helper
In-Reply-To: <1332748746.16159.62.camel@twins>
References: <20120324102609.GA28356@lizard> <20120324102751.GA29067@lizard>
 <1332593021.16159.27.camel@twins> <20120324164316.GB3640@lizard>
 <20120325174210.GA23605@redhat.com> <1332748746.16159.62.camel@twins>
Message-ID: <20120326170443.GA25229@redhat.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 03/26, Peter Zijlstra wrote:
>
> On Sun, 2012-03-25 at 19:42 +0200, Oleg Nesterov wrote:
> > __cpu_disable() is called by __stop_machine(), we know that nobody
> > can preempt us and other CPUs can do nothing.
>
> It would be very good to not rely on that though,

Yes, yes, perhaps I wasn't clear but I think the patches are fine.

> I would love to get
> rid of the stop_machine usage in cpu hotplug some day.

Interesting... Why? I mean, why do you dislike stop_machine() in
_cpu_down() ? Just curious.

Oleg.
