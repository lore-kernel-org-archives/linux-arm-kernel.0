From: kirill@shutemov.name (Kirill A. Shutemov)
Date: Tue, 2 Dec 2014 13:30:14 +0200
Subject: [RFC V2] mm:add zero_page _mapcount when mapped into user space
In-Reply-To: <35FD53F367049845BC99AC72306C23D103E688B313E0@CNBJMBX05.corpusers.net>
References: <35FD53F367049845BC99AC72306C23D103E688B313E0@CNBJMBX05.corpusers.net>
Message-ID: <20141202113014.GA22683@node.dhcp.inet.fi>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Dec 02, 2014 at 05:27:36PM +0800, Wang, Yalin wrote:
> This patch add/dec zero_page's _mapcount to make sure
> the mapcount is correct for zero_page,
> so that when read from /proc/kpagecount, zero_page's
> mapcount is also correct, userspace process like procrank can
> calculate PSS correctly.

I don't have specific code path to point to, but I would expect zero page
with non-zero mapcount would cause a problem with rmap.

How do you test the change?

-- 
 Kirill A. Shutemov
