From: b.hutchman@gmail.com (Brian Hutchinson)
Date: Thu, 25 Feb 2010 11:14:22 -0500
Subject: External initramfs again ... keep getting "overlaps in-use memory
	region"
In-Reply-To: <3d1967ab1002250751t1ef512fehf69e3beb7f3f318e@mail.gmail.com>
References: <3d1967ab1002250751t1ef512fehf69e3beb7f3f318e@mail.gmail.com>
Message-ID: <3d1967ab1002250814q27ed0798l7e250f80c0db3fdb@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

... it looks like I'm getting the overlap message because my fixup
routine has already setup memory and then my initrd comes along and
reserve_bootmem_node tries to set the region to BOOTMEM_EXCLUSIVE.

I just don't quite know what to do about it ...

Regards,

Brian
