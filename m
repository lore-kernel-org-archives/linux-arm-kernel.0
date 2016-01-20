From: arnd@arndb.de (Arnd Bergmann)
Date: Wed, 20 Jan 2016 23:54:46 +0100
Subject: [PATCH] net: i40e: avoid unused function warnings
In-Reply-To: <1453329885.2958.32.camel@intel.com>
References: <2806620.EpZqDlZTO3@wuerfel> <8814508.SjLecHrQqA@wuerfel>
 <1453329885.2958.32.camel@intel.com>
Message-ID: <6894276.2dlRmisKUo@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wednesday 20 January 2016 14:44:45 Jeff Kirsher wrote:
> Yeah, I have a fix for that as well.
> 
> You can confirm by pulling my next-queue tree (dev-queue branch).
> git://git.kernel.org/pub/scm/linux/kernel/git/jkirsher/next-queue.git d
> ev-queue
> 

I checked out that branch, but still see both warnings in that one, plus
a new build error in igb, which I don't see in linux-next:

drivers/net/ethernet/intel/igb/igb_cdev.c: In function 'igb_mapring':
drivers/net/ethernet/intel/igb/igb_cdev.c:150:2: error: implicit declaration of function 'set_pages_uc' [-Werror=implicit-function-declaration]
  set_pages_uc(virt_to_page(ring->desc), ring->size >> PAGE_SHIFT);
  ^
drivers/net/ethernet/intel/igb/igb_cdev.c: In function 'igb_unmapring':
drivers/net/ethernet/intel/igb/igb_cdev.c:275:2: error: implicit declaration of function 'set_pages_wb' [-Werror=implicit-function-declaration]
  set_pages_wb(virt_to_page(ring->desc), ring->size >> PAGE_SHIFT);

	Arnd
