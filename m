From: arnd@arndb.de (Arnd Bergmann)
Date: Thu, 28 Apr 2011 16:16:40 +0200
Subject: ARM unaligned MMIO access with attribute((packed))
In-Reply-To: <Pine.LNX.4.44L0.1104280934080.2108-100000@iolanthe.rowland.org>
References: <Pine.LNX.4.44L0.1104280934080.2108-100000@iolanthe.rowland.org>
Message-ID: <201104281616.40253.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thursday 28 April 2011, Alan Stern wrote:
> > The compiler does not complain, it just silently assumes that it needs
> > to do byte accesses. There is no way to tell the compiler to ignore
> > what it knows about the alignment, other than using inline assembly
> > for the actual pointer dereference. Most architectures today do that,
> > but on ARM it comes down to "*(u32 *)status_reg = temp".
> 
> Ah -- so the compiler associates the alignment attribute with the data 
> value and not with the variable's type?  I didn't know that.

The behavior here is unspecified because the underlying typecase
is not valid. Gcc apparently uses some heuristics trying to do
the right thing, and in recent versions that heuristic seems to
have changed.

	Arnd
