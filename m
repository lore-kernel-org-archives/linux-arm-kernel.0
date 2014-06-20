From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Fri, 20 Jun 2014 16:23:36 +0100
Subject: A clockevent IRQ delivery question
In-Reply-To: <CAJgR-Bj+tgCpKTT7FxM-1JMvN7CKUgpaikfbXPQx5ep6+7W2mA@mail.gmail.com>
References: <CAJgR-BjUpaR0cxew+-fz5YcDu0VKzim-rhLF4j1hEnR_4O+Jsg@mail.gmail.com>
 <53A446C0.10200@linaro.org>
 <CAJgR-Bj+tgCpKTT7FxM-1JMvN7CKUgpaikfbXPQx5ep6+7W2mA@mail.gmail.com>
Message-ID: <20140620152335.GT32514@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Jun 20, 2014 at 10:18:58AM -0500, Jon Loeliger wrote:
> > There was a notifier for cpu bootup but Thomas added a force affinity api,
> > so even if the cpu is not in the online mask, the irq is correctly set
> > (commit 30ccf03b).
> 
> Ah, I see.  I'll track that commit down.  Thanks.

Note that there is an outstanding bug report that the IRQ affinity
forcing breaks CPU hotplug... which would be a regression.  Linus'
policy is that if a bug fix causes a new regression, then the bug
fix is wrong and needs to be reverted.

So... don't hang your hopes on this just yet... the "fix" for this
_has_ caused a regression elsewhere, and we need to sort out what
we're doing about that first.

-- 
FTTC broadband for 0.8mile line: now at 9.7Mbps down 460kbps up... slowly
improving, and getting towards what was expected from it.
