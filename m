From: khilman@ti.com (Kevin Hilman)
Date: Tue, 03 Jan 2012 16:41:27 -0800
Subject: [PATCH 0/3] coupled cpuidle state support
In-Reply-To: <1324426147-16735-1-git-send-email-ccross@android.com> (Colin
 Cross's message of "Tue, 20 Dec 2011 16:09:04 -0800")
References: <1324426147-16735-1-git-send-email-ccross@android.com>
Message-ID: <87sjjw70zs.fsf@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Colin Cross <ccross@android.com> writes:


> This patch series implements an alternative solution, where each
> cpu will wait in the WFI state until all cpus are ready to enter
> a coupled state, at which point the coupled state function will
> be called on all cpus at approximately the same time.

This looks great, and is certainly preferred to hotplug IMO.

[...]

> None of the platforms I work with have an SMP idle implementation
> upstream, so I can't easily show a patch that converts a platform
> from hotplug governor to coupled cpuidle states.  

Basic OMAP4 CPUidle support is in now queued for v3.3 (see omap4
branch Tony's tree[1].)  

Can you (or Santosh) send a patch that adds coupled support to that
driver so it can see some broader testing on OMAP4?

Thanks,

Kevin

[1] git://git.kernel.org/pub/scm/linux/kernel/git/tmlind/linux-omap.git
