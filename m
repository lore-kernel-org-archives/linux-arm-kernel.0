From: tony@atomide.com (Tony Lindgren)
Date: Thu, 17 Dec 2009 19:19:24 -0800
Subject: "Flush the D-cache during copy_user_highpage" breaks compile for
	v7 on -rc1
Message-ID: <20091218031923.GA4575@atomide.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Catalin,

You may have already run into this, but if not, looks like commit
115b22474eb1905da2f606a057da3455833333d3 breaks compile for v7:

arch/arm/mm/copypage-v6.c: In function 'v6_copy_user_highpage_nonaliasing':
arch/arm/mm/copypage-v6.c:51: error: implicit declaration of function '__cpuc_flush_dcache_page'

Undoing that makes it work again.

Regards,

Tony
