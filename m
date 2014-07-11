From: thierry.reding@gmail.com (Thierry Reding)
Date: Fri, 11 Jul 2014 15:01:59 +0200
Subject: [PATCH 3/3] arm64: Use include/asm-generic/io.h
In-Reply-To: <201407111458.09884.arnd@arndb.de>
References: <1404918699-17284-1-git-send-email-thierry.reding@gmail.com>
 <201407101514.16530.arnd@arndb.de> <20140711121923.GE11473@arm.com>
 <201407111458.09884.arnd@arndb.de>
Message-ID: <20140711130158.GA10827@ulmo>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Jul 11, 2014 at 02:58:09PM +0200, Arnd Bergmann wrote:
> On Friday 11 July 2014, Catalin Marinas wrote:
> > ioread32() is indeed an alias for readl on arm64 but if the address it
> > gets as argument looks like an I/O port, it adds PCI_IOBASE (via the inl
> > macro). This would no longer happen with Thierry's patches.
> > 
> > So I guess that for this patch to work, we also need ioport_map() to
> > return an address from the PCI_IOBASE range. Should we merge this now as
> > well:
> > 
> > http://linux-arm.org/git?p=linux-ld.git;a=commitdiff;h=3423064d8e42a38164a8436bcdf7434cf9cd2192
> 
> This is also part of patch 1/3 in Thierry's series.

The hunk in my patch 1/3 is missing the "& IO_SPACE_LIMIT", I can respin
and include that.

Thierry
-------------- next part --------------
A non-text attachment was scrubbed...
Name: not available
Type: application/pgp-signature
Size: 819 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20140711/d9292bd8/attachment.sig>
