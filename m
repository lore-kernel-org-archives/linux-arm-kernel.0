From: jgunthorpe@obsidianresearch.com (Jason Gunthorpe)
Date: Mon, 3 Mar 2014 11:01:43 -0700
Subject: [PATCH 0/7] PCI irq mapping fixes and cleanups
In-Reply-To: <CAJ+vNU3UL+LTWnoxW7scAig19=z2xoYCA-HZ6a7GUyGEXtKK9Q@mail.gmail.com>
References: <1393608523-17509-1-git-send-email-l.stach@pengutronix.de>
 <CAJ+vNU2VN5haOU2GN5o7UUg9vgYh06pAhvDaoGw6EzTBEbD0mg@mail.gmail.com>
 <20140301183059.GA6315@obsidianresearch.com>
 <000601cf36b8$330b3a90$9921afb0$%han@samsung.com>
 <CAJ+vNU3UL+LTWnoxW7scAig19=z2xoYCA-HZ6a7GUyGEXtKK9Q@mail.gmail.com>
Message-ID: <20140303180143.GC31062@obsidianresearch.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Mar 03, 2014 at 09:49:52AM -0800, Tim Harvey wrote:

> I'm not clear why irq 20 is getting returned for all the slots with
> (slot%4)=0 and func=0.  If I start debugging of_irq_parse_pci() I see
> that it walks up the tree until it gets to the pcie host controller
> then calls of_irq_parse_raw() which is returning irq20 or -EINVAL.

Can you share your DT as well?

Jason
