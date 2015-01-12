From: kirill@shutemov.name (Kirill A. Shutemov)
Date: Mon, 12 Jan 2015 13:37:22 +0200
Subject: Linux 3.19-rc3
In-Reply-To: <10028397.kdbz8TfPck@wuerfel>
References: <CA+55aFwsxoyLb9OWMSCL3doe_cz_EQtKsEFCyPUYn_T87pbz0A@mail.gmail.com>
 <4665410.x9Uu42bKmJ@wuerfel>
 <CA+55aFxphoLdFkwkVFQ87Q8EbYNqFAE-n0yTvCSOJzSO2MtDgw@mail.gmail.com>
 <10028397.kdbz8TfPck@wuerfel>
Message-ID: <20150112113722.GC16935@node.dhcp.inet.fi>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, Jan 10, 2015 at 10:36:13PM +0100, Arnd Bergmann wrote:
> On Saturday 10 January 2015 13:00:27 Linus Torvalds wrote:
> > so I feel pretty confident in saying it won't happen. It's just too
> > much of a bother, for little to no actual upside. It's likely a much
> > better approach to try to instead use THP for anonymous mappings.
> 
> arm64 already supports 2MB transparent hugepages. I guess it
> wouldn't be too hard to change it so that an existing hugepage
> on an anonymous mapping that gets split up into 4KB pages gets
> split along 64KB boundaries with the contiguous mapping bit set.

What you are talking about is in fact multi-level transparent huge page
support: you need to couple 4k pages into 64k to avoid breaking them apart
by compactation or migration or whatever.

That definetely would not make THP code simplier.

> Having full support for multiple hugepage sizes (64KB, 2MB and 32MB
> in case of ARM64 with 4KB PAGE_SIZE) would be even better and
> probably negate any benefits of 64KB PAGE_SIZE, but requires more
> changes to common mm code.
> 
> 	Arnd

-- 
 Kirill A. Shutemov
