From: Yalin.Wang@sonymobile.com (Wang, Yalin)
Date: Fri, 12 Dec 2014 09:59:15 +0800
Subject: [RFC] mm:fix zero_page huge_zero_page rss/pss statistic
In-Reply-To: <20141210110556.GA10630@node.dhcp.inet.fi>
References: <35FD53F367049845BC99AC72306C23D103E688B313EE@CNBJMBX05.corpusers.net>
 <CALYGNiOuBKz8shHSrFCp0BT5AV6XkNOCHj+LJedQQ-2YdZtM7w@mail.gmail.com>
 <35FD53F367049845BC99AC72306C23D103E688B313F2@CNBJMBX05.corpusers.net>
 <20141205143134.37139da2208c654a0d3cd942@linux-foundation.org>
 <35FD53F367049845BC99AC72306C23D103E688B313F4@CNBJMBX05.corpusers.net>
 <20141208114601.GA28846@node.dhcp.inet.fi>
 <35FD53F367049845BC99AC72306C23D103E688B313FB@CNBJMBX05.corpusers.net>
 <35FD53F367049845BC99AC72306C23D103E688B31403@CNBJMBX05.corpusers.net>
 <20141210110556.GA10630@node.dhcp.inet.fi>
Message-ID: <35FD53F367049845BC99AC72306C23D103E688B31406@CNBJMBX05.corpusers.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

> -----Original Message-----
> From: Kirill A. Shutemov [mailto:kirill at shutemov.name]
> Sent: Wednesday, December 10, 2014 7:06 PM
> To: Wang, Yalin
> Cc: 'Andrew Morton'; 'Konstantin Khlebnikov'; 'linux-
> kernel at vger.kernel.org'; 'linux-mm at kvack.org'; 'linux-arm-
> kernel at lists.infradead.org'; 'n-horiguchi at ah.jp.nec.com'; 'oleg at redhat.com';
> 'gorcunov at openvz.org'; 'pfeiner at google.com'
> Subject: Re: [RFC] mm:fix zero_page huge_zero_page rss/pss statistic
> 
> On Wed, Dec 10, 2014 at 03:22:21PM +0800, Wang, Yalin wrote:
> > smaps_pte_entry() doesn't ignore zero_huge_page, but it ignore
> > zero_page, because vm_normal_page() will ignore it. We remove
> > vm_normal_page() call, because walk_page_range() have ignore VM_PFNMAP
> > vma maps, it's safe to just use pfn_valid(), so that we can also
> > consider zero_page to be a valid page.
> 
> We fixed huge zero page accounting in smaps recentely. See mm tree.
> 
Hi 
I can't find the git, could you send me a link?
Thank you !
