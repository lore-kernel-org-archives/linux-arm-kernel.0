From: omycle@gmail.com (Li Haifeng)
Date: Sun, 10 Jun 2012 18:42:59 +0800
Subject: When switch_mm with thread migration, Why flush instruction cache ?
Message-ID: <CAFNq8R590f8ePVE6pO6-xAnuJ_OZMx1g96Wj6DA7=QRwu562BQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Can someone tell me why flush instruction cache @118 Line below, when
switch_mm with thread migration from other ARM core.

107 static inline void
108 switch_mm(struct mm_struct *prev, struct mm_struct *next,
109           struct task_struct *tsk)
110 {
111 #ifdef CONFIG_MMU
112         unsigned int cpu = smp_processor_id();
113
114 #ifdef CONFIG_SMP
115         /* check for possible thread migration */
116         if (!cpumask_empty(mm_cpumask(next)) &&
117             !cpumask_test_cpu(cpu, mm_cpumask(next)))
118                 __flush_icache_all();
119 #endif
...
130 #endif
131 }
-------------- next part --------------
An HTML attachment was scrubbed...
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20120610/bf2ccd4d/attachment.html>
