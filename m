From: afzal@ti.com (Mohammed, Afzal)
Date: Tue, 19 Feb 2013 11:24:01 +0000
Subject: [PATCH, RFC 0/8] ARM: AM43 (OMAP2+) boot support
In-Reply-To: <51234F5C.6050500@ti.com>
References: <cover.1361186097.git.afzal@ti.com> <51234F5C.6050500@ti.com>
Message-ID: <C8443D0743D26F4388EA172BF4E2A7A93EAA8776@DBDE01.ent.ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Santosh,

On Tue, Feb 19, 2013 at 15:39:32, Shilimkar, Santosh wrote:

> After looking at the specs, you don't need the SMP mode since ACP
> isn't being used.

> TWD use for AM437x is also limited because these times stops in
> low power sates and there you will need broad-cast mechanism which
> again more of SMP machine feature.
> 
> So I suggest to use the wakeup timer(GPT1) clock-event instead
> of local timer for the mentioned reason.

Ok, all your remaining comments are w.r.t SMP and usage of TWD
as clock event.

I am not that familiar with SMP things, upon starting on AM43,
observing the fact that it is an SMP with one core configuration
and that as per ARM MP Core TRM it can have local timer, I saw
it as a ray of hope to get Kernel booting early without hwmod,
and I jumped on that idea which I feel was natural. Without
spending too much time on it, though of taking feedback on this
approach, resulting this rfc.

Let me understand more on SMP, TWD, and explore possibility
of using GPT1 instead of TWD for clock event.

>From the beginning I wondered on seeing that as per ARM TRM's
Cortex-A9 can be MP core with 1-4 core (instead of 2-4), while
another uniprocessor A9 configuration is present.

Regards
Afzal
