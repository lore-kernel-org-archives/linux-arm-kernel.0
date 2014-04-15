From: davem@davemloft.net (David Miller)
Date: Tue, 15 Apr 2014 15:53:30 -0400 (EDT)
Subject: [RFC PATCH] uprobes: copy to user-space xol page with proper
 cache flushing
In-Reply-To: <534D8AE6.3090609@linaro.org>
References: <534D6A1F.70102@linaro.org> <20140415174330.GA10558@redhat.com>
 <534D8AE6.3090609@linaro.org>
Message-ID: <20140415.155330.2253279045572024595.davem@davemloft.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: David Long <dave.long@linaro.org>
Date: Tue, 15 Apr 2014 15:39:18 -0400

> Yes, I have that coded for 14 out of 24 architectures (the easy
> ones). The remaining ones need more work.  Some may prove problematic.
> The whole approach could yet prove impractical.  More recent suggested
> approaches may be better too (or Linus's relatively simple change).

BTW, another reason perhaps to write directly to userspace and have
a uprobes_*() specific interface is that you'll only need to do
3 architectures, the ones that support uprobes.

That way, this is just part of what every arch needs to implement in
order to support uprobes.
