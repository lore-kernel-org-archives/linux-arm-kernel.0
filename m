From: kirill@shutemov.name (Kirill A. Shutemov)
Date: Wed, 10 Dec 2014 13:05:56 +0200
Subject: [RFC] mm:fix zero_page huge_zero_page rss/pss statistic
In-Reply-To: <35FD53F367049845BC99AC72306C23D103E688B31403@CNBJMBX05.corpusers.net>
References: <35FD53F367049845BC99AC72306C23D103E688B313EE@CNBJMBX05.corpusers.net>
 <CALYGNiOuBKz8shHSrFCp0BT5AV6XkNOCHj+LJedQQ-2YdZtM7w@mail.gmail.com>
 <35FD53F367049845BC99AC72306C23D103E688B313F2@CNBJMBX05.corpusers.net>
 <20141205143134.37139da2208c654a0d3cd942@linux-foundation.org>
 <35FD53F367049845BC99AC72306C23D103E688B313F4@CNBJMBX05.corpusers.net>
 <20141208114601.GA28846@node.dhcp.inet.fi>
 <35FD53F367049845BC99AC72306C23D103E688B313FB@CNBJMBX05.corpusers.net>
 <35FD53F367049845BC99AC72306C23D103E688B31403@CNBJMBX05.corpusers.net>
Message-ID: <20141210110556.GA10630@node.dhcp.inet.fi>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Dec 10, 2014 at 03:22:21PM +0800, Wang, Yalin wrote:
> smaps_pte_entry() doesn't ignore zero_huge_page,
> but it ignore zero_page, because vm_normal_page() will
> ignore it. We remove vm_normal_page() call, because walk_page_range()
> have ignore VM_PFNMAP vma maps, it's safe to just use pfn_valid(),
> so that we can also consider zero_page to be a valid page.

We fixed huge zero page accounting in smaps recentely. See mm tree.

-- 
 Kirill A. Shutemov
