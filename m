From: jgunthorpe@obsidianresearch.com (Jason Gunthorpe)
Date: Tue, 2 Jul 2013 13:55:24 -0600
Subject: [PATCH v5 00/12] MBus DT binding: A new hope
In-Reply-To: <1372532655-20321-1-git-send-email-ezequiel.garcia@free-electrons.com>
References: <1372532655-20321-1-git-send-email-ezequiel.garcia@free-electrons.com>
Message-ID: <20130702195524.GA14547@obsidianresearch.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, Jun 29, 2013 at 04:04:03PM -0300, Ezequiel Garcia wrote:

> In the current proposal we have now required a 'controller' property
> to specify the MBus controller MMIO registers. To us this looks more
> appropriate, since the MBus registers are effectively located within
> the internal register region, behind the so-called internal-regs window.

Interesting, seems reasonable to me.

> Personally, I can't see any disadvantage, and the binding looks much
> cleaner now. But of course I can be wrong, and I'm open to discussion.
> 
> There's another pending issue. Arnd Bergmann has required to add a
> property to specify the available space within the CPU address space
> for decoding windows. This property would allow to support fully
> dynamic mbus window allocation.

I wonder if this range is implied - eg it is address space not covered
by the memory node or any mbus ranges? Is there a situation where that
is not sufficient?

> For now, this property is intentionally missing, and I expect that
> it can be added in the future, together with the full-dynamic MBus
> implementation.
> 
> @Arnd, @Jason: Given the v4 patchset didn't receive any comments but
> wasn't accepted either, I'd like to know which other pending issues
> I'm forgetting to address.

I took a quick look and it seems to match what was discussed..

Regards,
Jason
