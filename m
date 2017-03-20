From: dwmw2@infradead.org (David Woodhouse)
Date: Mon, 20 Mar 2017 14:07:38 +0000
Subject: [PATCH v2] arm64: pci: add support for pci_mmap_page_range
In-Reply-To: <20170320131836.GM17263@arm.com>
References: <1460581856-12380-1-git-send-email-jerin.jacob@caviumnetworks.com>
 <29393988.imklgXkpJX@wuerfel> <20160418152126.GA3154@localhost.localdomain>
 <4342694.H5cy8vaG9k@wuerfel> <1489611696.4195.186.camel@infradead.org>
 <20170320131836.GM17263@arm.com>
Message-ID: <1490018858.5036.19.camel@infradead.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, 2017-03-20 at 13:18 +0000, Will Deacon wrote:
> > The thing is, this *isn't* an architecture-specific interface where you
> > get a clean slate. It's a cross-platform interface. Legacy and horrid,
> > sure. But it does you no harm.

> I don't agree with that: it provides (privileged) userspace with a way to
> map non-prefetchable BARs using write-combining memory attributes, which
> could lead to mismatched memory attributes against a kernel mapping of the
> same BAR and is something that you can't achieve using the sysfs API.

I think that's just a bug. I'll add it to my list. We shouldn't be
allowing a WC mapping on a non-prefetchable resource, should we?

For that matter, I think it allows you mmap a range of MMIO addresses
that correspond to an I/O BAR, and on platforms which allow
pci_mmap_io, the converse. That seems... suboptimal.
?
> > What *else* don't you like having in /proc? Shall we have a clean slate
> > and eliminate *everything* other than actual processes from /proc for
> > the next architecture we add to the tree? If not, why not?
> It's not about what we like and don't like in /proc, it's about not
> promoting legacy that we don't need. If somebody actually needs the /proc
> interface, fine, we can support it. But all the people asking for this have
> been concerned solely about the sysfs interface, so I'd just like the two
> divorced from each other so that we can provide what people are asking for
> without pulling in a deprecated interface at the same time.
> 
> This should be straightforward.

Sure, but fairly much orthogonal. I'll roll it in. It's fairly much in
the noise now I'm this far down the rabbithole...
-------------- next part --------------
A non-text attachment was scrubbed...
Name: smime.p7s
Type: application/x-pkcs7-signature
Size: 4938 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20170320/fb220219/attachment.bin>
