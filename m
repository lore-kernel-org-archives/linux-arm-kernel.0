From: oleg@redhat.com (Oleg Nesterov)
Date: Wed, 17 Oct 2012 19:02:11 +0200
Subject: [PATCH 2/9] uprobes: check for single step support
In-Reply-To: <20121017164059.GF11096@linux.vnet.ibm.com>
References: <1350242593-17761-1-git-send-email-rabin@rab.in>
 <1350242593-17761-2-git-send-email-rabin@rab.in>
 <20121017164059.GF11096@linux.vnet.ibm.com>
Message-ID: <20121017170211.GA10864@redhat.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 10/17, Srikar Dronamraju wrote:
>
> * Rabin Vincent <rabin@rab.in> [2012-10-14 21:23:06]:
>
> >  void __weak arch_uprobe_enable_step(struct arch_uprobe *arch)
> >  {
> > -	user_enable_single_step(current);
> > +	if (arch_has_single_step())
> > +		user_enable_single_step(current);
> >  }
> >
> >  void __weak arch_uprobe_disable_step(struct arch_uprobe *arch)
>
> This change is fine. But I am wondering if should have a dummy
> arch_uprobe_enable_step / arch_uprobe_disable_step in uprobes ARM.

Or, better, we can kill it. We wertr going to do this anyway, we were
waiting for powerpc port.

Just I do not know how this change should be routed, it should update
both x86/powerpc.

Or do you think arch_uprobe_enable_step() still makes any sense?

Oleg.
