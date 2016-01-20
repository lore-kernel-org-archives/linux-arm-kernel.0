From: jeffrey.t.kirsher@intel.com (Jeff Kirsher)
Date: Wed, 20 Jan 2016 15:36:03 -0800
Subject: [PATCH] net: i40e: avoid unused function warnings
In-Reply-To: <6894276.2dlRmisKUo@wuerfel>
References: <2806620.EpZqDlZTO3@wuerfel> <8814508.SjLecHrQqA@wuerfel>
 <1453329885.2958.32.camel@intel.com> <6894276.2dlRmisKUo@wuerfel>
Message-ID: <1453332963.2958.39.camel@intel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, 2016-01-20 at 23:54 +0100, Arnd Bergmann wrote:
> On Wednesday 20 January 2016 14:44:45 Jeff Kirsher wrote:
> > Yeah, I have a fix for that as well.
> >?
> > You can confirm by pulling my next-queue tree (dev-queue branch).
> > git://git.kernel.org/pub/scm/linux/kernel/git/jkirsher/next-
> queue.git d
> > ev-queue
> >?
> 
> I checked out that branch, but still see both warnings in that one,
> plus
> a new build error in igb, which I don't see in linux-next:
> 
> drivers/net/ethernet/intel/igb/igb_cdev.c: In function 'igb_mapring':
> drivers/net/ethernet/intel/igb/igb_cdev.c:150:2: error: implicit
> declaration of function 'set_pages_uc' [-Werror=implicit-function-
> declaration]
> ? set_pages_uc(virt_to_page(ring->desc), ring->size >> PAGE_SHIFT);
> ? ^
> drivers/net/ethernet/intel/igb/igb_cdev.c: In function
> 'igb_unmapring':
> drivers/net/ethernet/intel/igb/igb_cdev.c:275:2: error: implicit
> declaration of function 'set_pages_wb' [-Werror=implicit-function-
> declaration]
> ? set_pages_wb(virt_to_page(ring->desc), ring->size >> PAGE_SHIFT);

Oops, I just realized I had not pushed my latest tree to kernel.org.

The igb issue still remains, I am working with the developer who
introduced the issue. ?Looks like the i40e issue about possible
uninitialized variables still exists. ?I thought we had resolved that
issue, but apparently not.

You should see Eric Dumazet's patch on the tree to resolve the other
i40e build warnings.

I can add your second patch to resolve the uninitialized variables to
my tree.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 819 bytes
Desc: This is a digitally signed message part
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20160120/448ae8f2/attachment-0001.sig>
