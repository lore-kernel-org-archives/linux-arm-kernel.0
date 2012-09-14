From: catalin.marinas@arm.com (Catalin Marinas)
Date: Fri, 14 Sep 2012 18:29:45 +0100
Subject: [PATCH v2 13/31] arm64: Device specific operations
In-Reply-To: <20120815003355.GF19607@quad.lixom.net>
References: <1344966752-16102-1-git-send-email-catalin.marinas@arm.com>
 <1344966752-16102-14-git-send-email-catalin.marinas@arm.com>
 <20120815003355.GF19607@quad.lixom.net>
Message-ID: <20120914172944.GB2927@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

(revisiting unanswered emails :))

On Wed, Aug 15, 2012 at 01:33:55AM +0100, Olof Johansson wrote:
> On Tue, Aug 14, 2012 at 06:52:14PM +0100, Catalin Marinas wrote:
> > +/*
> > + *  I/O port access primitives.
> > + */
> > +#define IO_SPACE_LIMIT		0xffff
> > +
> > +/*
> > + * We currently don't have any platform with PCI support, so just leave this
> > + * defined to 0 until needed.
> > + */
> > +#define PCI_IOBASE		((void __iomem *)0)
> 
> You could just leave out the PCI / I/O code alltogether instead.

I would leave this in as some of the first platforms to appear will have
PCIe. At some point we'll add a fixed address where the PCI_IOBASE is
mapped.

-- 
Catalin
