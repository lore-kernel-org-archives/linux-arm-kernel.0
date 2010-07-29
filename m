From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Thu, 29 Jul 2010 08:42:40 +0100
Subject: issue: insert kernel module failed with CONFIG_HIGHMEM enabled
In-Reply-To: <AANLkTi=SZVbAnBSZn_khGE4hZM9gsGr7H0whkBBU4TED@mail.gmail.com>
References: <AANLkTi=SZVbAnBSZn_khGE4hZM9gsGr7H0whkBBU4TED@mail.gmail.com>
Message-ID: <20100729074239.GA13756@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jul 28, 2010 at 03:17:53PM +0800, Chao Xie wrote:
> > I have compiled a module which will make use of graphics accelarate
> > function in PXA9XX. The module works fine when CONFIG_HIGHMEM is not
> > enabled. I can successfully insert the module. But when CONFIG_HIGHMEM is
> > enabled, i fail to insert this module, and it reports the error likes:
> >
> > graphics: relocation out of range, section 2 reloc 315 sym '__kmalloc'
> > Module len 32542 truncated

Please don't prefix your email body with '> ' - that's used to identify
quoted parts of emails.

Are you building the kernel and module using THUMB2?  Unfortunately,
these error messages don't tell me what type the failing relocation is.
