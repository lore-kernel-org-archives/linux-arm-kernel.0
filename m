From: davem@davemloft.net (David Miller)
Date: Tue, 15 Apr 2014 13:50:38 -0400 (EDT)
Subject: [RFC PATCH] uprobes: copy to user-space xol page with proper
 cache flushing
In-Reply-To: <20140415174900.GA11184@redhat.com>
References: <534D6A1F.70102@linaro.org>
 <20140415.133840.2270952586596479547.davem@davemloft.net>
 <20140415174900.GA11184@redhat.com>
Message-ID: <20140415.135038.1703628429468655272.davem@davemloft.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Oleg Nesterov <oleg@redhat.com>
Date: Tue, 15 Apr 2014 19:49:00 +0200

> We do not want to write to, say, page cache if the probed application
> mmaps a file at the same vaddr.

If user has write access to that page... not our problem.

And if he doesn't we'll fault.
