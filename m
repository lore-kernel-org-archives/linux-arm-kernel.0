From: tony@atomide.com (Tony Lindgren)
Date: Thu, 8 Mar 2018 09:28:49 -0800
Subject: Build fails with SLOB in next
Message-ID: <20180308172849.GO5799@atomide.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

Looks like commit 8b1747684ff8 ("dcache: account external names as
indirectly reclaimable memory") caused build fail if SLOB is selected:

fs/dcache.c: In function '__d_free_external':
fs/dcache.c:278:22: error: implicit declaration of function
'kmalloc_index'; did you mean 'kmalloc_ node'?
[-Werror=implicit-function-declaration]
        -kmalloc_size(kmalloc_index(bytes)));
	                      ^~~~~~~~~~~~~

Is this already fixed somewhere?

Regards,

Tony
