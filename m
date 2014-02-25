From: msalter@redhat.com (Mark Salter)
Date: Tue, 25 Feb 2014 13:45:42 -0500
Subject: [PATCH v4 0/6] generic early_ioremap support
In-Reply-To: <20140225183012.GA27164@mudshark.cambridge.arm.com>
References: <1392238575-10000-1-git-send-email-msalter@redhat.com>
 <1393337404.7307.51.camel@deneb.redhat.com>
 <20140225183012.GA27164@mudshark.cambridge.arm.com>
Message-ID: <1393353942.26583.10.camel@deneb.redhat.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, 2014-02-25 at 18:30 +0000, Will Deacon wrote:
> I'd suggest spitting the core part out from the arch-specific parts. That
> way, the core part can merged independently and architectures can move over
> as they see fit. It also signals (at least to me) that, "hey, I should
> probably review this" whilst my current stance is "there's a whole load of
> stuff under mm/ that needs to be acked first".
> 
> If you put the whole thing into next, you just run the risk of conflicts
> with all the arch trees.

I've been thinking of breaking out the common bits and x86 bits and just
going with that for now. There's no point in just doing the common bits
because it won't get tested without at least one architecture using it.
