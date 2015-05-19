From: david.vrabel@citrix.com (David Vrabel)
Date: Tue, 19 May 2015 14:57:59 +0100
Subject: [Xen-devel] [RFC 12/23] xen: Extend page_to_mfn to take an offset
 in the page
In-Reply-To: <1431622863-28575-13-git-send-email-julien.grall@citrix.com>
References: <1431622863-28575-1-git-send-email-julien.grall@citrix.com>
 <1431622863-28575-13-git-send-email-julien.grall@citrix.com>
Message-ID: <555B4167.7050506@citrix.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 14/05/15 18:00, Julien Grall wrote:
> With 64KB page granularity support in Linux, a page will be split accross
> multiple MFN (Xen is using 4KB page granularity). Thoses MFNs may not be
> contiguous.
> 
> With the offset in the page, the helper will be able to know which MFN
> the driver needs to retrieve.

I think a gnttab_grant_foreign_access_ref()-like helper that takes a
page would be better.

You will probably want this helper able to return/fill a set of refs for
64 KiB pages.

David
