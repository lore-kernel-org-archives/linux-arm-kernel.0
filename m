From: richard@nod.at (Richard Weinberger)
Date: Mon, 23 Apr 2012 16:57:54 +0200
Subject: [PATCH 7/9] um: Should hold tasklist_lock while traversing
 processes
In-Reply-To: <20120423070925.GG30752@lizard>
References: <20120423070641.GA27702@lizard> <20120423070925.GG30752@lizard>
Message-ID: <4F956DF2.7020408@nod.at>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 23.04.2012 09:09, Anton Vorontsov wrote:
> Traversing the tasks requires holding tasklist_lock, otherwise it
> is unsafe.
>
> p.s. However, I'm not sure that calling os_kill_ptraced_process()
> in the atomic context is correct. It seem to work, but please
> take a closer look.
>
> Signed-off-by: Anton Vorontsov<anton.vorontsov@linaro.org>
> ---

You forgot my Ack and I've already explained why 
os_kill_ptraced_process() is fine.

Thanks,
//richard
