From: vaibhav.bedia@ti.com (Bedia, Vaibhav)
Date: Fri, 27 Jan 2012 08:39:28 +0000
Subject: [PATCH v1 3/3] ARM: tegra: cpuidle driver for tegra
In-Reply-To: <CAMbhsRQ00Cm-wo9hL9jRfpUfATPZc+znNJu-EagK6qV0qRs4SA@mail.gmail.com>
References: <1327594923-21822-1-git-send-email-pdeschrijver@nvidia.com>
 <1327594923-21822-4-git-send-email-pdeschrijver@nvidia.com>
 <B5906170F1614E41A8A28DE3B8D1214331791EA6@DBDE01.ent.ti.com>
 <CAMbhsRQ00Cm-wo9hL9jRfpUfATPZc+znNJu-EagK6qV0qRs4SA@mail.gmail.com>
Message-ID: <B5906170F1614E41A8A28DE3B8D1214331791FA2@DBDE01.ent.ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Jan 27, 2012 at 12:40:58, Colin Cross wrote:
> local_irq_enable() is required by the cpuidle call semantics.  See
> arch/arm/process.c, it has a 				WARN_ON(irqs_disabled()) after the
> idle function call.  The local_irq_disable() can and probably should
> be dropped, although a comment that the function is called with
> interrupts off and is expected to return with interrupts on would be
> helpful.
> 

Ah... I was too fixated on local_irq_disable() and local_irq_enable() in cpu_idle().
Thanks for clarifying.
